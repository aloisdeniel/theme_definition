class InhheritedWidgetClassBuilder {
  final String name;

  const InhheritedWidgetClassBuilder(this.name);

  String build({
    bool nullSafety = true,
  }) {
    final name = '${this.name}Theme';
    return '''class ${name} extends InheritedWidget {
  const ${name}({
    Key${nullSafety ? '?' : ''} key,
    ${nullSafety ? '' : '@'}required this.data,
    ${nullSafety ? '' : '@'}required Widget child,
  }) : super(key: key, child: child);

  final ${name}Data data;

  static ${name}Data of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<${name}>();
    return widget?.data ?? ${name}Data.fallback();
  }

  @override
  bool updateShouldNotify(covariant ${name} oldWidget) {
    return this.data != oldWidget.data;
  }
}''';
  }
}
