import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_builder/localization_builder.dart'
    as localization_builder;
import 'package:path_icon/path_icon.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class LabelTile extends StatelessWidget {
  const LabelTile({
    Key? key,
    required this.level,
    required this.name,
    required this.languageCodes,
    required this.label,
  }) : super(key: key);

  final int level;
  final String name;
  final List<String> languageCodes;
  final localization_builder.Label label;
  static final _templateRegexp = RegExp(r'\{\{[^\{\}]+\}\}');

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
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
                name,
                style: theme.fontStyles.content.copyWith(
                  color: theme.colors.foreground1,
                  fontSize: theme.fontSizes.regular,
                ),
              ),
            ],
          ),
        ),
        ...languageCodes.map(
          (languageCode) {
            final cases = label.cases
                .map(
                  (c) => MapEntry(
                    c,
                    c.translations
                        .firstWhere((x) => x.languageCode == languageCode),
                  ),
                )
                .toList();
            return SizedBox(
              width: 200,
              child: Column(
                children: [
                  ...cases.expand(
                    (c) {
                      final condition = c.key.condition;
                      final value = c.value.value;
                      Widget text;
                      final baseStyle = theme.fontStyles.content.copyWith(
                        color: theme.colors.foreground1,
                        fontSize: theme.fontSizes.small,
                      );
                      if (c.key.templatedValues.isNotEmpty) {
                        final matches = _templateRegexp.allMatches(value);
                        final spans = <TextSpan>[];
                        int previousEnd = 0;
                        for (var match in matches) {
                          if (match.start - previousEnd > 0) {
                            spans.add(
                              TextSpan(
                                text: value.substring(previousEnd, match.start),
                              ),
                            );
                          }

                          spans.add(
                            TextSpan(
                              text: value.substring(match.start, match.end),
                              style: baseStyle.copyWith(
                                  color: theme.colors.accent1),
                            ),
                          );

                          previousEnd = match.end;
                        }

                        if (value.length - previousEnd > 0) {
                          spans.add(
                            TextSpan(
                              text: value.substring(previousEnd, value.length),
                            ),
                          );
                        }

                        text = RichText(
                          text: TextSpan(
                            children: spans,
                            style: baseStyle,
                          ),
                        );
                      } else {
                        text = Text(
                          value,
                          style: theme.fontStyles.content.copyWith(
                            color: theme.colors.foreground1,
                            fontSize: theme.fontSizes.small,
                          ),
                        );
                      }
                      return [
                        text,
                        if (condition
                            is localization_builder.CategoryCondition) ...[
                          Text(
                            '${condition.category.name}.${condition.value}',
                            style: theme.fontStyles.content.copyWith(
                              color: theme.colors.foreground3,
                              fontSize: theme.fontSizes.small,
                            ),
                          ),
                          SizedBox(height: theme.spacing.small),
                        ],
                      ];
                    },
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
