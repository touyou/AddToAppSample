# Flutter に関する話

## ルーティングライブラリを使わない場合の複雑なルーティング方法

- `MaterialApp`などでは`onGenerateRoute`を用いる
- 定義する関数の型は`Route<dyanmic> Function(RouteSettings settings)`
- パラメーターを受け取る場合は文字列操作がこの場合必要になる（go_router などではここら辺を生成コードでやってくれているはず）

```dart
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ...
      default:
        if (settings.name != null && settings.name!.startsWith('/detail/')) {
          final uri = Uri.parse(settings.name!);
          final id = int.parse(uri.pathSegments[1]);
          return MaterialPageRoute(builder: (_) => DetailPage(id: id));
        }
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
```
