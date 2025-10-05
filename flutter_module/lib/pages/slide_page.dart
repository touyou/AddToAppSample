import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_module/pages/slides/slide00_title.dart';
import 'package:google_fonts/google_fonts.dart';

class SlidePage extends StatelessWidget {
  const SlidePage({super.key});

  static const defaultDeckTextTheme = FlutterDeckTextTheme();

  @override
  Widget build(BuildContext context) {
    final bizUdpTextTheme = FlutterDeckTextTheme(
      display: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.display.fontSize,
        fontWeight: defaultDeckTextTheme.display.fontWeight,
      ),
      header: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.header.fontSize,
        fontWeight: defaultDeckTextTheme.header.fontWeight,
      ),
      title: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.title.fontSize,
        fontWeight: defaultDeckTextTheme.title.fontWeight,
      ),
      subtitle: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.subtitle.fontSize,
        fontWeight: defaultDeckTextTheme.subtitle.fontWeight,
      ),
      bodyLarge: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.bodyLarge.fontSize,
        fontWeight: defaultDeckTextTheme.bodyLarge.fontWeight,
      ),
      bodyMedium: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.bodyMedium.fontSize,
        fontWeight: defaultDeckTextTheme.bodyMedium.fontWeight,
      ),
      bodySmall: GoogleFonts.bizUDPGothic(
        fontSize: defaultDeckTextTheme.bodySmall.fontSize,
        fontWeight: defaultDeckTextTheme.bodySmall.fontWeight,
      ),
    );

    return FlutterDeckApp(
      lightTheme: FlutterDeckThemeData.fromThemeAndText(
        ThemeData.light(),
        bizUdpTextTheme,
      ),
      darkTheme: FlutterDeckThemeData.fromThemeAndText(
        ThemeData.dark(),
        bizUdpTextTheme,
      ),
      themeMode: ThemeMode.system,
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'touyou / Fujii Yosuke',
        description: 'Goodpatch, inc. Design Engineer',
        socialHandle: '@touyou_dev',
        imagePath: 'assets/logo.jpg',
      ),
      configuration: const FlutterDeckConfiguration(
        background: FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.solid(Color(0xFFF8F9F6)),
        ),
      ),
      slides: [
        const TitleSlide(),
        FlutterDeckSlide.bigFact(title: 'こんにちは'),
        FlutterDeckSlide.bigFact(title: '突然ですがみなさん、'),
        FlutterDeckSlide.bigFact(title: 'Liquid Glass、ご存知ですか？'),
        FlutterDeckSlide.bigFact(title: 'Liquid Glassの本質、知ってますか？'),
        FlutterDeckSlide.bigFact(title: 'オシャレな装飾！'),
        FlutterDeckSlide.bigFact(title: 'ではありません。'),
        FlutterDeckSlide.bigFact(
          title: 'あれはコンテンツ層とコントロール・ナビゲーション層を分離するためのマテリアルです。',
        ),
        FlutterDeckSlide.bigFact(
          title: 'アクセシビリティ設定に応じて、見た目が変わり、バージョン間でも調整が入ります。',
        ),
        FlutterDeckSlide.bigFact(
          title: 'Flutterにはliquid_glass_rendererというパッケージがありますが',
        ),
        FlutterDeckSlide.bigFact(title: 'これだとLiquid Glassの本質を満たせません。'),
        FlutterDeckSlide.bigFact(title: 'Flutterはやっぱり取り残されてしまうのか？'),
        FlutterDeckSlide.bigFact(title: 'アイデア：Flutterをコンテンツ層にしてしまえば良いのでは？'),
        FlutterDeckSlide.bigFact(title: 'やってみました'),
        FlutterDeckSlide.bigFact(title: 'Add-to-appをゴリゴリに使います'),
      ],
    );
  }
}
