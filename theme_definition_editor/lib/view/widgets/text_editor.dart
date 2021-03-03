import 'dart:math' as math;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';
import 'package:theme_definition_editor/view/theme/theme.dart';

class StyledRange extends Equatable {
  const StyledRange({
    required this.style,
    required this.start,
    required this.end,
  });
  final TextStyle style;
  final int start;
  final int end;
  bool get isEmpty => end - start <= 0;

  @override
  List<Object> get props => [style, start, end];
}

class StatelessTextField extends StatefulWidget {
  const StatelessTextField({
    Key? key,
    required this.text,
    required this.onTextChanged,
    this.style,
    this.maxLines,
    this.styles = const <StyledRange>[],
    this.padding,
  }) : super(key: key);

  final String text;
  final ValueChanged<String> onTextChanged;
  final int? maxLines;
  final TextStyle? style;
  final List<StyledRange> styles;
  final EdgeInsets? padding;

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<StatelessTextField> {
  _HighlightedController? controller;

  @override
  void initState() {
    controller = _HighlightedController(
      widget.text,
    );
    controller!.styles = widget.styles;
    controller!.addListener(onTextEdited);
    super.initState();
  }

  void onTextEdited() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StatelessTextField oldWidget) {
    final controller = this.controller;
    if (controller != null) {
      if (widget.text != controller.text) {
        controller.text = widget.text;
        controller.styles = widget.styles;
        setState(() {});
      } else if (!const ListEquality()
          .equals(widget.styles, controller.styles)) {
        controller.styles = widget.styles;
        setState(() {});
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.removeListener(onTextEdited);
    controller?.dispose();
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
  _HighlightedController(String text) : super(text: text);

  List<StyledRange> _styles = [];
  List<StyledRange> get styles => _styles;
  set styles(List<StyledRange> value) {
    if (!const ListEquality().equals(_styles, value)) {
      _styles = value;
      this.notifyListeners();
    }
  }

  @override
  TextSpan buildTextSpan({TextStyle? style, required bool withComposing}) {
    if (text.isNotEmpty && styles.isNotEmpty) {
      final spans = <TextSpan>[];

      void addSpan(int start, int end, TextStyle style) {
        if (text.isNotEmpty) {
          final l = text.length;
          print(l);
          final subtext = text.substring(
            start.clamp(0, text.length - 1),
            end.clamp(0, text.length),
          );
          if (subtext.isNotEmpty) {
            spans.add(
              TextSpan(
                text: subtext,
                style: style,
              ),
            );
          }
        }
      }

      var previousEnd = 0;
      final styles = this.styles.toList()
        ..sort((x, y) => x.start.compareTo(y.start));
      for (var rangeStyle in styles) {
        if (rangeStyle.start - previousEnd > 0) {
          addSpan(previousEnd, rangeStyle.start, style ?? const TextStyle());
        }
        final start = math.max(previousEnd, rangeStyle.start);
        final end = math.max(start, rangeStyle.end);
        addSpan(
          start,
          end,
          rangeStyle.style,
        );
        previousEnd = rangeStyle.end;
      }

      if (previousEnd < text.length) {
        addSpan(previousEnd, text.length, style ?? const TextStyle());
      }

      return TextSpan(
        children: spans,
      );
    }

    return super.buildTextSpan(
      style: style,
      withComposing: withComposing,
    );
  }
}
