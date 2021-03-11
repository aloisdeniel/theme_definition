import 'package:localization_builder/localization_builder.dart';
import 'package:recase/recase.dart';
import 'package:theme_definition/src/definitions/configuration.dart';
import 'package:theme_definition/theme_definition.dart';

import 'base.dart';
import 'class_builders/inherited_widget.dart';
import 'class_builders/parsers.dart';
import 'header.dart';

String generateTheme(
  ThemeDefinition definition, {
  bool nullSafety = true,
  bool jsonParser = true,
}) {
  final result = StringBuffer();

  result.writeln(generatedFileHeader);

  if (!nullSafety) {
    result.writeln("import 'package:meta/meta.dart';");
  }

  result.writeln("import 'package:flutter/widgets.dart';");

  if (definition.icons.isNotEmpty) {
    result.writeln("import 'package:path_icon/path_icon.dart';");
  }

  if (definition.labels != null) {
    result.writeln();
    result.writeln(DartLocalizationBuilder(
      nullSafety: nullSafety,
      jsonParser: jsonParser,
    ).buildImports());
  }

  final googleFonts = definition.fontStyles.isNotEmpty &&
      ((jsonParser && definition.fontStyles.isNotEmpty) ||
          definition.fontStyles.any(
            (f) => f.constants.any(
              (f) => f.value.source == FontSource.googleFonts,
            ),
          ));

  if (googleFonts) {
    result.writeln("import 'package:google_fonts/google_fonts.dart';");
  }

  result.writeln();

  final prefix = createClassdName(definition.name);

  // Theme widget
  result.writeln(InhheritedWidgetClassBuilder(prefix).build(
    nullSafety: nullSafety,
  ));

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
      themeClass.addProperty(
        '${prefix}${className}Data',
        fieldName,
        jsonConverter: fromJsonPropertyBuilderJsonConverter,
      );
      constructorValues[fieldName] =
          'const ${prefix}${className}Data.${variants.first.name}()';

      result.writeln(
        generateVariantSet(
          prefix: prefix,
          type: type,
          name: className,
          buildInstance: buildInstance,
          variants: variants,
          nullSafety: nullSafety,
          jsonParser: jsonParser,
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
  addData(
    definition.images,
    'images',
    'ImageProvider',
    buildImageInstance,
  );

  addConfigurationData(
    prefix,
    themeClass,
    constructorValues,
    definition.configuration,
  );

  themeClass.addConstructor('fallback', constructorValues);
  result.writeln(themeClass.build(
    nullSafety: nullSafety,
    jsonParser: jsonParser,
  ));

  if (definition.configuration.isNotEmpty) {
    result.writeln(
      generateConfigurationClasses(
        definition.configuration.first.configuration,
        ['Configuration'],
        definition.configuration,
        jsonParser: jsonParser,
        nullSafety: nullSafety,
      ),
    );
  }

  for (var childClass in childClasses) {
    result.writeln(childClass);
  }

  if (definition.labels != null) {
    result.writeln();
    result.writeln(DartLocalizationBuilder(
      nullSafety: nullSafety,
      jsonParser: jsonParser,
    ).build(definition.labels!));
  }

  // Helper methods

  if (jsonParser) {
    if (definition.spacing.isNotEmpty) {
      result.writeln(parserMethods['EdgeInsets']!(nullSafety: nullSafety));
    }
    if (definition.colors.isNotEmpty) {
      result.writeln(parserMethods['Color']!(nullSafety: nullSafety));
    }
    if (definition.radiuses.isNotEmpty) {
      result.writeln(parserMethods['Radius']!(nullSafety: nullSafety));
      result.writeln(parserMethods['BorderRadius']!(nullSafety: nullSafety));
    }
    if (definition.sizes.isNotEmpty) {
      result.writeln(parserMethods['Size']!(nullSafety: nullSafety));
    }

    if (definition.durations.isNotEmpty) {
      result.writeln(parserMethods['Duration']!(nullSafety: nullSafety));
    }

    if (definition.fontStyles.isNotEmpty) {
      result.writeln(parserMethods['TextStyle']!(nullSafety: nullSafety));
    }

    if (definition.icons.isNotEmpty) {
      result.writeln(parserMethods['PathIconData']!(nullSafety: nullSafety));
    }

    if (definition.images.isNotEmpty) {
      result.writeln(parserMethods['ImageProvider']!(nullSafety: nullSafety));
    }
  }

  //return DartFormatter().format(result.toString());
  return result.toString();
}

void addConfigurationData(String prefix, DataClassBuilder themeClass,
    Map<String, String> constructorValues, List<ConfigurationSet> variants) {
  if (variants.isNotEmpty) {
    final className = 'Configuration';
    final fieldName = createFieldName(className);
    themeClass.addProperty(
      '${className}Data',
      fieldName,
      jsonConverter: fromJsonPropertyBuilderJsonConverter,
    );
    constructorValues[fieldName] =
        'const ConfigurationData.${ReCase(variants.first.name).camelCase}()';
  }
}

String generateVariantSet<T>({
  required String prefix,
  required String name,
  required String type,
  required List<VariantSet<T>> variants,
  required String Function(T value) buildInstance,
  required bool nullSafety,
  required bool jsonParser,
  bool isConst = true,
}) {
  final colorsClass =
      DataClassBuilder('${prefix}${name}Data', isConst: isConst);
  if (variants.isNotEmpty) {
    final properties = variants.first.constantNames.toList();
    for (var property in properties) {
      colorsClass.addProperty(
        type,
        property,
        jsonConverter: themePropertyJsonConverter,
      );
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
    return colorsClass.build(
      nullSafety: nullSafety,
      jsonParser: jsonParser,
    );
  }
  return '';
}

String generateConfigurationClasses(
  Configuration configuration,
  List<String> path,
  List<ConfigurationSet> variants, {
  required bool nullSafety,
  required bool jsonParser,
}) {
  final name = path.map((x) => ReCase(x).pascalCase).join();

  final result = StringBuffer();

  final configClass = DataClassBuilder(
    '${name}Data',
    isConst: true,
  );

  for (var variant in variants) {
    final constructorInitializers = <String, String>{};

    for (var property in variant.configuration.properties.entries) {
      constructorInitializers[ReCase(property.key).camelCase] =
          buildBaseValue(property.value);
    }

    for (var child in variant.configuration.children.entries) {
      constructorInitializers[ReCase(child.key).camelCase] =
          buildChildConfigurationInstance(child.value, [...path, child.key]);
    }

    configClass.addConstructor(
      ReCase(variant.name).camelCase,
      constructorInitializers,
    );
  }

  for (var property in configuration.properties.entries) {
    configClass.addProperty(
      () {
        if (property.value is String) return 'String';
        if (property.value is num) return 'double';
        if (property.value is bool) return 'bool';
        throw Exception();
      }(),
      ReCase(property.key).camelCase,
    );
  }

  for (var property in configuration.children.entries) {
    final childPath = [...path, property.key];
    final childName = childPath.map((x) => ReCase(x).pascalCase).join();
    result.writeln(generateConfigurationClasses(
      property.value,
      childPath,
      [],
      nullSafety: nullSafety,
      jsonParser: jsonParser,
    ));

    configClass.addProperty(
      '${childName}Data',
      ReCase(property.key).camelCase,
      jsonConverter: fromJsonPropertyBuilderJsonConverter,
    );
  }

  result.writeln(configClass.build(
    nullSafety: nullSafety,
    jsonParser: jsonParser,
  ));

  return result.toString();
}
