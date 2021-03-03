import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_definition/theme_definition.dart' as definition;
import 'package:theme_definition_editor/view/theme/theme.dart';

class FontSizeStylePreviewTile extends StatelessWidget {
  const FontSizeStylePreviewTile({
    Key? key,
    required this.name,
    required this.variants,
  }) : super(key: key);

  final String name;
  final List<definition.VariantSet<definition.FontSize>> variants;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            name,
            style: GoogleFonts.firaCode(
              color: theme.colors.foreground1,
              fontSize: 12,
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
                        Text(
                          'Hello world',
                          style: theme.fontStyles.content.copyWith(
                            color: theme.colors.foreground1,
                            fontSize: value.value,
                          ),
                        ),
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
