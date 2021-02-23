import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class FontStylePreviewTile extends StatelessWidget {
  const FontStylePreviewTile({
    Key key,
    @required this.name,
    @required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.FontStyle>> variants;

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
            final fontWeight = FontWeight
                .values[((value.fontWeight ?? 400).toInt() ~/ 100) - 1];
            TextStyle style;
            try {
              style = value.fontFamily == null
                  ? TextStyle(
                      fontWeight: fontWeight,
                      color: theme.colors.foreground1,
                    )
                  : GoogleFonts.getFont(
                      value.fontFamily,
                      fontWeight: fontWeight,
                      color: theme.colors.foreground1,
                    );
            } catch (e) {
              style = TextStyle(
                fontWeight: fontWeight,
              );
            }

            return SizedBox(
              width: 200,
              child: Column(
                children: [
                  Text(
                    'Hello world',
                    style: style,
                  ),
                  if (value.fontFamily != null)
                    Text(
                      value.fontFamily,
                      style: theme.fontStyles.content.copyWith(
                        color: theme.colors.foreground2,
                        fontSize: theme.fontSizes.small,
                      ),
                    ),
                  if (value.fontWeight != null)
                    Text(
                      'w${value.fontWeight}',
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
