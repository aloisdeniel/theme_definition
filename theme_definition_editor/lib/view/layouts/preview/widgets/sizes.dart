import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class SizePreviewTile extends StatelessWidget {
  const SizePreviewTile({
    Key key,
    @required this.name,
    @required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.Size>> variants;

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
            return SizedBox(
              width: 200,
              child: Column(
                children: [
                  Container(
                    width: value.width,
                    height: value.height,
                    decoration: BoxDecoration(
                      color: theme.colors.foreground1.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(height: theme.spacing.small),
                  Text(
                    '${value.width}x${value.height}',
                    style: theme.fontStyles.content.copyWith(
                      color: theme.colors.foreground1,
                      fontSize: theme.fontSizes.small,
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
