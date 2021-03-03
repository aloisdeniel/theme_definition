import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class DurationPreviewTile extends StatelessWidget {
  const DurationPreviewTile({
    Key? key,
    required this.name,
    required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<Duration>> variants;

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
                  Text(
                    '${value.inMilliseconds}ms',
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
