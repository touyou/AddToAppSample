import 'package:flutter/material.dart';
import 'package:flutter_module/pages/detail_page.dart';
import 'package:flutter_module/pages/favorites_page.dart';
import 'package:flutter_module/pages/home_page.dart';
import 'package:flutter_module/pages/search_page.dart';
import 'package:flutter_module/pages/slide_page.dart';

void main() => runApp(const MyApp());

@pragma('vm:entry-point')
void slide() => runApp(const SlidePage());

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchPage());
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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
