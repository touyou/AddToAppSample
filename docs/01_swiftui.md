# SwiftUI に関する話

## SwiftUI について

- Environment の要素を bind させるには`@Binable var taskPresenter = taskPresenter`といった記述を`body`の冒頭に書く
- Tab を隠すには`.toolbarVisibility(.hidden, for: .tabBar)`を使用
- サイドバーを有効化するには`.tabViewStyle(.sidebarAdaptable)`を`TabView`に対して指定する
- サーチタブからの検索を有効化するには`Tab(role: .search)`を使った上で`.searchable`を`TabView`に対して指定する
- 全体の SSoT を`@Observable`にする
  - `@AppStorage`など管理対象にしたくないものには`@ObservationIgnored`を指定する
- App Groups を AppStorage で使うには`@AppStorage("key", store: .init(suiteName: "group.identifier"))`のように指定する
- 画面遷移は`[Tabs: [NavigationDestination]]`のように辞書で管理する
  - 個別のタブでは以下のように Binding を定義しておく

```swift
var body: some View {
  @Bindable var presenter = presenter
  let homePath = Binding<[NavigationDestination]>(
    get: { presenter.path[.home] ?? [] },
    set: { presenter.path[.home] = $0 }
  )
  // ...
}
```

## Widget について

- Widget の Liquid Glass 対応は`widgetAccentedRenderingMode(_:)`を使用
- 上記はあくまで`Image`に対して有効な API なので、`interpolation`や`resizable`の後であれば問題ないが、`accessibilityLabel`などの後ろに置くと使えない
- App Intents 活用としては`WidgetConfigurationIntent`を利用する
  - この時 Provider は`AppIntentTimelineProvider`を利用
  - `WidgetConfiguration`は`AppIntentConfiguration`を利用
- メッセージを表示するだけなどであれば`StaticConfiguration`を利用するのが良い
- データを明示して更新したい際は`WidgetCenter.shared.reloadAllTimelines()`を利用する
