import 'package:equatable/equatable.dart';

class Color extends Equatable {
  const Color(this.hexValue) : assert(hexValue.length == 8);
  final String hexValue;

  factory Color.parse(String value) {
    if (value.startsWith('#')) {
      value = value.substring(1);
    }
    value = _uniformizeHexValue(value);
    int.parse(value, radix: 16); // Validation
    return Color(value);
  }

  @override
  List<Object> get props => [hexValue];
}

String _uniformizeHexValue(String? hex) {
  hex ??= '0';
  hex = hex.isEmpty ? '0' : hex;
  if (hex.length == 1) {
    return 'FF$hex$hex$hex$hex$hex$hex';
  } else if (hex.length == 2) {
    return 'FF$hex$hex$hex';
  } else if (hex.length == 3) {
    final r = hex[0];
    final g = hex[1];
    final b = hex[2];
    return 'FF$r$r$g$g$b$b';
  } else if (hex.length == 4) {
    final a = hex[0];
    final r = hex[1];
    final g = hex[2];
    final b = hex[3];
    return '$a$a$r$r$g$g$b$b';
  } else if (hex.length == 5) {
    final a1 = hex[0];
    final a2 = hex[1];
    final r = hex[2];
    final g = hex[3];
    final b = hex[4];
    return '$a1$a2$r$r$g$g$b$b';
  } else if (hex.length == 6) {
    return 'FF$hex';
  } else if (hex.length == 7) {
    final a = hex[0];
    final rgb = hex.substring(1);
    return '$a$a$rgb';
  }
  return hex.substring(0, 8);
}
