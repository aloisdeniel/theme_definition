import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class EditorAppBar extends StatelessWidget {
  const EditorAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return Container(
      color: theme.colors.background2,
      padding: theme.edgeInsets.semiBig,
      height: theme.fontSizes.regular * 5,
      child: Row(
        children: [
          AnimatedPathIcon(
            theme.icons.textEdit,
            duration: theme.durations.regular,
            size: theme.fontSizes.regular * 1.5,
            color: theme.colors.foreground2,
          ),
          SizedBox(width: theme.spacing.regular),
          Text(
            'Yaml Theme Editor',
            style: theme.fontStyles.title.copyWith(
              color: theme.colors.foreground2,
              fontSize: theme.fontSizes.regular,
            ),
          ),
        ],
      ),
    );
  }
}
