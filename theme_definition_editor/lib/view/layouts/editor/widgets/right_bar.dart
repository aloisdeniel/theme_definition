import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:provider/provider.dart';
import 'package:tap_builder/tap_builder.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/editor/state.dart';
import 'package:theme_definition_editor/state/editor/update.dart';
import 'package:theme_definition_editor/view/notifier.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';
import 'package:theme_definition_editor/view/widgets/brightness_switch.dart';

class RightEditorBar extends StatelessWidget {
  const RightEditorBar({
    Key key,
    @required this.withCode,
  }) : super(key: key);

  final bool withCode;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    var mode = context.select((ApplicationState state) => state.editor.mode);
    var brightness = context
        .select((ApplicationState state) => state.editor.previewBrightness);
    if (!withCode && mode == EditorMode.code) {
      mode = EditorMode.preview;
    }
    return Container(
      color: theme.colors.background2,
      height: theme.fontSizes.regular * 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            () {
              switch (mode) {
                case EditorMode.preview:
                  return 'Preview';
                case EditorMode.export:
                  return 'Export';
                case EditorMode.code:
                  return 'Yaml Theme Editor';
              }
            }(),
            style: theme.fontStyles.title.copyWith(
              color: theme.colors.foreground2,
              fontSize: theme.fontSizes.regular,
            ),
          ),
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (withCode)
                  EditorBarTab(
                    icon: theme.icons.textEdit,
                    isSelected: mode == EditorMode.code,
                    onSelectedChanged: (isSelected) {
                      if (isSelected) {
                        context.dispatch(ChangeEditorMode(EditorMode.code));
                      }
                    },
                  ),
                EditorBarTab(
                  icon: theme.icons.palette,
                  isSelected: mode == EditorMode.preview,
                  onSelectedChanged: (isSelected) {
                    if (isSelected) {
                      context.dispatch(ChangeEditorMode(EditorMode.preview));
                    }
                  },
                ),
                EditorBarTab(
                  icon: theme.icons.exportCode,
                  isSelected: mode == EditorMode.export,
                  onSelectedChanged: (isSelected) {
                    if (isSelected) {
                      context.dispatch(ChangeEditorMode(EditorMode.export));
                    }
                  },
                ),
                Spacer(),
                BrightnessSwitch(
                  value: brightness,
                  onValueChanged: (v) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditorBarTab extends StatelessWidget {
  const EditorBarTab({
    Key key,
    @required this.isSelected,
    @required this.onSelectedChanged,
    @required this.icon,
  }) : super(key: key);

  final bool isSelected;
  final ValueChanged<bool> onSelectedChanged;
  final PathIconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    final color = isSelected ? theme.colors.accent1 : theme.colors.foreground2;
    return TapBuilder(
      onTap: () => onSelectedChanged(!isSelected),
      builder: (context, state) {
        return AnimatedContainer(
          duration: theme.durations.regular,
          margin: theme.edgeInsets.semiBig / 2,
          padding: theme.edgeInsets.semiBig / 2,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: theme.colors.accent1.withOpacity(isSelected ? 1.0 : 0.0),
                width: theme.fontSizes.regular * 0.2,
              ),
            ),
          ),
          child: AnimatedPathIcon(
            icon,
            duration: theme.durations.regular,
            size: theme.fontSizes.regular * 1.5,
            color: color,
          ),
        );
      },
    );
  }
}
