import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_module/pages/slides/title_slide.dart';

class SlidePage extends StatelessWidget {
  const SlidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      lightTheme: FlutterDeckThemeData.light(),
      darkTheme: FlutterDeckThemeData.dark(),
      themeMode: ThemeMode.system,
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'touyou / Fujii Yosuke',
        description: 'Goodpatch, inc. Design Engineer',
        socialHandle: '@touyou_dev',
        imagePath: 'assets/logo.jpg',
      ),
      configuration: const FlutterDeckConfiguration(),
      slides: [const TitleSlide()],
    );
  }
}
