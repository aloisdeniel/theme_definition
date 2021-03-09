import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:path_icon/path_icon.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class ConfigurationTile extends StatelessWidget {
  const ConfigurationTile({
    Key? key,
    required this.path,
    required this.variants,
  }) : super(key: key);

  final List<String> path;
  final List<definition.ConfigurationSet> variants;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    final level = path.length - 1;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...Iterable.generate(
                level,
                (i) => PathIcon(
                  theme.icons.pointLine,
                  size: theme.fontSizes.regular,
                  color: theme.colors.foreground2.withOpacity(0.3),
                ),
              ),
              if (level > 0) ...[
                PathIcon(
                  theme.icons.cornerLine,
                  size: theme.fontSizes.regular,
                  color: theme.colors.foreground2,
                ),
                SizedBox(width: theme.spacing.semiSmall),
              ],
              Text(
                path.last,
                style: theme.fontStyles.content.copyWith(
                  color: theme.colors.foreground1,
                  fontSize: theme.fontSizes.regular,
                ),
              ),
            ],
          ),
        ),
        ...variants.map(
          (variant) {
            final value = variant.configuration.valueForPath(path);
            return SizedBox(
              width: 200,
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: theme.fontStyles.content.copyWith(
                  color: theme.colors.foreground1,
                  fontSize: theme.fontSizes.small,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
