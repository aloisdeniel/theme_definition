import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition/theme_definition.dart';
import 'package:localization_builder/localization_builder.dart'
    as localization_builder;
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/colors.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/durations.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/font_sizes.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/font_styles.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/spacing.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

import 'widgets/icons.dart';
import 'widgets/labels.dart';
import 'widgets/radiuses.dart';
import 'widgets/sizes.dart';

class ThemePreviewLayout extends StatelessWidget {
  const ThemePreviewLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSucceeded = context
        .select((ApplicationState state) => state.editor.parsingResult.map(
              empty: () => true,
              succeeded: (succeeded) => true,
              failed: (failed) => false,
            ));

    if (!isSucceeded) {
      return SizedBox();
    }
    final definition = context
        .select((ApplicationState state) => state.editor.parsingResult.map(
              empty: () => ThemeDefinition.empty(),
              succeeded: (succeeded) => succeeded.definition,
              failed: (failed) => throw Exception(),
            ));

    return Container(
      child: ListView(
        children: [
          _Section(
            title: 'Colors',
            variants: definition.colors,
            builder: (context, name) => ColorPreviewTile(
              name: name,
              variants: definition.colors,
            ),
          ),
          _Section(
            title: 'FontStyles',
            variants: definition.fontStyles,
            builder: (context, name) => FontStylePreviewTile(
              name: name,
              variants: definition.fontStyles,
            ),
          ),
          _Section(
            title: 'Spacing',
            variants: definition.spacing,
            builder: (context, name) => SpacingStylePreviewTile(
              name: name,
              variants: definition.spacing,
            ),
          ),
          _Section(
            title: 'FontSizes',
            variants: definition.fontSizes,
            builder: (context, name) => FontSizeStylePreviewTile(
              name: name,
              variants: definition.fontSizes,
            ),
          ),
          _Section(
            title: 'BorderRadiuses',
            variants: definition.radiuses,
            builder: (context, name) => RadiusPreviewTile(
              name: name,
              variants: definition.radiuses,
            ),
          ),
          _Section(
            title: 'Sizes',
            variants: definition.sizes,
            builder: (context, name) => SizePreviewTile(
              name: name,
              variants: definition.sizes,
            ),
          ),
          _Section(
            title: 'Durations',
            variants: definition.durations,
            builder: (context, name) => DurationPreviewTile(
              name: name,
              variants: definition.durations,
            ),
          ),
          _Section(
            title: 'Icons',
            variants: definition.icons,
            builder: (context, name) => IconPreviewTile(
              name: name,
              variants: definition.icons,
            ),
          ),
          if (definition.labels != null)
            _LabelsSection(
              title: 'Labels',
              localizations: definition.labels!,
            ),
        ],
      ),
    );
  }
}

typedef Widget _PreviewTileBuilder<T>(BuildContext context, String name);

class _Section<T> extends StatelessWidget {
  const _Section({
    Key? key,
    required this.title,
    required this.variants,
    required this.builder,
  }) : super(key: key);

  final String title;
  final List<VariantSet<T>> variants;
  final _PreviewTileBuilder builder;

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) {
      return SizedBox();
    }
    final theme = YamlTheme.of(context);
    final items = variants.first.constantNames.toList();
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.fontStyles.title.copyWith(
              color: theme.colors.foreground1,
              fontSize: theme.fontSizes.big,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                    ),
                    ...variants.map(
                      (variant) => SizedBox(
                        width: 200,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colors.background2,
                              borderRadius: theme.borderRadiuses.big,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: theme.spacing.small,
                              horizontal: theme.spacing.semiBig,
                            ),
                            child: Text(
                              variant.name,
                              textAlign: TextAlign.center,
                              style: theme.fontStyles.content.copyWith(
                                color: theme.colors.foreground1,
                                fontSize: theme.fontSizes.regular,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...items.map(
                  (name) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: builder(context, name),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelsSection extends StatelessWidget {
  const _LabelsSection({
    Key? key,
    required this.title,
    required this.localizations,
  }) : super(key: key);

  final String title;
  final localization_builder.Localizations localizations;

  Iterable<Widget> _labels(
    BuildContext context,
    localization_builder.Section section,
    int level,
  ) sync* {
    final theme = YamlTheme.of(context);

    for (var label in section.labels) {
      yield Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: LabelTile(
          level: level,
          languageCodes: localizations.supportedLanguageCodes,
          label: label,
          name: label.key,
        ),
      );
    }

    for (var child in section.children) {
      yield Padding(
        padding: EdgeInsets.only(top: theme.spacing.regular),
        child: SizedBox(
          width: 200,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...Iterable.generate(
                level,
                (i) => PathIcon(
                  theme.icons.pointLine,
                  size: theme.fontSizes.regular,
                  color: theme.colors.foreground2.withOpacity(0.3),
                ),
              ),
              if (level > 0) ...[
                PathIcon(
                  theme.icons.cornerLine,
                  size: theme.fontSizes.regular,
                  color: theme.colors.foreground2,
                ),
                SizedBox(width: theme.spacing.semiSmall),
              ],
              Text(
                child.key,
                style: theme.fontStyles.content.copyWith(
                  color: theme.colors.foreground1,
                  fontSize: theme.fontSizes.regular,
                ),
              ),
            ],
          ),
        ),
      );
      yield* _labels(context, child, level + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (localizations.labels.isEmpty && localizations.children.isEmpty) {
      return SizedBox();
    }
    final theme = YamlTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 32.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.fontStyles.title.copyWith(
              color: theme.colors.foreground1,
              fontSize: theme.fontSizes.big,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                    ),
                    ...localizations.supportedLanguageCodes.map(
                      (variant) => SizedBox(
                        width: 200,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colors.background2,
                              borderRadius: theme.borderRadiuses.big,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: theme.spacing.small,
                              horizontal: theme.spacing.semiBig,
                            ),
                            child: Text(
                              variant,
                              textAlign: TextAlign.center,
                              style: theme.fontStyles.content.copyWith(
                                color: theme.colors.foreground1,
                                fontSize: theme.fontSizes.regular,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ..._labels(context, localizations, 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
