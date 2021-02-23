import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:theme_definition/theme_definition.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/colors.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/durations.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/font_sizes.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/font_styles.dart';
import 'package:theme_definition_editor/view/layouts/preview/widgets/spacing.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

import 'widgets/icons.dart';
import 'widgets/radiuses.dart';
import 'widgets/sizes.dart';

class ThemePreviewLayout extends StatelessWidget {
  const ThemePreviewLayout({
    Key key,
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
        ],
      ),
    );
  }
}

typedef Widget _PreviewTileBuilder<T>(BuildContext context, String name);

class _Section<T> extends StatelessWidget {
  const _Section(
      {Key key,
      @required this.title,
      @required this.variants,
      @required this.builder})
      : super(key: key);

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
