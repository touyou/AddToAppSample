import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ConclusionSlide extends FlutterDeckSlideWidget {
  ConclusionSlide({super.key, required this.step})
    : super(
        configuration: FlutterDeckSlideConfiguration(
          route: '/conclusion_$step',
          title: 'まとめ',
        ),
      );

  final int step;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckSlide.custom(
      builder: (context) {
        return SizedBox.expand(
          child: Container(
            color: Color(0xFFF8F9F6),
            child: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("まとめ", style: theme.textTheme.header),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64),
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 16,
                                  children: [
                                    Row(
                                      spacing: 16,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.blueGrey,
                                          size: 57,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: 'Liquid Glassは'),
                                              TextSpan(
                                                text: '装飾ではない',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                          style: theme.textTheme.header,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 16,
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color: Colors.blueGrey,
                                          size: 57,
                                        ),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(text: 'Flutterを'),
                                              TextSpan(
                                                text: 'コンテンツ層',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              TextSpan(text: 'と割り切れた'),
                                            ],
                                          ),
                                          style: theme.textTheme.header,
                                        ),
                                      ],
                                    ),
                                    Opacity(
                                      opacity: step >= 1 ? 1 : 0,
                                      child: Row(
                                        spacing: 16,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.blueGrey,
                                            size: 57,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text: 'Add-to-appは多用するものではない',
                                            ),
                                            style: theme.textTheme.header,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: step >= 1 ? 1 : 0,
                                      child: Row(
                                        spacing: 16,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.blueGrey,
                                            size: 57,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              text: '多分これならネイティブにした方がいい',
                                            ),
                                            style: theme.textTheme.header,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Opacity(
                                      opacity: step >= 1 ? 1 : 0,
                                      child: Row(
                                        spacing: 16,
                                        children: [
                                          Icon(
                                            Icons.check,
                                            color: Colors.blueGrey,
                                            size: 57,
                                          ),
                                          Text.rich(
                                            TextSpan(text: 'でも可能性の一つとしては面白い'),
                                            style: theme.textTheme.header,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlutterDeckFooter.fromConfiguration(
                  configuration: context.flutterDeck.configuration.footer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
