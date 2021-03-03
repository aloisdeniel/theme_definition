import 'package:equatable/equatable.dart';

enum FontSource {
  assets,
  googleFonts,
}

enum TextDecoration {
  none,
  underline,
  overline,
  lineThrough,
}

class FontStyle extends Equatable {
  const FontStyle({
    required this.fontFamily,
    required this.package,
    required this.fontWeight,
    required this.fontSize,
    required this.source,
    required this.letterSpacing,
    required this.decoration,
  });

  final String? fontFamily;
  final String? package;
  final int? fontWeight;
  final double? fontSize;
  final FontSource? source;
  final double? letterSpacing;
  final TextDecoration? decoration;

  @override
  List<Object?> get props => [
        fontFamily,
        package,
        fontWeight,
        fontSize,
        source,
        letterSpacing,
        decoration,
      ];
}
