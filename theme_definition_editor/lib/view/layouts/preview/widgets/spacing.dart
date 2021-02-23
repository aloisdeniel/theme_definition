import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class SpacingStylePreviewTile extends StatelessWidget {
  const SpacingStylePreviewTile({
    Key key,
    @required this.name,
    @required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.Spacing>> variants;

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
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 2,
                            height: 16,
                            color: theme.colors.foreground1),
                        Container(
                            width: value.value,
                            height: 4,
                            color: theme.colors.foreground1.withOpacity(0.4)),
                        Container(
                            width: 2,
                            height: 16,
                            color: theme.colors.foreground1),
                      ],
                    ),
                    Text(
                      value.value.toString(),
                      style: theme.fontStyles.content.copyWith(
                        color: theme.colors.foreground2,
                        fontSize: theme.fontSizes.small,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
