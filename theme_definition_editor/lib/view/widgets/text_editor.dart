import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class StatelessTextField extends StatefulWidget {
  const StatelessTextField({
    Key key,
    @required this.text,
    @required this.onTextChanged,
    this.style,
    this.maxLines,
    this.errorRange = TextRange.empty,
    this.errorStyle,
    this.padding,
  }) : super(key: key);

  final String text;
  final ValueChanged<String> onTextChanged;
  final int maxLines;
  final TextStyle style;
  final TextRange errorRange;
  final TextStyle errorStyle;
  final EdgeInsets padding;

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<StatelessTextField> {
  _HighlightedController controller;

  @override
  void initState() {
    controller = _HighlightedController(
      widget.text,
      widget.errorStyle ??
          TextStyle(
            backgroundColor: Colors.red,
          ),
    );
    controller.errorRange = widget.errorRange;
    controller.addListener(onTextEdited);
    super.initState();
  }

  void onTextEdited() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StatelessTextField oldWidget) {
    if (widget.text != controller.text) {
      controller.text = widget.text;
      controller.errorRange = widget.errorRange;
      setState(() {});
    } else if (widget.errorRange != controller.errorRange) {
      controller.errorRange = widget.errorRange;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(onTextEdited);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YamlTheme.of(context);
    return TextField(
      controller: controller,
      onChanged: widget.onTextChanged,
      maxLines: widget.maxLines,
      style: widget.style,
      cursorColor: theme.colors.accent1,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        border: InputBorder.none,
        focusColor: theme.colors.accent1,
        hoverColor: theme.colors.accent1,
        contentPadding: widget.padding ?? EdgeInsets.zero,
      ),
    );
  }
}

class _HighlightedController extends TextEditingController {
  _HighlightedController(String text, this.errorStyle) : super(text: text);

  final TextStyle errorStyle;
  TextRange _errorRange = TextRange.empty;
  TextRange get errorRange => _errorRange;
  set errorRange(TextRange value) {
    if (_errorRange != value) {
      _errorRange = value;
      this.notifyListeners();
    }
  }

  @override
  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    final initial = super.buildTextSpan(
      style: style,
      withComposing: withComposing,
    );

    if (!errorRange.isCollapsed && text != null && text.isNotEmpty) {
      final startOffet = math.max(0, errorRange.start);
      final endOffet = math.min(text.length, errorRange.end);
      final beforeError = startOffet == 0 ? '' : text.substring(0, startOffet);
      final error = text.substring(startOffet, endOffet);
      final afterError =
          endOffet == text.length ? '' : text.substring(endOffet, text.length);
      return TextSpan(
        children: [
          if (beforeError.isNotEmpty)
            TextSpan(
              text: beforeError,
              style: style,
            ),
          if (error.isNotEmpty)
            TextSpan(
              text: error,
              style: errorStyle,
            ),
          if (afterError.isNotEmpty)
            TextSpan(
              text: afterError,
              style: style,
            ),
        ],
      );
    }

    return initial;
  }
}
