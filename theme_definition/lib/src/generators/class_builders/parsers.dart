import 'package:localization_builder/localization_builder.dart';

enum ClassParser {
  json,
  yaml,
}

String themePropertyJsonConverter(PropertyBuilder property, String value) {
  if (parserMethods.keys.contains(property.type)) {
    return '_parse${property.type}($value)';
  }

  return defaultPropertyBuilderJsonConverter(property, value);
}

typedef TypeParserMethod = String Function({
  required bool nullSafety,
});

const parserMethods = <String, TypeParserMethod>{
  'Color': _colorParser,
  'EdgeInsets': _edgeInsetsParser,
  'Radius': _radiusParser,
  'BorderRadius': _borderRadiusParser,
  'TextStyle': _textStyleParser,
  'PathIconData': _pathIconDataParser,
  'Size': _sizeParser,
  'Duration': _durationParser,
};

String _sizeParser({
  required bool nullSafety,
}) =>
    r'''
Size _parseSize(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (value is double) {
    return Size(value, value);
  }
  if (value is Map<String, Object'''
    '${nullSafety ? '?' : ''}'
    r'''>) {
    final width = value['width'] as num;
    final height = value['height'] as num;
    return Size(
      width.toDouble(),
      height.toDouble(),
    );
  }

  throw Exception();
}
''';

String _durationParser({
  required bool nullSafety,
}) =>
    r'''
Duration _parseDuration(Object value) {
  if (value is String) {
    value = int.parse(value);
  }

  if (value is num) {
    return Duration(milliseconds: value.toInt());
  }

  if (value is Map<String, Object'''
    '${nullSafety ? '?' : ''}'
    r'''>) {
    final milliseconds = value['milliseconds'] ?? 0;
    final seconds = value['seconds'] ?? 0;
    final minutes = value['minutes'] ?? 0;
    final hours = value['hours'] ?? 0;
    return Duration(
      milliseconds: (milliseconds as num).toInt(),
      seconds: (seconds as num).toInt(),
      minutes: (minutes as num).toInt(),
      hours: (hours as num).toInt(),
    );
  }

  throw Exception();
}
''';

String _edgeInsetsParser({
  required bool nullSafety,
}) =>
    r'''
EdgeInsets _parseEdgeInsets(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return EdgeInsets.all(value.toDouble());
}
''';

String _pathIconDataParser({
  required bool nullSafety,
}) =>
    r'''
PathIconData _parsePathIconData(Object value) {
  if (!(value is String)) throw Exception();
  if (value.contains('<svg')) return PathIconData.fromSvg(value);
  return PathIconData.fromData(value);
}
''';

String _textStyleParser({
  required bool nullSafety,
}) =>
    r'''
TextStyle _parseTextStyle(Object value) {
  if (!(value is Map<String, Object'''
    '${nullSafety ? '?' : ''}'
    r'''>)) throw Exception();
  final source = value['source'] as String?;
  final fontFamily = value['fontFamily'] as String?;
  final TextDecoration decoration = () {
    final v = value['decoration'] as String?;
    switch (v) {
      case 'overline':
        return TextDecoration.overline;
      case 'underline':
        return TextDecoration.underline;
      default:
        return TextDecoration.none;
    }
  }();
  final FontWeight? fontWeight = () {
    final weight = (value['fontWeight'] as num?)?.toInt();
    if (weight == null) {
      return null;
    }
    return FontWeight.values[(weight ~/ 100) + 1];
  }();
  final fontSize = (value['fontSize'] as num?)?.toDouble();
  if (source != null && source.toLowerCase() == 'googlefonts') {
    return GoogleFonts.getFont(
      source,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    decoration: decoration,
  );
}
''';

String _radiusParser({
  required bool nullSafety,
}) =>
    r'''
Radius _parseRadius(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return Radius.circular(value.toDouble());
}
''';

String _borderRadiusParser({
  required bool nullSafety,
}) =>
    r'''
BorderRadius _parseBorderRadius(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return BorderRadius.circular(value.toDouble());
}
''';

String _colorParser({
  required bool nullSafety,
}) =>
    r'''
Color _parseColor(Object value) {
  if (!(value is String)) throw Exception();
  if (value.startsWith('#')) {
    value = value.substring(1);
  }
  return Color(int.parse(_uniformizeHexValue(value), radix: 16));
}


String _uniformizeHexValue(String'''
    '${nullSafety ? '?' : ''}'
    r''' hex) {
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
''';
