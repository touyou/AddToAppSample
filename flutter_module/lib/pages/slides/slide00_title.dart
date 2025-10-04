import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter/material.dart';

const _imageHeight = 160.0;

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide({super.key})
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/title',
          title: 'Add-to-appで真のLiquid Glass対応を目指してみた',
          footer: FlutterDeckFooterConfiguration(showFooter: false),
          initial: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.title(
      title: 'Add-to-appで\n真のLiquid Glass対応を目指してみた',
      speakerInfoBuilder: (context) {
        final theme = FlutterDeckSpeakerInfoWidgetTheme.of(context);
        final speakerInfo = context.flutterDeck.speakerInfo;
        if (speakerInfo == null) return const SizedBox.shrink();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                speakerInfo.imagePath,
                height: _imageHeight,
                width: _imageHeight,
              ),
            ),
            const SizedBox(width: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(speakerInfo.name, style: theme.nameTextStyle, maxLines: 1),
                Text(
                  speakerInfo.description,
                  style: theme.descriptionTextStyle,
                  maxLines: 1,
                ),
                Text(
                  speakerInfo.socialHandle,
                  style: theme.socialHandleTextStyle,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
