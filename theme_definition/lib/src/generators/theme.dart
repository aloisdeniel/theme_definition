import 'package:localization_builder/localization_builder.dart';
import 'package:theme_definition/theme_definition.dart';

import 'base.dart';
import 'class_builders/data.dart';
import 'class_builders/inherited_widget.dart';

String generateTheme(ThemeDefinition definition, {bool nullSafety = true}) {
  final result = StringBuffer();

  if (!nullSafety) {
    result.writeln("import 'package:meta/meta.dart';");
  }

  result.writeln("import 'package:flutter/widgets.dart';");

  if (definition.icons.isNotEmpty) {
    result.writeln("import 'package:path_icon/path_icon.dart';");
  }

  final googleFonts = definition.fontStyles.isNotEmpty &&
      definition.fontStyles.any((f) =>
          f.constants.any((f) => f.value.source == FontSource.googleFonts));

  if (googleFonts) {
    result.writeln("import 'package:google_fonts/google_fonts.dart';");
  }

  result.writeln();

  final prefix = createClassdName(definition.name);

  // Theme widget
  result.writeln(
      InhheritedWidgetClassBuilder(prefix).build(nullSafety: nullSafety));

  // Theme data
  final themeClass = DataClassBuilder('${prefix}ThemeData');
  final constructorValues = <String, String>{};
  final childClasses = <String>[];
  void addData<T>(
    List<VariantSet<T>> variants,
    String name,
    String type,
    String Function(T value) buildInstance, {
    bool isConst = true,
  }) {
    if (variants.isNotEmpty) {
      final className = createClassdName(name);
      final fieldName = createFieldName(name);
      themeClass.addProperty('${prefix}${className}Data', fieldName);
      constructorValues[fieldName] = generateVariantDefaultInstance(
        prefix: prefix,
        name: className,
        variants: variants,
      );

      result.writeln(
        generateVariantSet(
          prefix: prefix,
          type: type,
          name: className,
          buildInstance: buildInstance,
          variants: variants,
          nullSafety: nullSafety,
          isConst: isConst,
        ),
      );
    }
  }

  addData(
    definition.colors,
    'colors',
    'Color',
    buildColorInstance,
  );
  addData(
    definition.fontStyles,
    'fontStyles',
    'TextStyle',
    buildFontStyleInstance,
    isConst: !googleFonts,
  );
  addData(
    definition.fontSizes,
    'fontSizes',
    'double',
    buildFontSizeInstance,
  );
  addData(
    definition.sizes,
    'sizes',
    'Size',
    buildSizeInstance,
  );
  addData(
    definition.radiuses,
    'radiuses',
    'Radius',
    buildRadiusInstance,
  );
  addData(
    definition.radiuses,
    'borderRadiuses',
    'BorderRadius',
    buildBorderRadiusInstance,
  );
  addData(
    definition.icons,
    'icons',
    'PathIconData',
    buildIconInstance,
    isConst: false,
  );
  addData(
    definition.spacing,
    'spacing',
    'double',
    buildSpacingInstance,
  );
  addData(
    definition.spacing,
    'edgeInsets',
    'EdgeInsets',
    buildInsetsInstance,
  );
  addData(
    definition.durations,
    'durations',
    'Duration',
    buildDurationInstance,
  );

  themeClass.addConstructor('fallback', constructorValues);
  result.writeln(themeClass.build(
    nullSafety: nullSafety,
  ));

  for (var childClass in childClasses) {
    result.writeln(childClass);
  }

  if (definition.labels != null) {
    result.writeln();
    result.writeln(DartLocalizationBuilder().build(definition.labels));
  }

  return result.toString();
}

String generateVariantDefaultInstance<T>({
  required String prefix,
  required String name,
  required List<VariantSet<T>> variants,
}) =>
    'const ${prefix}${name}Data.${variants.first.name}()';

String generateVariantSet<T>({
  required String prefix,
  required String name,
  required String type,
  required List<VariantSet<T>> variants,
  required String Function(T value) buildInstance,
  required bool nullSafety,
  bool isConst = true,
}) {
  final colorsClass =
      DataClassBuilder('${prefix}${name}Data', isConst: isConst);
  if (variants.isNotEmpty) {
    final properties = variants.first.constantNames.toList();
    for (var property in properties) {
      colorsClass.addProperty(type, property);
    }
    for (var variant in variants) {
      final properties = Map.fromEntries(
        variant.constants.map(
          (e) => MapEntry<String, String>(
            e.name,
            buildInstance(e.value),
          ),
        ),
      );
      colorsClass.addConstructor(variant.name, properties);
    }
    return colorsClass.build(nullSafety: nullSafety);
  }
  return '';
}
