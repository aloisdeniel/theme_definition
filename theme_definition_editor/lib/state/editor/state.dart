import 'package:dart_style/dart_style.dart';
import 'package:equatable/equatable.dart';
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
          nullSafety: true,
          jsonParser: true,
        ),
        exportedCode = const ExportedCode(
          dart: '',
          copiedToCliboard: false,
        ),
        parsingResult = const EmptyParsingResult();

  const EditorState._({
    required this.yaml,
    required this.mode,
    required this.exportOptions,
    required this.exportedCode,
    required this.parsingResult,
    required this.codeBrightness,
    required this.previewBrightness,
  });

  factory EditorState({
    required String yaml,
    required EditorMode mode,
    required BrightnessMode codeBrightness,
    required BrightnessMode previewBrightness,
    ExportOptions exportOptions = const ExportOptions(
      nullSafety: true,
      jsonParser: true,
    ),
  }) {
    final parsingResult = ThemeDefinitionParser().parseYaml(yaml);
    final dart = parsingResult.map(
      empty: () => '',
      succeeded: (succeeded) => generateTheme(
        succeeded.definition,
        nullSafety: exportOptions.nullSafety,
        jsonParser: exportOptions.jsonParser,
      ),
      failed: (failed) => '',
    );

    return EditorState._(
      yaml: yaml,
      mode: mode,
      exportOptions: exportOptions,
      exportedCode: ExportedCode.formatted(
        dart: dart,
        copiedToCliboard: false,
      ),
      parsingResult: parsingResult,
      codeBrightness: codeBrightness,
      previewBrightness: previewBrightness,
    );
  }

  EditorState copyWith({
    String? yaml,
    EditorMode? mode,
    ExportOptions? exportOptions,
    ExportedCode? exportedCode,
    BrightnessMode? codeBrightness,
    BrightnessMode? previewBrightness,
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
      codeBrightness: codeBrightness ?? this.codeBrightness,
      previewBrightness: previewBrightness ?? this.previewBrightness,
    );
  }

  @override
  List<Object> get props => [
        yaml,
        mode,
        parsingResult,
        exportOptions,
        exportedCode,
        codeBrightness,
        previewBrightness,
      ];
}

class ExportOptions extends Equatable {
  final bool nullSafety;
  final bool jsonParser;

  const ExportOptions({
    required this.nullSafety,
    required this.jsonParser,
  });

  ExportOptions copyWith({
    bool? nullSafety,
    bool? jsonParser,
  }) =>
      ExportOptions(
          nullSafety: nullSafety ?? this.nullSafety,
          jsonParser: jsonParser ?? this.jsonParser);

  @override
  List<Object> get props => [
        nullSafety,
        jsonParser,
      ];
}

class ExportedCode extends Equatable {
  final String dart;
  final bool copiedToCliboard;
  const ExportedCode({
    required this.dart,
    required this.copiedToCliboard,
  });

  factory ExportedCode.formatted({
    required String dart,
    required bool copiedToCliboard,
  }) {
    return ExportedCode(
      dart: DartFormatter().format(dart),
      copiedToCliboard: copiedToCliboard,
    );
  }

  ExportedCode copyWith({
    String? dart,
    bool? copiedToCliboard,
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
