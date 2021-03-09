import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class Configuration extends Equatable {
  const Configuration({
    required this.properties,
    required this.children,
  });
  final Map<String, Object> properties;
  final Map<String, Configuration> children;

  List<List<String>> allPropertyPathes() {
    return [
      ...properties.keys.map((x) => [x]),
      ...children.entries.map((e) => e.value
          .allPropertyPathes()
          .map(
            (x) => [e.key, ...x],
          )
          .expand((x) => x)
          .toList())
    ];
  }

  Object? valueForPath(List<String> path) {
    if (path.length == 1) {
      return properties[path.first];
    }
    final child = children[path.first]!;
    return child.valueForPath(path.skip(1).toList());
  }

  bool hasSameProperties(Configuration other) {
    final names = {
      ...properties.keys,
      ...children.keys,
    };
    final otherNames = {
      ...other.properties.keys,
      ...other.children.keys,
    };
    if (!const SetEquality<String>().equals(names, otherNames)) {
      return false;
    }

    for (var childKey in children.keys) {
      final child = children[childKey]!;
      final otherChild = other.children[childKey]!;
      if (!child.hasSameProperties(otherChild)) {
        return false;
      }
    }

    return true;
  }

  @override
  List<Object?> get props => [
        properties,
        children,
      ];
}
