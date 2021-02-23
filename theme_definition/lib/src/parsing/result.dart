import 'package:equatable/equatable.dart';
import 'package:theme_definition/src/definitions/theme.dart';
import 'package:theme_definition/theme_definition.dart';

import 'errors.dart';

abstract class ThemeParsingResult extends Equatable {
  const ThemeParsingResult({
    required this.source,
  });
  final String source;

  K map<K>({
    required K Function() empty,
    required K Function(SucceededThemeParsingResult succeeded) succeeded,
    required K Function(FailedThemeParsingResult failed) failed,
  }) {
    final value = this;

    if (value is SucceededThemeParsingResult) {
      return succeeded(value);
    }

    if (value is FailedThemeParsingResult) {
      return failed(value);
    }

    return empty();
  }

  @override
  List<Object?> get props => [source];
}

class EmptyParsingResult extends ThemeParsingResult {
  const EmptyParsingResult() : super(source: '');
}

class SucceededThemeParsingResult extends ThemeParsingResult {
  const SucceededThemeParsingResult({
    required String source,
    required this.definition,
    required this.tokens,
  }) : super(source: source);

  final ThemeDefinition definition;
  final List<ThemeParsingToken> tokens;

  @override
  List<Object?> get props => [
        ...super.props,
        definition,
        tokens,
      ];
}

class FailedThemeParsingResult extends ThemeParsingResult {
  const FailedThemeParsingResult({
    required String source,
    required this.exception,
  }) : super(source: source);

  final ThemeDefinitionParsingException exception;

  @override
  List<Object?> get props => [
        ...super.props,
        exception,
      ];
}
