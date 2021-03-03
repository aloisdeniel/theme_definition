import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/app/update.dart';
import 'package:theme_definition_editor/state/editor/state.dart';
import 'package:theme_definition_editor/view/layouts/editor/widgets/error.dart';
import 'package:theme_definition_editor/view/layouts/editor/widgets/right_bar.dart';
import 'package:theme_definition_editor/view/layouts/editor/widgets/yaml.dart';
import 'package:theme_definition_editor/view/layouts/export/layout.dart';
import 'package:theme_definition_editor/view/layouts/preview/layout.dart';
import 'package:theme_definition_editor/view/notifier.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

import 'widgets/app_bar.dart';

class EditorLayout extends StatelessWidget {
  const EditorLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isLarge = mediaQuery.size.width > 600;

    var leftBrightness = context.select(
      (ApplicationState state) => state.editor.codeBrightness,
    );

    var rightBrightness = context.select(
      (ApplicationState state) => state.editor.previewBrightness,
    );
    return Container(
      color: theme.colors.background1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLarge)
            Expanded(
              child: YamlTheme(
                data: YamlThemeData.fallback().copyWith(
                  colors: leftBrightness == BrightnessMode.dark
                      ? YamlColorsData.dark()
                      : YamlColorsData.light(),
                ),
                child: _LeftPanel(),
              ),
            ),
          Expanded(
            child: YamlTheme(
              data: YamlThemeData.fallback().copyWith(
                colors: rightBrightness == BrightnessMode.dark
                    ? YamlColorsData.semiDark()
                    : YamlColorsData.extraLight(),
              ),
              child: _RightPanel(
                withCode: !isLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftPanel extends StatelessWidget {
  const _LeftPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditorAppBar(),
        Expanded(child: YamlEditor()),
      ],
    );
  }
}

class _RightPanel extends StatefulWidget {
  const _RightPanel({
    Key? key,
    required this.withCode,
  }) : super(key: key);

  final bool withCode;

  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends State<_RightPanel> {
  @override
  void initState() {
    context.dispatch(RestoreState());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    var mode = context.select((ApplicationState state) => state.editor.mode);
    if (!widget.withCode && mode == EditorMode.code) {
      mode = EditorMode.preview;
    }
    final isSucceded = context.select(
      (ApplicationState state) => state.editor.parsingResult.map(
        empty: () => true,
        succeeded: (_) => true,
        failed: (_) => false,
      ),
    );
    if (!isSucceded) {
      return EditorErrorView();
    }

    return Container(
      color: theme.colors.background1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RightEditorBar(
            withCode: widget.withCode,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              layoutBuilder:
                  (Widget? currentChild, List<Widget> previousChildren) {
                return Stack(
                  children: <Widget>[
                    ...previousChildren.map((e) => Positioned.fill(child: e)),
                    if (currentChild != null)
                      Positioned.fill(child: currentChild),
                  ],
                );
              },
              child: () {
                switch (mode) {
                  case EditorMode.export:
                    return ThemeExportLayout();
                  case EditorMode.preview:
                    return ThemePreviewLayout();
                  case EditorMode.code:
                    return YamlTheme(
                      data: YamlThemeData.fallback().copyWith(
                        colors: YamlColorsData.dark(),
                      ),
                      child: YamlEditor(),
                    );
                }
              }(),
            ),
          ),
        ],
      ),
    );
  }
}
