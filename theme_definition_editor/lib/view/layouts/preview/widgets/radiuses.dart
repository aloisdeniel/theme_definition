import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class RadiusPreviewTile extends StatelessWidget {
  const RadiusPreviewTile({
    Key key,
    @required this.name,
    @required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.Radius>> variants;

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
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(value.value),
                      ),
                      color: theme.colors.foreground1.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        '${variant.getValue(name).value}',
                        style: theme.fontStyles.content.copyWith(
                          color: theme.colors.foreground1,
                          fontSize: theme.fontSizes.small,
                        ),
                      ),
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
