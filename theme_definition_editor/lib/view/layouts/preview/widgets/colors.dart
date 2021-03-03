import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class ColorPreviewTile extends StatelessWidget {
  const ColorPreviewTile({
    Key? key,
    required this.name,
    required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.Color>> variants;

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
          (variant) => SizedBox(
            width: 200,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: const Color(0x22000000)),
                    color: Color(
                      int.parse(variant.getValue(name).hexValue, radix: 16),
                    ),
                  ),
                ),
                SizedBox(height: theme.spacing.small),
                Text(
                  '#${variant.getValue(name).hexValue}',
                  style: theme.fontStyles.content.copyWith(
                    color: theme.colors.foreground2,
                    fontSize: theme.fontSizes.small,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
