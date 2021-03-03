import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:tap_builder/tap_builder.dart';
import 'package:theme_definition_editor/state/editor/state.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class BrightnessSwitch extends StatelessWidget {
  const BrightnessSwitch({
    Key? key,
    required this.value,
    required this.onValueChanged,
  }) : super(key: key);

  final BrightnessMode value;
  final ValueChanged<BrightnessMode> onValueChanged;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    const iconSize = 1.2;
    return TapBuilder(
      onTap: () => onValueChanged(value == BrightnessMode.dark
          ? BrightnessMode.light
          : BrightnessMode.dark),
      builder: (context, state) => Row(
        children: [
          AnimatedCrossFade(
            crossFadeState: value == BrightnessMode.dark
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: theme.durations.regular,
            firstChild: AnimatedPathIcon(
              theme.icons.moon,
              duration: theme.durations.regular,
              size: theme.fontSizes.regular * iconSize,
              color: theme.colors.foreground2,
            ),
            secondChild: YamlTheme(
              data: theme.copyWith(icons: YamlIconsData.filled()),
              child: Builder(
                builder: (context) => AnimatedPathIcon(
                  YamlTheme.of(context).icons.moon,
                  duration: theme.durations.regular,
                  size: theme.fontSizes.regular * iconSize,
                  color: theme.colors.foreground2,
                ),
              ),
            ),
          ),
          SizedBox(width: theme.spacing.small),
          AnimatedContainer(
            duration: theme.durations.regular,
            height: theme.fontSizes.regular * 0.8,
            width: theme.fontSizes.regular * 1.6,
            decoration: BoxDecoration(
              borderRadius: theme.borderRadiuses.big,
              gradient: LinearGradient(
                colors: [
                  theme.colors.foreground2
                      .withOpacity(value == BrightnessMode.dark ? 1.0 : 0.0),
                  theme.colors.foreground2
                      .withOpacity(value == BrightnessMode.light ? 1.0 : 0.0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          SizedBox(width: theme.spacing.small),
          AnimatedCrossFade(
            crossFadeState: value == BrightnessMode.light
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: theme.durations.regular,
            firstChild: AnimatedPathIcon(
              theme.icons.sun,
              duration: theme.durations.regular,
              size: theme.fontSizes.regular * iconSize,
              color: theme.colors.foreground2,
            ),
            secondChild: YamlTheme(
              data: theme.copyWith(icons: YamlIconsData.filled()),
              child: Builder(
                builder: (context) => AnimatedPathIcon(
                  YamlTheme.of(context).icons.sun,
                  duration: theme.durations.regular,
                  size: theme.fontSizes.regular * iconSize,
                  color: theme.colors.foreground2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
