import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition/theme_definition.dart' as d;
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/editor/update.dart';
import 'package:theme_definition_editor/view/notifier.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';
import 'package:theme_definition_editor/view/widgets/text_editor.dart';

class YamlEditor extends StatelessWidget {
  const YamlEditor({
    Key? key,
  }) : super(key: key);

  TextStyle _styleForToken(BuildContext context, d.ThemeParsingTokenType type) {
    final theme = YamlTheme.of(context);
    final baseStyle = theme.fontStyles.code.copyWith(
      color: theme.colors.foreground1,
      fontSize: theme.fontSizes.regular,
    );
    switch (type) {
      case d.ThemeParsingTokenType.doubleValue:
        return baseStyle.copyWith(color: theme.colors.accent1);
      case d.ThemeParsingTokenType.stringValue:
        return baseStyle.copyWith(color: theme.colors.accent2);
      case d.ThemeParsingTokenType.identifier3:
        return baseStyle.copyWith(color: theme.colors.foreground3);
      case d.ThemeParsingTokenType.identifier4:
        return baseStyle.copyWith(color: theme.colors.foreground3);
      case d.ThemeParsingTokenType.identifier2:
        return baseStyle.copyWith(color: theme.colors.foreground2);

      case d.ThemeParsingTokenType.error:
        return baseStyle.copyWith(color: theme.colors.error1);
      default:
        return baseStyle;
    }
  }

  Iterable<StyledRange> _tokens(BuildContext context, String yaml) sync* {
    final tokens = context.select(
      (ApplicationState state) => state.editor.parsingResult.map(
        empty: () => const <d.ThemeParsingToken>[],
        succeeded: (succeeded) => succeeded.tokens,
        failed: (failed) {
          final exception = failed.exception;
          if (exception is d.ThemeDefinitionParsingException) {
            return <d.ThemeParsingToken>[
              d.ThemeParsingToken(
                type: d.ThemeParsingTokenType.error,
                start: math.max(0, exception.startOffset),
                end: math.max(
                    yaml.length,
                    exception.startOffset == exception.endOffset
                        ? exception.startOffset + 1
                        : exception.endOffset),
              ),
            ];
          }
          return const <d.ThemeParsingToken>[];
        },
      ),
    );

    for (var token in tokens) {
      yield StyledRange(
        start: token.start,
        end: token.end,
        style: _styleForToken(context, token.type),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final yaml = context.select((ApplicationState state) => state.editor.yaml);

    final theme = YamlTheme.of(context);
    return Container(
      color: theme.colors.background1,
      child: StatelessTextField(
        text: yaml,
        styles: _tokens(context, yaml).toList(),
        onTextChanged: (text) => context.dispatch(EditYaml(text)),
        padding: const EdgeInsets.all(20.0),
        style: theme.fontStyles.code.copyWith(
          color: theme.colors.foreground1,
          fontSize: theme.fontSizes.regular,
        ),
      ),
    );
  }
}
