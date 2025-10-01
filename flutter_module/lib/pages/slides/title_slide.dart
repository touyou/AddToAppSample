import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter/material.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide({super.key}) : super(
    configuration: const FlutterDeckSlideConfiguration(
      route: '/title-slide',
      title: 'Title slide',
      footer: FlutterDeckFooterConfiguration(showFooter: false),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Add-to-appで真のLiquid Glass対応を目指してみた',
    );
  }
}
