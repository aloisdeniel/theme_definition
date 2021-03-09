import 'dart:io';

import 'package:localization_builder/localization_builder.dart';
import 'package:theme_definition/src/definitions/colors.dart';
import 'package:theme_definition/src/definitions/configuration.dart';
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

  void _addValueToken(YamlNode key, ThemeParsingTokenType type) {
    _tokens.add(
      ThemeParsingToken(
        start: key.span.start.offset,
        end: key.span.end.offset,
        type: type,
      ),
    );
  }

  ThemeDefinition _parseMap(YamlMap map) {
    var nameNode = map.nodes['name'];
    String name;
    if (nameNode != null) {
      _addKeyTokenWithName(map, 'name', ThemeParsingTokenType.identifier1);
      name = _parseScalarValueFromNode<String>(nameNode) ?? '';
    } else {
      name = 'App';
    }
    return ThemeDefinition(
      name: name.toString(),
      colors: _parseVariantSets(map, 'colors', _parseColor),
      spacing: _parseVariantSets(map, 'spacing', _parseSpacing),
      fontStyles: _parseVariantSets(map, 'fontStyles', _parseFontStyle),
      fontSizes: _parseVariantSets(map, 'fontSizes', _parseFontSize),
      radiuses: _parseVariantSets(map, 'radiuses', _parseRadius),
      icons: _parseVariantSets(map, 'icons', _parseIcon),
      durations: _parseVariantSets(map, 'durations', _parseDuration),
      sizes: _parseVariantSets(map, 'sizes', _parseSize),
      configuration: _parseConfigurationSet(map, 'configuration'),
      labels: _parseLabels(map, 'labels', name),
    );
  }

  Localizations? _parseLabels(YamlMap map, String name, String themeName) {
    final entry = map.nodes[name];
    if (entry == null) {
      return null;
    }
    if (!(entry.value is YamlMap)) {
      return null;
    }
    final valueMap = entry.value as YamlMap;
    final parser = YamlLocalizationParser();
    try {
      final result = parser.parse(
        input: valueMap,
        name: '${name}Labels',
      );
      for (var token in result.tokens) {
        if (token.node != null) {
          _tokens.add(
            ThemeParsingToken(
              start: token.node!.span.start.offset,
              end: token.node!.span.end.offset,
              type: () {
                switch (token.type) {
                  case YamlLocalizationTokenType.sectionKey:
                    return ThemeParsingTokenType.identifier3;
                  case YamlLocalizationTokenType.caseKey:
                  case YamlLocalizationTokenType.labelKey:
                    return ThemeParsingTokenType.identifier4;
                  case YamlLocalizationTokenType.languageKey:
                    return ThemeParsingTokenType.identifier2;
                  case YamlLocalizationTokenType.labelValue:
                    return ThemeParsingTokenType.stringValue;
                  case YamlLocalizationTokenType.caseValue:
                    return ThemeParsingTokenType.stringValue;
                  default:
                    return ThemeParsingTokenType.text;
                }
              }(),
            ),
          );
        }
      }

      return result.result.copyWith(name: '${themeName}LocalizationData');
    } on ParsingException<YamlLocalizationToken> catch (e) {
      if (e.token.node != null) {
        throw ThemeDefinitionParsingException.fromNode(
            e.token.node!, e.message);
      } else {
        rethrow;
      }
    }
  }

  List<ConfigurationSet> _parseConfigurationSet(YamlMap map, String name) {
    final variants = map[name];
    _addKeyTokenWithName(map, name, ThemeParsingTokenType.identifier1);
    if (!(variants == null || variants is YamlMap)) {
      throw ThemeDefinitionParsingException.fromNode(
        variants,
        'Should be a map of variants',
      );
    }
    final result = <ConfigurationSet>[];
    if (variants != null) {
      ConfigurationSet? previousVariant;
      for (var entry in variants.nodes.entries) {
        _addKeyToken(entry.key, ThemeParsingTokenType.identifier2);
        if (!(entry.value is YamlMap)) {
          throw ThemeDefinitionParsingException.fromNode(
            entry.value,
            'Expecting a map with "$name" constants for the "${entry.key}" variant',
          );
        }
        final map = entry.value as YamlMap;
        final config = _parseConfiguration(map);
        if (previousVariant != null &&
            !config.hasSameProperties(previousVariant.configuration)) {
          throw ThemeDefinitionParsingException.fromNode(
            entry.key,
            'This variant doesn\' have the same constants than the previous one',
          );
        }
        final variant = ConfigurationSet(
          name: entry.key.toString(),
          configuration: config,
        );
        result.add(variant);
        previousVariant = variant;
      }
    }
    return result;
  }

  List<VariantSet<T>> _parseVariantSets<T>(
      YamlMap map, String name, T Function(YamlNode node) parser) {
    final variants = map[name];
    _addKeyTokenWithName(map, name, ThemeParsingTokenType.identifier1);
    if (!(variants == null || variants is YamlMap)) {
      throw ThemeDefinitionParsingException.fromNode(
        variants,
        'Should be a map of variants',
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
      constants: map.nodes.entries.map(
        (x) {
          _addKeyToken(x.key, ThemeParsingTokenType.identifier3);
          return ConstantDefinition(
            name: x.key.toString(),
            value: parser(x.value),
          );
        },
      ).toList(),
    );
  }

  Configuration _parseConfiguration(YamlNode value) {
    if (!(value is YamlMap)) {
      throw ThemeDefinitionParsingException.fromNode(
        value,
        'Expecting a map for the configuration item',
      );
    }

    // Properties
    final properties = <String, Object>{};
    final scalarNodes =
        value.nodes.entries.where((x) => x.value is YamlScalar).toList();
    for (var scalarNodes in scalarNodes) {
      properties[scalarNodes.key.toString()] =
          (scalarNodes.value as YamlScalar).value;
    }

    // Children
    final children = <String, Configuration>{};
    final mapNodes =
        value.nodes.entries.where((x) => x.value is YamlMap).toList();
    for (var mapNode in mapNodes) {
      children[mapNode.key.toString()] = _parseConfiguration(mapNode.value);
    }

    return Configuration(
      properties: properties,
      children: children,
    );
  }

  Color _parseColor(YamlNode value) {
    final s = _parseScalarValueFromNode<String>(value) ?? '0';
    return Color.parse(s);
  }

  FontSize _parseFontSize(YamlNode value) {
    return FontSize(_parseScalarValueFromNode<double>(value) ?? 0);
  }

  FontStyle _parseFontStyle(YamlNode value) {
    final map = value as YamlMap;

    _addKeyTokenWithName(map, 'fontFamily', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'package', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'fontWeight', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'fontSize', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(
        map, 'letterSpacing', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'decoration', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'source', ThemeParsingTokenType.identifier3);

    return FontStyle(
      fontFamily: _parseScalarValueFromNode<String>(map.nodes['fontFamily']),
      package: _parseScalarValueFromNode<String>(map.nodes['package']),
      fontWeight: _parseScalarValueFromNode<int>(map.nodes['fontWeight']),
      fontSize: _parseScalarValueFromNode<double>(map.nodes['fontSize']),
      letterSpacing:
          _parseScalarValueFromNode<double>(map.nodes['letterSpacing']),
      decoration: () {
        final decoration =
            _parseScalarValueFromNode<String>(map.nodes['decoration']);
        switch (decoration?.toLowerCase()) {
          case 'underline':
            return TextDecoration.underline;
          case 'lineThrough':
            return TextDecoration.lineThrough;
          case 'overline':
            return TextDecoration.overline;
          default:
            return TextDecoration.none;
        }
      }(),
      source: () {
        switch (_parseScalarValueFromNode<String>(map.nodes['source'])
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
    return Icon(_parseScalarValueFromNode<String>(value) ?? '');
  }

  Radius _parseRadius(YamlNode value) {
    return Radius(_parseScalarValueFromNode<double>(value) ?? 0);
  }

  Spacing _parseSpacing(YamlNode value) {
    return Spacing(_parseScalarValueFromNode<double>(value) ?? 0);
  }

  Size _parseSize(YamlNode value) {
    if (value is YamlScalar && value.value is num) {
      _addValueToken(value, ThemeParsingTokenType.doubleValue);
      final size = (value.value as num).toDouble();
      return Size(size, size);
    }
    final map = value as YamlMap;
    _addKeyTokenWithName(map, 'width', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'height', ThemeParsingTokenType.identifier3);
    final width = _parseScalarValueFromNode<double>(map.nodes['width']) ?? 0;
    final height = _parseScalarValueFromNode<double>(map.nodes['height']) ?? 0;
    return Size(width, height);
  }

  Duration _parseDuration(YamlNode value) {
    if (value is YamlScalar && value.value is num) {
      _addValueToken(value, ThemeParsingTokenType.stringValue);
      final milliseconds = value.value as num;
      return Duration(
        milliseconds: milliseconds.toDouble().ceil(),
      );
    }
    final map = value as YamlMap;

    _addKeyTokenWithName(
        map, 'milliseconds', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'minutes', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'seconds', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'hours', ThemeParsingTokenType.identifier3);
    _addKeyTokenWithName(map, 'days', ThemeParsingTokenType.identifier3);
    return Duration(
      milliseconds:
          _parseScalarValueFromNode<int>(map.nodes['milliseconds']) ?? 0,
      minutes: _parseScalarValueFromNode<int>(map.nodes['minutes']) ?? 0,
      seconds: _parseScalarValueFromNode<int>(map.nodes['seconds']) ?? 0,
      hours: _parseScalarValueFromNode<int>(map.nodes['hours']) ?? 0,
      days: _parseScalarValueFromNode<int>(map.nodes['days']) ?? 0,
    );
  }

  final _hexAsENotationRegex = RegExp(r'([0-9]*)\.([0-9]+)(e|E)\+([0-9]+)');

  T? _parseScalarValueFromNode<T>(YamlNode? node) {
    if (node == null) {
      return null;
    }
    if (!(node is YamlScalar)) {
      throw ThemeDefinitionParsingException.fromNode(node, 'Should be a value');
    }
    final scalar = node;

    if (T == String) {
      _addValueToken(scalar, ThemeParsingTokenType.stringValue);
      if (scalar.value is String) {
        return scalar.value;
      }
    } else if (T == double) {
      _addValueToken(scalar, ThemeParsingTokenType.doubleValue);
      if (scalar.value is String) {
        try {
          return double.parse(scalar.value) as T;
        } catch (e) {
          throw ThemeDefinitionParsingException.fromNode(
              node, 'Expecting a double value');
        }
      }
      if (scalar.value is double) {
        return scalar.value as T;
      }
      if (scalar.value is int) {
        return scalar.value.toDouble() as T;
      }
      throw ThemeDefinitionParsingException.fromNode(
          node, 'Expecting a double value');
    } else if (T == int) {
      _addValueToken(scalar, ThemeParsingTokenType.doubleValue);
      if (scalar.value is String) {
        try {
          return int.parse(scalar.value) as T;
        } catch (e) {
          throw ThemeDefinitionParsingException.fromNode(
              node, 'Expecting an integer value');
        }
      }
      if (scalar.value is double) {
        return scalar.value.toInt() as T;
      }
      if (scalar.value is int) {
        return scalar.value as T;
      }
      throw ThemeDefinitionParsingException.fromNode(
          node, 'Expecting an integer value');
    } else if (T == bool) {
      _addValueToken(scalar, ThemeParsingTokenType.boolValue);
      if (scalar.value is String) {
        return (scalar.value == 'true') as T;
      }
      if (scalar.value is int) {
        return (scalar.value == 1) as T;
      }
      if (scalar.value is bool) {
        return scalar.value as T;
      }
      throw ThemeDefinitionParsingException.fromNode(
          node, 'Expecting a boolean value');
    }
    throw ThemeDefinitionParsingException.fromNode(
        node, 'Unexpected value type');
  }
}
