import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SplitCodeAndImageSlide extends FlutterDeckSlideWidget {
  SplitCodeAndImageSlide({
    super.key,
    required this.route,
    required this.image,
    required this.code,
  }) : super(configuration: FlutterDeckSlideConfiguration(route: route));

  final String route;
  final Widget image;
  final Widget code;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return Center(child: image);
      },
      rightBuilder: (context) {
        return Center(child: code);
      },
    );
  }
}
