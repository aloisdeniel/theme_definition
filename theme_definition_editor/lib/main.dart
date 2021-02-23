import 'package:flutter/material.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/editor/state.dart';
import 'package:theme_definition_editor/view/layouts/editor/layout.dart';
import 'package:theme_definition_editor/view/notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ApplicationStateProvider(
      initialState: () => ApplicationState(editor: EditorState.empty()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Material(
          child: EditorLayout(),
        ),
      ),
    );
  }
}
