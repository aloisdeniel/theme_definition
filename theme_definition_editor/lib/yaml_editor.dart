import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';

class ExampleTheme extends InheritedWidget {
  const ExampleTheme({
    Key key,
    @required this.data,
    Widget child,
  }) : super(key: key, child: child);

  final ExampleThemeData data;

  ExampleThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ExampleTheme>();
    return widget?.data ?? ExampleThemeData.fallback();
  }

  @override
  bool updateShouldNotify(covariant ExampleTheme oldWidget) {
    return this.data != oldWidget.data;
  }
}

class ExampleThemeData {
  const ExampleThemeData({
    @required this.colors,
    @required this.fontStyles,
    @required this.icons,
    @required this.radiuses,
    @required this.borderRadiuses,
    @required this.spacing,
    @required this.edgeInsets,
  })  : assert(colors != null),
        assert(fontStyles != null),
        assert(icons != null),
        assert(radiuses != null),
        assert(borderRadiuses != null),
        assert(spacing != null),
        assert(edgeInsets != null);

  const ExampleThemeData.fallback()
      : this.colors = const ExampleColorsData.light(),
        this.fontStyles = const ExampleFontStylesData.regular(),
        this.icons = const ExampleIconsData.filled(),
        this.radiuses = const ExampleRadiusesData.regular(),
        this.borderRadiuses = const ExampleBorderRadiusesData.regular(),
        this.spacing = const ExampleSpacingData.regular(),
        this.edgeInsets = const ExampleEdgeInsetsData.regular();

  final ExampleColorsData colors;
  final ExampleFontStylesData fontStyles;
  final ExampleIconsData icons;
  final ExampleRadiusesData radiuses;
  final ExampleBorderRadiusesData borderRadiuses;
  final ExampleSpacingData spacing;
  final ExampleEdgeInsetsData edgeInsets;

  ExampleThemeData copyWith({
    ExampleColorsData colors,
    ExampleFontStylesData fontStyles,
    ExampleIconsData icons,
    ExampleRadiusesData radiuses,
    ExampleBorderRadiusesData borderRadiuses,
    ExampleSpacingData spacing,
    ExampleEdgeInsetsData edgeInsets,
  }) =>
      ExampleThemeData(
        colors: colors ?? this.colors,
        fontStyles: fontStyles ?? this.fontStyles,
        icons: icons ?? this.icons,
        radiuses: radiuses ?? this.radiuses,
        borderRadiuses: borderRadiuses ?? this.borderRadiuses,
        spacing: spacing ?? this.spacing,
        edgeInsets: edgeInsets ?? this.edgeInsets,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleThemeData &&
          colors == other.colors &&
          fontStyles == other.fontStyles &&
          icons == other.icons &&
          radiuses == other.radiuses &&
          borderRadiuses == other.borderRadiuses &&
          spacing == other.spacing &&
          edgeInsets == other.edgeInsets);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      colors.hashCode ^
      fontStyles.hashCode ^
      icons.hashCode ^
      radiuses.hashCode ^
      borderRadiuses.hashCode ^
      spacing.hashCode ^
      edgeInsets.hashCode;
}

class ExampleColorsData {
  const ExampleColorsData({
    @required this.accent,
    @required this.foreground,
    @required this.background,
  })  : assert(accent != null),
        assert(foreground != null),
        assert(background != null);

  const ExampleColorsData.light()
      : this.accent = const Color(0xFFFF3E9A),
        this.foreground = const Color(0xFF000000),
        this.background = const Color(0xFFFFFFFF);

  const ExampleColorsData.dark()
      : this.accent = const Color(0xFFFF3E9A),
        this.foreground = const Color(0xFFFFFFFF),
        this.background = const Color(0xFF000000);

  final Color accent;
  final Color foreground;
  final Color background;

  ExampleColorsData copyWith({
    Color accent,
    Color foreground,
    Color background,
  }) =>
      ExampleColorsData(
        accent: accent ?? this.accent,
        foreground: foreground ?? this.foreground,
        background: background ?? this.background,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleColorsData &&
          accent == other.accent &&
          foreground == other.foreground &&
          background == other.background);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      accent.hashCode ^
      foreground.hashCode ^
      background.hashCode;
}

