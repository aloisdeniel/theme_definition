import 'package:equatable/equatable.dart';

enum FontSource {
  assets,
  googleFonts,
}

class FontStyle extends Equatable {
  const FontStyle({
    required this.fontFamily,
    required this.package,
    required this.fontWeight,
    required this.fontSize,
    required this.source,
  });

  final String? fontFamily;
  final String? package;
  final int? fontWeight;
  final double? fontSize;
  final FontSource? source;

  @override
  List<Object?> get props => [
        fontFamily,
        package,
        fontWeight,
        fontSize,
        source,
      ];
}
