import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class GithubIssueSlide extends FlutterDeckSlideWidget {
  const GithubIssueSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/github_issue',
          title: 'すべてのきっかけとなったissue',
        ),
      );

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
                        Text("Flutterでの動き", style: theme.textTheme.header),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.asset(
                              'assets/liquid_issue.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          "https://github.com/flutter/flutter/issues/170310",
                          style: theme.textTheme.bodyMedium,
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