class ExampleFontStylesData {
  const ExampleFontStylesData({
    @required this.title,
    @required this.content,
  })  : assert(title != null),
        assert(content != null);

  const ExampleFontStylesData.regular()
      : this.title = const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
        ),
        this.content = const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        );

  const ExampleFontStylesData.handwritten()
      : this.title = const TextStyle(
          fontFamily: 'Architects Daughter',
          fontWeight: FontWeight.w400,
        ),
        this.content = const TextStyle(
          fontFamily: 'Yantramanav',
          fontWeight: FontWeight.w400,
        );

  final TextStyle title;
  final TextStyle content;

  ExampleFontStylesData copyWith({
    TextStyle title,
    TextStyle content,
  }) =>
      ExampleFontStylesData(
        title: title ?? this.title,
        content: content ?? this.content,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleFontStylesData &&
          title == other.title &&
          content == other.content);
  @override
  int get hashCode => runtimeType.hashCode ^ title.hashCode ^ content.hashCode;
}

class ExampleSpacingData {
  const ExampleSpacingData({
    @required this.small,
    @required this.regular,
    @required this.big,
  })  : assert(small != null),
        assert(regular != null),
        assert(big != null);

  const ExampleSpacingData.regular()
      : this.small = 4,
        this.regular = 20,
        this.big = 32;

  final double small;
  final double regular;
  final double big;

  ExampleSpacingData copyWith({
    double small,
    double regular,
    double big,
  }) =>
      ExampleSpacingData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleSpacingData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ small.hashCode ^ regular.hashCode ^ big.hashCode;
}

class ExampleEdgeInsetsData {
  const ExampleEdgeInsetsData({
    @required this.small,
    @required this.regular,
    @required this.big,
  })  : assert(small != null),
        assert(regular != null),
        assert(big != null);

  const ExampleEdgeInsetsData.regular()
      : this.small = const EdgeInsets.all(4),
        this.regular = const EdgeInsets.all(20),
        this.big = const EdgeInsets.all(32);

  final EdgeInsets small;
  final EdgeInsets regular;
  final EdgeInsets big;

  ExampleEdgeInsetsData copyWith({
    EdgeInsets small,
    EdgeInsets regular,
    EdgeInsets big,
  }) =>
      ExampleEdgeInsetsData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleEdgeInsetsData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ small.hashCode ^ regular.hashCode ^ big.hashCode;
}

class ExampleRadiusesData {
  const ExampleRadiusesData({
    @required this.small,
    @required this.regular,
    @required this.big,
  })  : assert(small != null),
        assert(regular != null),
        assert(big != null);

  const ExampleRadiusesData.regular()
      : this.small = const Radius.circular(2),
        this.regular = const Radius.circular(4),
        this.big = const Radius.circular(12);

  final Radius small;
  final Radius regular;
  final Radius big;

  ExampleRadiusesData copyWith({
    Radius small,
    Radius regular,
    Radius big,
  }) =>
      ExampleRadiusesData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleRadiusesData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ small.hashCode ^ regular.hashCode ^ big.hashCode;
}

class ExampleBorderRadiusesData {
  const ExampleBorderRadiusesData({
    @required this.small,
    @required this.regular,
    @required this.big,
  })  : assert(small != null),
        assert(regular != null),
        assert(big != null);

  const ExampleBorderRadiusesData.regular()
      : this.small = const BorderRadius.all(Radius.circular(2)),
        this.regular = const BorderRadius.all(Radius.circular(4)),
        this.big = const BorderRadius.all(Radius.circular(12));

  final BorderRadius small;
  final BorderRadius regular;
  final BorderRadius big;

  ExampleBorderRadiusesData copyWith({
    BorderRadius small,
    BorderRadius regular,
    BorderRadius big,
  }) =>
      ExampleBorderRadiusesData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleBorderRadiusesData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ small.hashCode ^ regular.hashCode ^ big.hashCode;
}

class ExampleIconsData {
  const ExampleIconsData({
    @required PathIconData heart,
    @required PathIconData send,
  })  : _heart = heart,
        _send = send;

  const ExampleIconsData._()
      : _heart = null,
        _send = null;

  const factory ExampleIconsData.filled() = _Filled;
  final PathIconData _heart;
  PathIconData get heart => _heart != null ? _heart : throw Exception();
  final PathIconData _send;
  PathIconData get send => _send != null ? _send : throw Exception();

