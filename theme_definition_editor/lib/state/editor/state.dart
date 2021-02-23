import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition/theme_definition.dart';

enum EditorMode {
  preview,
  export,
  code,
}

enum BrightnessMode {
  light,
  dark,
}

class EditorState extends Equatable {
  final String yaml;
  final EditorMode mode;
  final ThemeParsingResult parsingResult;
  final ExportOptions exportOptions;
  final ExportedCode exportedCode;
  final BrightnessMode codeBrightness;
  final BrightnessMode previewBrightness;

  const EditorState.empty()
      : yaml = '',
        mode = EditorMode.preview,
        codeBrightness = BrightnessMode.dark,
        previewBrightness = BrightnessMode.light,
        exportOptions = const ExportOptions(
          nullSafety: false,
        ),
        exportedCode = const ExportedCode(
          dart: '',
          copiedToCliboard: false,
        ),
        parsingResult = const EmptyParsingResult();

  const EditorState._({
    @required this.yaml,
    @required this.mode,
    @required this.exportOptions,
    @required this.exportedCode,
    @required this.parsingResult,
    @required this.codeBrightness,
    @required this.previewBrightness,
  });

  factory EditorState({
    @required String yaml,
    @required EditorMode mode,
    @required BrightnessMode codeBrightness,
    @required BrightnessMode previewBrightness,
    ExportOptions exportOptions = const ExportOptions(
      nullSafety: false,
    ),
  }) {
    final parsingResult = ThemeDefinitionParser().parseYaml(yaml);
    final dart = parsingResult.map(
      empty: () => '',
      succeeded: (succeeded) => generateTheme(
        succeeded.definition,
        nullSafety: exportOptions.nullSafety,
      ),
      failed: (failed) => '',
    );

    return EditorState._(
      yaml: yaml,
      mode: mode,
      exportOptions: exportOptions,
      exportedCode: ExportedCode(
        dart: dart,
        copiedToCliboard: false,
      ),
      parsingResult: parsingResult,
      codeBrightness: codeBrightness,
      previewBrightness: previewBrightness,
    );
  }

  EditorState copyWith({
    String yaml,
    EditorMode mode,
    ExportOptions exportOptions,
    ExportedCode exportedCode,
    BrightnessMode codeBrightness,
    BrightnessMode previewBrightness,
  }) {
    if (yaml == null && exportOptions == null) {
      return EditorState._(
        yaml: this.yaml,
        parsingResult: this.parsingResult,
        mode: mode ?? this.mode,
        exportOptions: this.exportOptions,
        exportedCode: exportedCode ?? this.exportedCode,
        codeBrightness: codeBrightness ?? this.codeBrightness,
        previewBrightness: previewBrightness ?? this.previewBrightness,
      );
    }

    return EditorState(
      yaml: yaml ?? this.yaml,
      mode: mode ?? this.mode,
      exportOptions: exportOptions ?? this.exportOptions,
      codeBrightness: codeBrightness,
      previewBrightness: previewBrightness,
    );
  }

  @override
  List<Object> get props => [
        yaml,
        mode,
        parsingResult,
        exportOptions,
        exportedCode,
      ];
}

class ExportOptions extends Equatable {
  final bool nullSafety;

  const ExportOptions({
    @required this.nullSafety,
  });

  ExportOptions copyWith({
    bool nullSafety,
  }) =>
      ExportOptions(
        nullSafety: nullSafety ?? this.nullSafety,
      );

  @override
  List<Object> get props => [
        nullSafety,
      ];
}

class ExportedCode extends Equatable {
  final String dart;
  final bool copiedToCliboard;
  const ExportedCode({
    @required this.dart,
    @required this.copiedToCliboard,
  });

  ExportedCode copyWith({
    String dart,
    bool copiedToCliboard,
  }) =>
      ExportedCode(
        dart: dart ?? this.dart,
        copiedToCliboard: copiedToCliboard ?? this.copiedToCliboard,
      );

  @override
  List<Object> get props => [
        dart,
        copiedToCliboard,
      ];
}
