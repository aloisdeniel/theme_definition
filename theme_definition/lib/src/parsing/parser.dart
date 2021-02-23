import 'dart:io';

import 'package:theme_definition/src/definitions/colors.dart';
import 'package:theme_definition/src/definitions/font_sizes.dart';
import 'package:theme_definition/src/definitions/font_styles.dart';
import 'package:theme_definition/src/definitions/icons.dart';
import 'package:theme_definition/src/definitions/radius.dart';
import 'package:theme_definition/src/definitions/size.dart';
import 'package:theme_definition/src/definitions/spacing.dart';
import 'package:theme_definition/src/definitions/theme.dart';
import 'package:collection/collection.dart';
import 'package:theme_definition/src/parsing/result.dart';
import 'package:yaml/yaml.dart';

import 'errors.dart';
import 'helpers.dart';
import 'tokens.dart';

class ThemeDefinitionParser {
  List<ThemeParsingToken> _tokens = <ThemeParsingToken>[];
  Future<ThemeParsingResult> parseFile(File file) async {
    _tokens = <ThemeParsingToken>[];

    final content = await file.readAsString();
    if (file.path.endsWith('.yaml')) {
      return parseYaml(content);
    }

    throw Exception('Unsupported file extension (not .yaml) : ${file.path}');
  }

  ThemeParsingResult parseYaml(String yaml) {
    if (yaml.isEmpty) {
      return EmptyParsingResult();
    }
    try {
      final doc = loadYaml(yaml);
      final definition = _parseMap(doc);
      return SucceededThemeParsingResult(
        source: yaml,
        definition: definition,
        tokens: _tokens,
      );
    } on ThemeDefinitionParsingException catch (e) {
      return FailedThemeParsingResult(
        source: yaml,
        exception: e,
      );
    } on YamlException catch (e) {
      return FailedThemeParsingResult(
        source: yaml,
        exception: ThemeDefinitionParsingException.fromException(e),
      );
    } catch (e) {
      return FailedThemeParsingResult(
        source: yaml,
        exception:
            ThemeDefinitionParsingException.fromNode(YamlMap(), e.toString()),
      );
    }
  }

  void _addKeyToken(dynamic key, ThemeParsingTokenType type) {
    if (key != null) {
      _tokens.add(
        ThemeParsingToken(
          start: key.span.start.offset,
          end: key.span.end.offset,
          type: type,
        ),
      );
    }
  }

  void _addKeyTokenWithName(
      YamlMap map, String name, ThemeParsingTokenType type) {
    if (map.containsKey(name)) {
      final key = map.nodes.entries
          .firstWhere((x) => x.key.toString() == name)
          .key as YamlNode?;
      _addKeyToken(key, type);
    }
  }

  ThemeDefinition _parseMap(YamlMap map) {
    return ThemeDefinition(
      name: map['name']?.toString() ?? 'Theme',
      colors: _parseVariantSets(map, 'colors', _parseColor),
      spacing: _parseVariantSets(map, 'spacing', _parseSpacing),
      fontStyles: _parseVariantSets(map, 'fontStyles', _parseFontStyle),
      fontSizes: _parseVariantSets(map, 'fontSizes', _parseFontSize),
      radiuses: _parseVariantSets(map, 'radiuses', _parseRadius),
      icons: _parseVariantSets(map, 'icons', _parseIcon),
      durations: _parseVariantSets(map, 'durations', _parseDuration),
      sizes: _parseVariantSets(map, 'sizes', _parseSize),
    );
  }

