import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_icon/path_icon.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class IconPreviewTile extends StatelessWidget {
  const IconPreviewTile({
    Key key,
    @required this.name,
    @required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.Icon>> variants;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            name,
            style: theme.fontStyles.content.copyWith(
              color: theme.colors.foreground1,
              fontSize: theme.fontSizes.regular,
            ),
          ),
        ),
        ...variants.map(
          (variant) {
            final value = variant.getValue(name);
            final data = value.data.toLowerCase().contains('<svg')
                ? PathIconData.fromSvg(value.data)
                : PathIconData.fromData(value.data);
            return SizedBox(
              width: 200,
              child: Column(
                children: [
                  PathIcon(
                    data,
                    color: theme.colors.foreground1,
                    size: 24,
                  ),
                  SizedBox(height: theme.spacing.small),
                  Text(
                    '${data.viewBox.width}x${data.viewBox.height}',
                    style: theme.fontStyles.content.copyWith(
                      color: theme.colors.foreground2,
                      fontSize: theme.fontSizes.small,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
