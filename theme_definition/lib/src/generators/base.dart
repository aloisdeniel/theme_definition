import 'package:recase/recase.dart';
import 'package:theme_definition/src/definitions/configuration.dart';
import 'package:theme_definition/src/definitions/font_styles.dart';
import 'package:theme_definition/src/definitions/images.dart';
import 'package:theme_definition/src/definitions/size.dart';
import 'package:theme_definition/src/definitions/spacing.dart';
import 'package:theme_definition/theme_definition.dart';

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

String buildImageInstance(Image value) {
  switch (value.source) {
    case ImageSource.asset:
      return 'AssetImage(\'${value.path}\')';
    default:
      return 'NetworkImage(\'${value.path}\')';
  }
}

String buildBaseValue(Object value) {
  if (value is String) {
    return '\'${_escapeString(value)}\'';
  } else if (value is int) {
    return '${value.buildDouble()}';
  } else if (value is double) {
    return '${value.buildDouble()}';
  } else if (value is bool) {
    return '${value ? 'true' : 'false'}';
  }
  throw Exception();
}

String buildConfigurationInstance(Configuration value) =>
    buildChildConfigurationInstance(value, ['Configuration']);

String buildChildConfigurationInstance(
    Configuration configuration, List<String> path) {
  final name = path.map((x) => ReCase(x).pascalCase).join() + 'Data';
  final result = StringBuffer();
  result.writeln('const $name(');

  for (var property in configuration.properties.entries) {
    result.write('${ReCase(property.key).camelCase} : ');
    result.write(buildBaseValue(property.value));
    result.writeln(',');
  }

  for (var property in configuration.children.entries) {
    final name = ReCase(property.key).camelCase;
    result.write('${name} : ');

    result.writeln(
      buildChildConfigurationInstance(
        property.value,
        [
          ...path,
          property.key,
        ],
      ),
    );

    result.writeln(',');
  }

  result.writeln(')');

  return result.toString();
}

extension on num {
  String buildDouble() {
    return toStringAsFixed(2);
  }
}

String _escapeString(String value) => value
    .replaceAll('\n', '\\n')
    .replaceAll('\'', '\\\'')
    .replaceAll('\$', '\\\$');
