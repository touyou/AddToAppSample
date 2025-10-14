import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class DemoLiquidSlide extends FlutterDeckSlideWidget {
  DemoLiquidSlide({super.key, required this.step})
    : super(
        configuration: FlutterDeckSlideConfiguration(
          route: '/demo_liquid_$step',
          title: 'デモ',
        ),
      );

  final int step;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      leftBuilder: (context) {
        return const DemoLeftWidget();
      },
      rightBuilder: (context) {
        if (step == 0) {
          return const SizedBox.shrink();
        }
        return const DemoRightWidget();
      },
    );
  }
}

class DemoRightWidget extends HookWidget {
  const DemoRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
      upperBound: 100,
    );
    useAnimation(controller);

    useEffect(() {
      controller.repeat(reverse: true);
      return null;
    }, []);

    return Column(
      children: [
        Text(
          "×",
          style: FlutterDeckTheme.of(context).textTheme.header.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.w900,
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // This is the content that will be behind the glass
              Positioned.fill(
                child: Image.asset('assets/logo.jpg', fit: BoxFit.cover),
              ),
              // The LiquidGlass widget sits on top
              Center(
                child: LiquidGlass(
                  shape: LiquidRoundedSuperellipse(
                    borderRadius: Radius.circular(50),
                  ),
                  settings: LiquidGlassSettings(blur: 10),
                  child: const SizedBox(
                    height: 200,
                    width: 200,
                    child: Center(child: FlutterLogo(size: 100)),
                  ),
                ),
              ),
              Center(
                child: LiquidGlassLayer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LiquidGlass.inLayer(
                        shape: LiquidRoundedSuperellipse(
                          borderRadius: Radius.circular(40),
                        ),
                        child: const SizedBox.square(dimension: 100),
                      ),
                      SizedBox(height: controller.value),
                      LiquidGlass.inLayer(
                        shape: LiquidRoundedSuperellipse(
                          borderRadius: Radius.circular(40),
                        ),
                        child: const SizedBox.square(dimension: 100),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DemoLeftWidget extends HookWidget {
  const DemoLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final switchValue = useState(false);
    final tabIndex = useState(0);
    final segmentIndex = useState(0);
    final sliderValue = useState(0.0);
    final items = [
      const CNPopupMenuItem(label: 'New File', icon: CNSymbol('doc', size: 18)),
      const CNPopupMenuItem(
        label: 'New Folder',
        icon: CNSymbol('folder', size: 18),
      ),
      const CNPopupMenuDivider(),
      const CNPopupMenuItem(
        label: 'Rename',
        icon: CNSymbol('rectangle.and.pencil.and.ellipsis', size: 18),
      ),
    ];
    return Column(
      children: [
        Text(
          "◯",
          style: FlutterDeckTheme.of(context).textTheme.header.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w900,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CNSlider(
                value: sliderValue.value,
                min: 0,
                max: 100,
                onChanged: (v) => sliderValue.value = v,
              ),
              CNSwitch(
                value: switchValue.value,
                onChanged: (value) {
                  switchValue.value = value;
                },
              ),
              CNPopupMenuButton(
                buttonLabel: 'Popup Menu',
                items: items,
                onSelected: (index) {
                  // Handle selection
                },
              ),
              CNSegmentedControl(
                labels: const ['One', 'Two', 'Three'],
                selectedIndex: segmentIndex.value,
                onValueChanged: (i) => segmentIndex.value = i,
              ),
              CNTabBar(
                items: const [
                  CNTabBarItem(label: 'Home', icon: CNSymbol('house.fill')),
                  CNTabBarItem(
                    label: 'Profile',
                    icon: CNSymbol('person.crop.circle'),
                  ),
                  CNTabBarItem(
                    label: 'Settings',
                    icon: CNSymbol('gearshape.fill'),
                  ),
                ],
                currentIndex: tabIndex.value,
                onTap: (i) => tabIndex.value = i,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
