import '../base.dart';

class DataClassBuilder {
  final String name;
  final Map<String, String> properties = {};
  final Map<String, Map<String, String>> constructors = {};
  final bool isConst;

  DataClassBuilder(
    this.name, {
    this.isConst = true,
  });

  void addProperty(String type, String name) {
    properties[name] = type;
  }

  void addConstructor(String name, Map<String, String> properties) {
    constructors[name] = properties;
  }

  String build({
    bool nullSafety = true,
  }) {
    final propertyNames = properties.keys.toList();

    final buffer = StringBuffer('class ${name} \{\n');

    if (isConst) {
      // Default constructor
      buffer.writeln();
      buffer.writeln('  const $name({');
      for (var propertyName in propertyNames) {
        propertyName = createFieldName(propertyName);
        buffer.writeln(
            '    ${nullSafety ? '' : '@'}required this.$propertyName,');
      }
      buffer.write('  })');

      if (!nullSafety && propertyNames.isNotEmpty) {
        buffer.writeln(' : ');
        for (var i = 0; i < propertyNames.length; i++) {
          var propertyName = propertyNames[i];
          propertyName = createFieldName(propertyName);
          buffer.write('    assert($propertyName != null)');
          buffer.writeln(i == propertyNames.length - 1 ? ';' : ',');
        }
      } else {
        buffer.writeln(';');
      }

      // Constructors
      for (var constructor in constructors.entries) {
        buffer.writeln();
        buffer.write('  const $name.${constructor.key}()');
        if (properties.isNotEmpty) {
          buffer.writeln(' : ');
          for (var i = 0; i < propertyNames.length; i++) {
            var propertyName = propertyNames[i];
            final value = constructor.value[propertyName];
            propertyName = createFieldName(propertyName);
            buffer.write('    this.${propertyName} = $value');
            buffer.writeln(i == propertyNames.length - 1 ? ';' : ',');
          }
        }
      }

      // Properties
      if (propertyNames.isNotEmpty) {
        buffer.writeln();
        for (var propertyName in propertyNames) {
          final propertyType = properties[propertyName];
          propertyName = createFieldName(propertyName);
          buffer.writeln('  final $propertyType $propertyName;');
        }
      }
    } else {
      // Default constructor
      buffer.writeln();
      buffer.writeln('  const $name({');
      for (var propertyName in propertyNames) {
        final propertyType = properties[propertyName];
        propertyName = createFieldName(propertyName);
        buffer.writeln(
            '    ${nullSafety ? '' : '@'}required $propertyType $propertyName,');
      }
      buffer.writeln('  }) : ');

      if (propertyNames.isNotEmpty) {
        for (var i = 0; i < propertyNames.length; i++) {
          var propertyName = propertyNames[i];
          propertyName = createFieldName(propertyName);
          buffer.write('    _${propertyName} = ${propertyName}');
          buffer.writeln(i == propertyNames.length - 1 ? ';' : ',');
        }
      } else {
        buffer.writeln(';');
      }

      // Default null constructor
      buffer.writeln();
      buffer.writeln('  const $name._() : ');

      if (propertyNames.isNotEmpty) {
        for (var i = 0; i < propertyNames.length; i++) {
          var propertyName = propertyNames[i];
          propertyName = createFieldName(propertyName);
          buffer.write('    _${propertyName} = null');
          buffer.writeln(i == propertyNames.length - 1 ? ';' : ',');
        }
      } else {
        buffer.writeln(';');
      }

      // Constructors
      for (var constructor in constructors.entries) {
        buffer.writeln();

        buffer.write(
            '  const factory $name.${constructor.key}() = _$name${createClassdName(constructor.key)};');
      }

      // Properties
      if (propertyNames.isNotEmpty) {
        buffer.writeln();
        for (var propertyName in propertyNames) {
          final propertyType = properties[propertyName];
          propertyName = createFieldName(propertyName);
          buffer.writeln(
              '  final $propertyType${nullSafety ? '?' : ''} _$propertyName;');
          buffer.writeln(
              '  $propertyType get $propertyName => ${nullSafety ? '_$propertyName!' : '_$propertyName != null ? _$propertyName : throw Exception()'};');
        }
      }
    }

    // CopyWith
    buffer.writeln();
    buffer.writeln('  $name copyWith({');
    for (var propertyName in properties.keys) {
      final propertyType = properties[propertyName];
      propertyName = createFieldName(propertyName);
      buffer
          .writeln('    $propertyType${nullSafety ? '?' : ''} $propertyName,');
    }
    buffer.writeln('  }) => $name(');
    for (var propertyName in properties.keys) {
      propertyName = createFieldName(propertyName);
      buffer.writeln('    $propertyName: $propertyName ?? this.$propertyName,');
    }
    buffer.writeln('  );');

    // Operator ==
    buffer.writeln();
    buffer.writeln('  @override');
    buffer.write('  bool operator ==(Object other) => ');
    buffer.writeln('identical(this, other) || (other is $name');
    for (var propertyName in properties.keys) {
      propertyName = createFieldName(propertyName);
      buffer.writeln('     && $propertyName == other.$propertyName');
    }
    buffer.writeln('  );');

    // Hashcode
    buffer.writeln('  @override');
    buffer.writeln('  int get hashCode => runtimeType.hashCode');
    for (var i = 0; i < propertyNames.length; i++) {
      var propertyName = propertyNames[i];
      propertyName = createFieldName(propertyName);
      buffer.writeln(
          '    ^ $propertyName.hashCode${i == propertyNames.length - 1 ? ';' : ''}');
    }

    buffer.writeln('}');

    // Final classes
    if (!isConst) {
      for (var constructor in constructors.entries) {
        buffer.writeln();
        buffer.writeln(
            'class _${name}${createClassdName(constructor.key)} extends ${name} \{\n');

        buffer.writeln(
            '  const _${name}${createClassdName(constructor.key)}() : super._();');

        // Properties
        if (propertyNames.isNotEmpty) {
          buffer.writeln();
          for (var propertyName in propertyNames) {
            final propertyType = properties[propertyName];
            final value = constructor.value[propertyName];
            propertyName = createFieldName(propertyName);
            buffer.writeln('  @override');
            buffer.writeln(
                '  $propertyType get $propertyName => _${propertyName}Instance;');
            buffer
                .writeln('  static final _${propertyName}Instance = ${value};');
          }
        }

        buffer.writeln('}');
      }
    }

    return buffer.toString();
  }
}
