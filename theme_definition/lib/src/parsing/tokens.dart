import 'package:equatable/equatable.dart';

enum ThemeParsingTokenType {
  text,
  identifier1,
  identifier2,
  identifier3,
  identifier4,
  colorValue,
  spacingValue,
  intValue,
  doubleValue,
  stringValue,
  iconValue,
}

class ThemeParsingToken extends Equatable {
  const ThemeParsingToken({
    required this.type,
    required this.start,
    required this.end,
  });
  final ThemeParsingTokenType type;
  final int start;
  final int end;

  @override
  List<Object?> get props => [type, start, end];
}
