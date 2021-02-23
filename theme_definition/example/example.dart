import 'dart:io';

import 'package:theme_definition/src/generators/theme.dart';
import 'package:theme_definition/theme_definition.dart';

Future<void> main() async {
  var result =
      await ThemeDefinitionParser().parseFile(File('example.theme.yaml'));
  result.map(
    empty: () {
      print('empty file');
    },
    succeeded: (succeeded) {
      final dart = generateTheme(succeeded.definition, nullSafety: false);
      print('succeeded: ${dart}');
    },
    failed: (failed) {
      print('failed: ${failed.exception}');
    },
  );
}
