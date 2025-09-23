import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FavoritesPage extends HookWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Favorites Page'),
          ],
        ),
      ),
    );
  }
}
