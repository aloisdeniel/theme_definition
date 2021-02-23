import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition/theme_definition.dart' as def;
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class ThemeDartExport extends StatelessWidget {
  const ThemeDartExport({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSucceeded = context
        .select((ApplicationState state) => state.editor.parsingResult.map(
              empty: () => true,
              succeeded: (succeeded) => true,
              failed: (failed) => false,
            ));

    if (!isSucceeded) {
      return SizedBox();
    }
    final dart = context
        .select((ApplicationState state) => state.editor.exportedCode.dart);

    final theme = YamlTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular),
      child: SelectableText(
        dart,
        style: GoogleFonts.firaCode(
          color: theme.colors.foreground2,
          fontSize: theme.fontSizes.small,
        ),
      ),
    );
  }
}
