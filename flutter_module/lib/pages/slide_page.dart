import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_module/pages/slides/conclusion.dart';
import 'package:flutter_module/pages/slides/demo_liquid.dart';
import 'package:flutter_module/pages/slides/github_issue.dart';
import 'package:flutter_module/pages/slides/slide00_title.dart';
import 'package:flutter_module/pages/slides/split_code_and_image.dart';
import 'package:google_fonts/google_fonts.dart';

class SlidePage extends StatelessWidget {
  const SlidePage({super.key});

  static const defaultDeckTextTheme = FlutterDeckTextTheme();

  @override
  Widget build(BuildContext context) {
    final notoSansTextTheme = FlutterDeckTextTheme(
      display: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.display.fontSize,
        fontWeight: defaultDeckTextTheme.display.fontWeight,
      ),
      header: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.header.fontSize,
        fontWeight: defaultDeckTextTheme.header.fontWeight,
      ),
      title: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.title.fontSize,
        fontWeight: defaultDeckTextTheme.title.fontWeight,
      ),
      subtitle: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.subtitle.fontSize,
        fontWeight: defaultDeckTextTheme.subtitle.fontWeight,
      ),
      bodyLarge: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.bodyLarge.fontSize,
        fontWeight: defaultDeckTextTheme.bodyLarge.fontWeight,
      ),
      bodyMedium: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.bodyMedium.fontSize,
        fontWeight: defaultDeckTextTheme.bodyMedium.fontWeight,
      ),
      bodySmall: GoogleFonts.notoSansJp(
        fontSize: defaultDeckTextTheme.bodySmall.fontSize,
        fontWeight: defaultDeckTextTheme.bodySmall.fontWeight,
      ),
    );

    return FlutterDeckApp(
      lightTheme:
          FlutterDeckThemeData.fromThemeAndText(
            ThemeData.light(),
            notoSansTextTheme,
          ).copyWith(
            splitSlideTheme: FlutterDeckSplitSlideThemeData(
              leftBackgroundColor: Color(0xFFF8F9F6),
              rightBackgroundColor: Colors.white60,
            ),
          ),
      darkTheme:
          FlutterDeckThemeData.fromThemeAndText(
            ThemeData.dark(),
            notoSansTextTheme,
          ).copyWith(
            splitSlideTheme: FlutterDeckSplitSlideThemeData(
              leftBackgroundColor: Color(0xFFF8F9F6),
              rightBackgroundColor: Colors.white60,
            ),
          ),
      themeMode: ThemeMode.system,
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'touyou / Fujii Yosuke',
        description: 'Goodpatch Inc. Design Engineer',
        socialHandle: '@touyou_dev',
        imagePath: 'assets/logo.jpg',
      ),
      configuration: const FlutterDeckConfiguration(
        background: FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.solid(Color(0xFFF8F9F6)),
        ),
        footer: FlutterDeckFooterConfiguration(
          showFooter: true,
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
      ),
      slides: [
        const TitleSlide(),
        FlutterDeckSlide.bigFact(title: "iOS/iPadOS 26"),
        FlutterDeckSlide.bigFact(title: "Liquid Glass"),
        FlutterDeckSlide.bigFact(title: "Liquid Glass、つかえていますか？"),
        FlutterDeckSlide.quote(quote: "Liquid Glassで\nFlutterの危機が訪れるのではないか？"),
        GithubIssueSlide(),
        FlutterDeckSlide.bigFact(title: "そもそもLiquid Glassとは？"),
        FlutterDeckSlide.image(
          imageBuilder: (context) =>
              Image.asset('assets/liquid_glass_presen.jpg'),
          label:
              "https://goodpatch-tech.hatenablog.com/entry/liquid_glass_and_app_intents",
        ),
        FlutterDeckSlide.quote(
          quote: "Liquid Glassとは\nコンテンツ層とナビゲーション・コントロール層を\n分離するための表現手法である",
        ),
        FlutterDeckSlide.image(
          imageBuilder: (context) => Image.asset('assets/liquid_glass_hig.png'),
          label:
              "https://developer.apple.com/jp/design/human-interface-guidelines/materials",
        ),
        DemoLiquidSlide(step: 0),
        DemoLiquidSlide(step: 1),
        FlutterDeckSlide.bigFact(title: "Liquid Glassはコンテンツ層で使うべきではない"),
        FlutterDeckSlide.bigFact(title: "FlutterでLiquid Glassをちゃんと使うのは難しい"),
        FlutterDeckSlide.bigFact(title: "ならば、Flutterはコンテンツ層である、と割り切ればいいのでは？"),
        FlutterDeckSlide.bigFact(
          title: "Flutterがコンテンツ層で、ナビゲーション・コントロール層がネイティブ",
        ),
        FlutterDeckSlide.image(
          imageBuilder: (context) => Image.asset('assets/liquid_glass_hig.png'),
          label: "Flutterがコンテンツ層で、ナビゲーション・コントロール層がネイティブ",
        ),
        FlutterDeckSlide.bigFact(title: "Add-to-app"),
        FlutterDeckSlide.bigFact(title: "Demo"),
        SplitCodeAndImageSlide(
          route: '/demo-step-1',
          image: Image.asset('assets/liquid_glass_hig.png'),
          code: FlutterDeckCodeHighlight(
            code: '''
import 'package:pigeon/pigeon.dart';

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
''',
            fileName: 'pigeon_flutter_api.dart',
            language: 'dart',
          ),
        ),
        ConclusionSlide(step: 0),
        ConclusionSlide(step: 1),
      ],
    );
  }
}
