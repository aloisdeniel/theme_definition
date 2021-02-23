import 'package:theme_definition/src/parsing/errors.dart';
import 'package:yaml/yaml.dart';

final _hexAsENotationRegex = RegExp(r'([0-9]*)\.([0-9]+)(e|E)\+([0-9]+)');

T? parseScalarValueFromNode<T>(YamlNode? node) {
  if (node == null) {
    return null;
  }
  if (!(node is YamlScalar)) {
    throw ThemeDefinitionParsingException.fromNode(node, 'Should be a value');
  }
  final scalar = node;

  if (T == String) {
    if (scalar.value is String) {
      return scalar.value;
    }
  } else if (T == double) {
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
  throw ThemeDefinitionParsingException.fromNode(node, 'Unexpected value type');
}
