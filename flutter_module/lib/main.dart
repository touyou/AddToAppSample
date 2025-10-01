import 'package:flutter/material.dart';
import 'package:flutter_module/pages/favorites_page.dart';
import 'package:flutter_module/pages/home_page.dart';
import 'package:flutter_module/pages/search_page.dart';
import 'package:flutter_module/pages/slide_page.dart';

void main() => runApp(const MyApp());

@pragma('vm:entry-point')
void slide() => runApp(const SlidePage());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/favorites': (context) => const FavoritesPage(),
        '/search': (context) => const SearchPage(),
      },
      initialRoute: '/',
    );
  }
}
