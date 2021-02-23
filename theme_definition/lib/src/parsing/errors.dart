import 'package:equatable/equatable.dart';
import 'package:yaml/yaml.dart';

class ThemeDefinitionParsingException extends Equatable {
  ThemeDefinitionParsingException.fromNode(YamlNode failingNode, this.message)
      : startColumn = failingNode.span.start.column,
        startLine = failingNode.span.start.line,
        endColumn = failingNode.span.end.column,
        endLine = failingNode.span.end.line,
        startOffset = failingNode.span.start.offset,
        endOffset = failingNode.span.end.offset;

  ThemeDefinitionParsingException.fromException(YamlException exception)
      : message = exception.message,
        startColumn = exception.span?.start.column ?? 0,
        startLine = exception.span?.start.line ?? 0,
        endColumn = exception.span?.end.column ?? 0,
        endLine = exception.span?.end.line ?? 0,
        startOffset = exception.span?.start.offset ?? 0,
        endOffset = exception.span?.end.offset ?? 0;

  final int startLine;
  final int startOffset;
  final int startColumn;
  final int endLine;
  final int endOffset;
  final int endColumn;
  final String message;

  @override
  List<Object?> get props => [startOffset, endOffset, message];
}
