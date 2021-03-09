import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:provider/provider.dart';
import 'package:tap_builder/tap_builder.dart';
import 'package:theme_definition_editor/state/app/state.dart';
import 'package:theme_definition_editor/state/editor/update.dart';
import 'package:theme_definition_editor/view/notifier.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class ExportEditorBar extends StatelessWidget {
  const ExportEditorBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    final exportOptions =
        context.select((ApplicationState state) => state.editor.exportOptions);

    final copiedToCliboard = context.select(
        (ApplicationState state) => state.editor.exportedCode.copiedToCliboard);
    return Container(
      color: theme.colors.background2,
      height: theme.fontSizes.regular * 5,
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.regular),
      child: Row(
        children: [
          Checkbox(
            isSelected: exportOptions.nullSafety,
            onSelectedChanged: (value) => context.dispatch(
              ChangeExportOptions(
                exportOptions.copyWith(
                  nullSafety: value,
                ),
              ),
            ),
            icon: theme.icons.checkmark,
          ),
          SizedBox(width: theme.spacing.regular),
          Text(
            'Null safety',
            style: theme.fontStyles.content.copyWith(
              color: theme.colors.foreground1,
              fontSize: theme.fontSizes.regular,
            ),
          ),
          SizedBox(width: theme.spacing.regular),
          Checkbox(
            isSelected: exportOptions.jsonParser,
            onSelectedChanged: (value) => context.dispatch(
              ChangeExportOptions(
                exportOptions.copyWith(
                  jsonParser: value,
                ),
              ),
            ),
            icon: theme.icons.checkmark,
          ),
          SizedBox(width: theme.spacing.regular),
          Text(
            'Json parsers',
            style: theme.fontStyles.content.copyWith(
              color: theme.colors.foreground1,
              fontSize: theme.fontSizes.regular,
            ),
          ),
          Spacer(),
          ActionButton(
            onTap: () => context.dispatch(CopyCodeToClipboard()),
            icon: copiedToCliboard
                ? theme.icons.checkmark
                : theme.icons.clipboard,
            title:
                copiedToCliboard ? 'Copied to clipboard!' : 'Copy to clipboard',
          ),
        ],
      ),
    );
  }
}

class Checkbox extends StatelessWidget {
  const Checkbox({
    Key? key,
    required this.isSelected,
    required this.onSelectedChanged,
    required this.icon,
  }) : super(key: key);

  final bool isSelected;
  final ValueChanged<bool> onSelectedChanged;
  final PathIconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    final background = isSelected
        ? theme.colors.accent1
        : theme.colors.foreground2.withOpacity(0.3);
    final foreground = isSelected
        ? theme.colors.foreground1
        : theme.colors.foreground1.withOpacity(0.0);
    return TapBuilder(
      onTap: () => onSelectedChanged(!isSelected),
      builder: (context, state) {
        return AnimatedContainer(
          duration: theme.durations.regular,
          padding: theme.edgeInsets.small,
          decoration: BoxDecoration(
            color: background,
            borderRadius: theme.borderRadiuses.regular,
          ),
          child: AnimatedPathIcon(
            icon,
            duration: theme.durations.regular,
            size: theme.fontSizes.regular,
            color: foreground,
          ),
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.icon,
    this.title,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  final PathIconData? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return TapBuilder(
      onTap: onTap,
      builder: (context, state) {
        return AnimatedContainer(
          duration: theme.durations.regular,
          padding: EdgeInsets.symmetric(
            vertical: theme.spacing.semiSmall,
            horizontal: theme.spacing.semiBig,
          ),
          decoration: BoxDecoration(
            color: theme.colors.accent1,
            borderRadius: theme.borderRadiuses.extraBig,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                AnimatedPathIcon(
                  icon!,
                  duration: theme.durations.regular,
                  size: theme.fontSizes.regular,
                  color: theme.colors.foreground1,
                ),
              SizedBox(width: theme.spacing.semiSmall),
              if (title != null)
                Text(
                  title!,
                  style: theme.fontStyles.content.copyWith(
                    color: theme.colors.foreground1,
                    fontSize: theme.fontSizes.regular,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
