import 'package:recase/recase.dart';
import 'package:theme_definition/src/definitions/font_styles.dart';
import 'package:theme_definition/src/definitions/size.dart';
import 'package:theme_definition/src/definitions/spacing.dart';
import 'package:theme_definition/theme_definition.dart';

String createFieldName(String name) {
  final cased = ReCase(name);
  return _removeSpecialCharacters(cased.camelCase);
}

String createClassdName(String name) {
  final cased = ReCase(name);
  return _removeSpecialCharacters(cased.pascalCase);
}

String _removeSpecialCharacters(String value) {
  final result = StringBuffer();
  final regexp = RegExp('[a-zA-Z0-9]');
  for (var i = 0; i < value.length; i++) {
    final character = value[i];
    if (regexp.allMatches(character).isNotEmpty) {
      result.write(character);
    }
  }

  return result.toString();
}

String buildColorInstance(Color value) {
  return 'const Color(0x${value.hexValue})';
}

String buildSpacingInstance(Spacing value) {
  return '${value.value.buildDouble()}';
}

String buildSizeInstance(Size value) {
  return 'const Size(${value.width.buildDouble()},${value.height.buildDouble()})';
}

String buildFontSizeInstance(FontSize value) {
  return '${value.value.buildDouble()}';
}

String buildInsetsInstance(Spacing value) {
  return 'const EdgeInsets.all(${value.value.buildDouble()})';
}

String buildRadiusInstance(Radius value) {
  return 'const Radius.circular(${value.value.buildDouble()})';
}

String buildBorderRadiusInstance(Radius value) {
  return 'const BorderRadius.all(Radius.circular(${value.value.buildDouble()}))';
}

String buildDurationInstance(Duration value) {
  return 'const Duration(milliseconds: ${value.inMilliseconds})';
}

String buildFontStyleInstance(FontStyle value) {
  final result = StringBuffer();

  if (value.source == FontSource.googleFonts && value.fontFamily != null) {
    result.writeln('GoogleFonts.getFont(\n\'${value.fontFamily}\',');
  } else {
    result.writeln('const TextStyle(');
    if (value.fontFamily != null) {
      result.write('fontFamily: \'${value.fontFamily}\',');
    }
  }

  if (value.package != null) {
    result.write('package: \'${value.package}\',');
  }
  if (value.fontWeight != null) {
    result.write('fontWeight: FontWeight.w${value.fontWeight},');
  }
  if (value.fontSize != null) {
    result.write('fontSize: ${value.fontSize?.buildDouble()},');
  }

  if (value.decoration != null) {
    result.write('decoration: ${value.decoration.toString()},');
  }

  result.write(')');
  return result.toString();
}

String buildIconInstance(Icon value) {
  final isSvg = value.data.toLowerCase().contains('<svg');
  return 'PathIconData.from${isSvg ? 'Svg' : 'Data'}(\'${value.data}\')';
}

extension on num {
  String buildDouble() {
    return toStringAsFixed(2);
  }
}
