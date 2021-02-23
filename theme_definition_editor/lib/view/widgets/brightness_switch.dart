import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:theme_definition_editor/state/editor/state.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class BrightnessSwitch extends StatelessWidget {
  const BrightnessSwitch({
    Key key,
    @required this.value,
    @required this.onValueChanged,
  }) : super(key: key);

  final BrightnessMode value;
  final ValueChanged<BrightnessMode> onValueChanged;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return Row(
      children: [
        PathIcon(
          theme.icons.moon,
          size: theme.fontSizes.regular * 1.5,
          color: theme.colors.foreground2,
        ),
        PathIcon(
          theme.icons.sun,
          size: theme.fontSizes.regular * 1.5,
          color: theme.colors.foreground2,
        ),
      ],
    );
  }
}