  ExampleIconsData copyWith({
    PathIconData heart,
    PathIconData send,
  }) =>
      ExampleIconsData(
        heart: heart ?? this.heart,
        send: send ?? this.send,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleIconsData && heart == other.heart && send == other.send);
  @override
  int get hashCode => runtimeType.hashCode ^ heart.hashCode ^ send.hashCode;
}

class _Filled extends ExampleIconsData {
  const _Filled() : super._();

  @override
  PathIconData get heart => _heartInstance;
  static final _heartInstance = PathIconData.fromSvg(
      '<svg width="25" height="23" viewBox="0 0 25 23" fill="none" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" clip-rule="evenodd" d="M8.13762 3.28223C6.9562 3.23498 5.80439 3.65897 4.93559 4.46095C4.06678 5.26292 3.55214 6.37718 3.50488 7.5586C3.48148 8.14358 3.57353 8.72745 3.77578 9.27685C3.97522 9.81863 4.27796 10.3164 4.66712 10.7427L12.8435 18.9191L21.0199 10.7427C21.8112 9.87601 22.2291 8.73191 22.1821 7.5586C22.1349 6.37718 21.6202 5.26292 20.7514 4.46095C19.8826 3.65897 18.7308 3.23498 17.5494 3.28223C16.368 3.32949 15.2537 3.84413 14.4517 4.71293C14.3821 4.78842 14.3037 4.85539 14.2183 4.91246C13.8113 5.18436 13.3329 5.32948 12.8435 5.32948C12.3541 5.32948 11.8757 5.18436 11.4687 4.91246C11.3833 4.85539 11.305 4.78842 11.2353 4.71293C10.4333 3.84413 9.31904 3.32949 8.13762 3.28223ZM3.16878 2.5469C4.54522 1.27634 6.37001 0.604609 8.24173 0.679478C9.96761 0.748513 11.603 1.44713 12.8435 2.6347C14.084 1.44713 15.7194 0.748513 17.4453 0.679478C19.317 0.604609 21.1418 1.27634 22.5182 2.5469C23.8947 3.81747 24.71 5.58278 24.7849 7.45449C24.8597 9.32621 24.188 11.151 22.9175 12.5274C22.9057 12.5402 22.8937 12.5527 22.8814 12.565L13.7645 21.6819C13.5202 21.9262 13.1889 22.0634 12.8435 22.0634C12.4981 22.0634 12.1668 21.9262 11.9226 21.6819L2.80563 12.565C2.79335 12.5527 2.78133 12.5402 2.76955 12.5274C2.14044 11.8459 1.65172 11.0471 1.33131 10.1767C1.01089 9.30628 0.865057 8.38127 0.902128 7.45449C0.976997 5.58278 1.79233 3.81747 3.16878 2.5469Z" fill="black"/> </svg>');
  @override
  PathIconData get send => _sendInstance;
  static final _sendInstance = PathIconData.fromData(
      'M26.4847 1.31143C26.8418 1.66849 26.9603 2.19977 26.7888 2.67472L18.3235 26.1183C18.3113 26.1522 18.2976 26.1857 18.2825 26.2185C18.1215 26.5699 17.863 26.8677 17.5376 27.0765C17.2123 27.2853 16.8339 27.3962 16.4473 27.3962C16.0608 27.3962 15.6823 27.2853 15.357 27.0765C15.0395 26.8727 14.7856 26.5841 14.6238 26.2437L10.2664 17.5298L1.553 13.1728C1.21252 13.0111 0.923931 12.7572 0.72015 12.4396C0.511374 12.1143 0.400391 11.7359 0.400391 11.3493C0.400391 10.9628 0.511373 10.5843 0.72015 10.259C0.928926 9.93368 1.22672 9.67513 1.57813 9.51409C1.61096 9.49905 1.64439 9.48538 1.67835 9.47311L25.1214 1.0074C25.5963 0.835883 26.1276 0.954365 26.4847 1.31143ZM12.8219 16.8161L16.3589 23.8894L22.3555 7.28259L12.8219 16.8161ZM20.5133 5.44094L3.90727 11.4377L10.98 14.9742L20.5133 5.44094Z');
}
