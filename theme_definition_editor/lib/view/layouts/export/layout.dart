import 'package:flutter/widgets.dart';
import 'package:theme_definition_editor/view/layouts/export/widgets/code.dart';
import 'package:theme_definition_editor/view/layouts/export/widgets/export_bar.dart';

class ThemeExportLayout extends StatelessWidget {
  const ThemeExportLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: ThemeDartExport()),
        ExportEditorBar(),
      ],
    );
  }
}
