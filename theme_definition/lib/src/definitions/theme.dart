import 'package:equatable/equatable.dart';
import 'package:localization_builder/localization_builder.dart';
import 'package:theme_definition/src/definitions/colors.dart';
import 'package:theme_definition/src/definitions/font_sizes.dart';
import 'package:theme_definition/src/definitions/radius.dart';
import 'package:theme_definition/src/definitions/spacing.dart';
import 'package:theme_definition/theme_definition.dart';

import 'font_styles.dart';
import 'icons.dart';
import 'size.dart';

class ThemeDefinition extends Equatable {
  const ThemeDefinition({
    required this.name,
    required this.colors,
    required this.spacing,
    required this.fontStyles,
    required this.fontSizes,
    required this.radiuses,
    required this.icons,
    required this.durations,
    required this.sizes,
    required this.labels,
  });

  factory ThemeDefinition.empty() => ThemeDefinition(
        name: '',
        colors: const <VariantSet<Color>>[],
        spacing: const <VariantSet<Spacing>>[],
        fontStyles: const <VariantSet<FontStyle>>[],
        fontSizes: const <VariantSet<FontSize>>[],
        radiuses: const <VariantSet<Radius>>[],
        icons: const <VariantSet<Icon>>[],
        durations: const <VariantSet<Duration>>[],
        sizes: const <VariantSet<Size>>[],
        labels: null,
      );

  final String name;
  final List<VariantSet<Color>> colors;
  final List<VariantSet<Spacing>> spacing;
  final List<VariantSet<FontStyle>> fontStyles;
  final List<VariantSet<FontSize>> fontSizes;
  final List<VariantSet<Radius>> radiuses;
  final List<VariantSet<Icon>> icons;
  final List<VariantSet<Duration>> durations;
  final List<VariantSet<Size>> sizes;
  final Localizations? labels;

  @override
  List<Object?> get props => [
        name,
        colors,
        spacing,
        fontStyles,
        fontSizes,
        radiuses,
        icons,
        durations,
        sizes,
        labels,
      ];
}

class VariantSet<T> extends Equatable {
  const VariantSet({
    required this.name,
    required this.constants,
  });
  final String name;
  final List<ConstantDefinition<T>> constants;
  Set<String> get constantNames => constants.map((c) => c.name).toSet();

  T getValue(String name) => constants.firstWhere((x) => x.name == name).value;

  @override
  List<Object?> get props => [name, constants];
}

class ConstantDefinition<T> extends Equatable {
  const ConstantDefinition({
    required this.name,
    required this.value,
  });
  final String name;
  final T value;

  @override
  List<Object?> get props => [name, value];
}
