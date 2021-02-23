import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition/theme_definition.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class EditorErrorView extends StatelessWidget {
  const EditorErrorView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = context.select(
      (ApplicationState state) => state.editor.parsingResult.map(
        empty: () => '',
        succeeded: (_) => '',
        failed: (failed) {
          final exception = failed.exception;
          if (exception is ThemeDefinitionParsingException) {
            return '${exception.message} at line ${exception.startLine}, column : ${exception.startColumn}';
          }

          return 'Unknown parsing error : $exception';
        },
      ),
    );

    final theme = YamlTheme.of(context);
    return Container(
      color: theme.colors.error1,
      padding: theme.edgeInsets.big,
      child: Text(
        message,
        style: theme.fontStyles.code.copyWith(
          color: theme.colors.error2,
          fontSize: theme.fontSizes.big,
        ),
      ),
    );
  }
}
