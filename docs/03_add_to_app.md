# Add-to-app について

- データ通信は[Pigeon](https://pub.dev/packages/pigeon)を使用
- これによってデータ連携で考えることが減る

## HostApi について

```dart
// swiftOutをSwiftUI側に行くようにする
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeons/pigeon_host_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: '../App/AddToAppSample/Flutter/PigeonHostApi.swift',
    swiftOptions: SwiftOptions(),
  ),
)

// データクラスは普通に定義
class Item {
  // ...

  final int id;
  final String title;
  final bool isDone;
  final bool isFavorite;
}

@HostApi()
abstract class TaskHostApi {
  // 非同期であれば@asyncをつける
  @async
  List<Item> getItems();

  // 通常はそのまま定義するだけでいい
  bool getIsFiltered();

  // ...

  // Swift側の引数名を指定したい場合は@SwiftFunctionを使用
  @SwiftFunction('goToDetail(id:)')
  void goToDetail(int id);

  // ...
}
```

- SwiftUI 側では準拠しているクラスがあればいい
- そのため丸ごと`@Observable`にしても問題ない

```swift
@MainActor
@Observable
class TaskPresenter: TaskHostApi {
  // ...
}
```

- `setUp`をそれぞれの FlutterEngine に対して呼び出す必要がある
- これを実現するために、FlutterEngineGroup を管理する`@Observable`を用意した

```swift
@Observable
class FlutterDependencies {
    private let flutterEngineGroup = FlutterEngineGroup(name: "flutter engine", project: nil)
    // ここにHostApi準拠のPresenterを用意
    @ObservationIgnored lazy var taskPresenter: TaskPresenter = {
        TaskPresenter(
            // ...
        )
    }()

    // ...

    func makeFlutterViewController(withInitialRoute initialRoute: String, entryPoint: String = "main") -> FlutterViewController {
        // FlutterEngineGroupからエンジンを生成
        let engine = flutterEngineGroup.makeEngine(
          withEntrypoint: entryPoint,
          libraryURI: nil,
          initialRoute: initialRoute
        )
        // エンジンの初期化
        GeneratedPluginRegistrant.register(with: engine)
        // HostApiのセットアップを行う
        TaskHostApiSetup.setUp(
          binaryMessenger: engine.binaryMessenger,
          api: taskPresenter
        )
        // ...
    }
}
```

## FlutterApi について

```dart
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/pigeons/pigeon_flutter_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut: '../App/AddToAppSample/Flutter/PigeonFlutterApi.swift',
    swiftOptions: SwiftOptions(includeErrorClass: false),
  ),
)
@FlutterApi()
abstract class TaskFlutterApi {
  void onItemsUpdated();

  void onSearchQueryChanged(String query);
}
```

- 基本的にコールバック系が多い
- Flutter 側では必要な画面でそれぞれの処理を渡して利用する
- SwiftUI 側は配列等に入れて、HostApi 側から呼び出せるようにしておくことで SwiftUI 側のイベントからも利用できるようになる

```swift
@Observable
class FlutterDependencies {
    @ObservationIgnored lazy var taskPresenter: TaskPresenter = {
        TaskPresenter(
            // HostApi側から呼び出せるようにしておく
            onUpdateItems: { [weak self] in
                guard let self else { return }
                self.flutterApis.forEach { api in
                    api.onItemsUpdated(completion: { result in
                        switch result {
                        case .success:
                            break
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    })
                }
            },
            // ...
        )
    }()
    // 配列で保持
    var flutterApis: [TaskFlutterApi]

    func makeFlutterViewController(withInitialRoute initialRoute: String, entryPoint: String = "main") -> FlutterViewController {
        let engine = flutterEngineGroup.makeEngine(withEntrypoint: entryPoint, libraryURI: nil, initialRoute: initialRoute)
        // ...
        flutterApis.append(TaskFlutterApi(binaryMessenger: engine.binaryMessenger))
        return FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    }
}
```

## その他統合方法について

- 基本的に`FlutterView`に`FlutterDependencies`の基本操作はまとめて簡単に扱えるようにした
- entryPoint は基本統一して Flutter 側の`RouteGenerator`で振り分けをしている
  - パラメータを含めることは標準では対応していないため、文字列操作を`onGenerateRoute`内で行うようにした
- 明確に分けたい場合は`@pragma('vm:entry-point')`を使うことでエントリーポイントを分けられる
- エントリーポイント名は関数名と一致する

## パフォーマンスに関して

- 現状、クリティカルな問題が発生するわけではない
- ただし初期化コストが高め。そのため実機で動かすと最初に画面が表示されるまで時間がかかっている印象
- データ連動などは意外とスムーズに動いている