  List<VariantSet<T>> _parseVariantSets<T>(
      YamlMap map, String name, T Function(YamlNode node) parser) {
    final variants = map[name];
    _addKeyTokenWithName(map, name, ThemeParsingTokenType.identifier1);
    if (!(variants == null || variants is YamlMap)) {
      throw ThemeDefinitionParsingException.fromNode(
        variants,
        'Should be a map of icons variants',
      );
    }
    final result = <VariantSet<T>>[];
    if (variants != null) {
      VariantSet<T>? previousVariant;
      for (var entry in variants.nodes.entries) {
        _addKeyToken(entry.key, ThemeParsingTokenType.identifier2);
        if (!(entry.value is YamlMap)) {
          throw ThemeDefinitionParsingException.fromNode(
            entry.value,
            'Expecting a map with "$name" constants for the "${entry.key}" variant',
          );
        }
        final map = entry.value as YamlMap;
        final variant = _parseVariantSet(map, entry.key.toString(), parser);
        if (previousVariant != null &&
            !const SetEquality()
                .equals(previousVariant.constantNames, variant.constantNames)) {
          throw ThemeDefinitionParsingException.fromNode(
            entry.key,
            'This variant doesn\' have the same constants than the previous one',
          );
        }
        result.add(variant);
        previousVariant = variant;
      }
    }
    return result;
  }

  VariantSet<T> _parseVariantSet<T>(
      YamlMap map, String key, T Function(YamlNode node) parser) {
    return VariantSet<T>(
      name: key,
      constants: map.nodes.entries
          .map(
            (x) => ConstantDefinition(
              name: x.key.toString(),
              value: parser(x.value),
            ),
          )
          .toList(),
    );
  }

  Color _parseColor(YamlNode value) {
    var s = parseScalarValueFromNode<String>(value) ?? '0';

    if (value is YamlScalar && value.value is num && s.length < 8) {
      s = Iterable.generate(6 - s.length, (i) => i > 5 ? 'F' : '0')
              .toList()
              .reversed
              .join() +
          s;
    }

    return Color.parse(s);
  }

  FontSize _parseFontSize(YamlNode value) {
    return FontSize(parseScalarValueFromNode<double>(value) ?? 0);
  }

  FontStyle _parseFontStyle(YamlNode value) {
    final map = value as YamlMap;
    return FontStyle(
      fontFamily: parseScalarValueFromNode<String>(map.nodes['fontFamily']),
      package: parseScalarValueFromNode<String>(map.nodes['package']),
      fontWeight: parseScalarValueFromNode<int>(map.nodes['fontWeight']),
      fontSize: parseScalarValueFromNode<double>(map.nodes['fontSize']),
      source: () {
        switch (parseScalarValueFromNode<String>(map.nodes['source'])
            ?.toLowerCase()
            .replaceAll(' ', '')) {
          case 'googlefonts':
            return FontSource.googleFonts;
          default:
            return FontSource.assets;
        }
      }(),
    );
  }

  Icon _parseIcon(YamlNode value) {
    return Icon(parseScalarValueFromNode<String>(value) ?? '');
  }

  Radius _parseRadius(YamlNode value) {
    return Radius(parseScalarValueFromNode<double>(value) ?? 0);
  }

  Spacing _parseSpacing(YamlNode value) {
    return Spacing(parseScalarValueFromNode<double>(value) ?? 0);
  }

  Size _parseSize(YamlNode value) {
    if (value is YamlScalar && value.value is double) {
      final size = value.value as double;
      return Size(size, size);
    }
    final map = value as YamlMap;
    final width = parseScalarValueFromNode<double>(map.nodes['width']) ?? 0;
    final height = parseScalarValueFromNode<double>(map.nodes['height']) ?? 0;
    return Size(width, height);
  }

  Duration _parseDuration(YamlNode value) {
    if (value is YamlScalar && value.value is num) {
      final milliseconds = value.value as num;
      return Duration(
        milliseconds: milliseconds.toDouble().ceil(),
      );
    }
    final map = value as YamlMap;
    return Duration(
      milliseconds:
          parseScalarValueFromNode<int>(map.nodes['milliseconds']) ?? 0,
      minutes: parseScalarValueFromNode<int>(map.nodes['minutes']) ?? 0,
      seconds: parseScalarValueFromNode<int>(map.nodes['seconds']) ?? 0,
      hours: parseScalarValueFromNode<int>(map.nodes['hours']) ?? 0,
      days: parseScalarValueFromNode<int>(map.nodes['days']) ?? 0,
    );
  }
}
