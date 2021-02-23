import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition_editor/state/editor/state.dart';

class ApplicationState extends Equatable {
  final EditorState editor;

  const ApplicationState({
    @required this.editor,
  });

  ApplicationState copyWith({
    EditorState editor,
  }) =>
      ApplicationState(
        editor: editor ?? this.editor,
      );

  @override
  List<Object> get props => [
        editor,
      ];
}
