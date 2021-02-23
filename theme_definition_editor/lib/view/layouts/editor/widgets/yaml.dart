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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final yaml = context.select((ApplicationState state) => state.editor.yaml);
    final errorRange = context.select(
      (ApplicationState state) => state.editor.parsingResult.map(
        empty: () => TextRange.empty,
        succeeded: (_) => TextRange.empty,
        failed: (failed) {
          final exception = failed.exception;
          if (exception is d.ThemeDefinitionParsingException) {
            return TextRange(
              start: math.max(0, exception.startOffset),
              end: math.max(
                  yaml.length,
                  exception.startOffset == exception.endOffset
                      ? exception.startOffset + 1
                      : exception.endOffset),
            );
          }
          return TextRange.empty;
        },
      ),
    );
    final theme = YamlTheme.of(context);
    return Container(
      color: theme.colors.background1,
      child: StatelessTextField(
        text: yaml,
        errorRange: errorRange,
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
