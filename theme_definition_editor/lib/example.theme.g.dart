import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';

import 'package:intl/locale.dart';
import 'package:template_string/template_string.dart';

import 'package:google_fonts/google_fonts.dart';

class ExampleTheme extends InheritedWidget {
  const ExampleTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final ExampleThemeData data;

  static ExampleThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ExampleTheme>();
    return widget?.data ?? ExampleThemeData.fallback();
  }

  @override
  bool updateShouldNotify(covariant ExampleTheme oldWidget) {
    return this.data != oldWidget.data;
  }
}

class ExampleColorsData {
  const ExampleColorsData({
    required this.accent,
    required this.foreground,
    required this.background,
  });

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
  factory ExampleColorsData.fromJson(Map<String, Object?> map) =>
      ExampleColorsData(
        accent: _parseColor(map['accent']!),
        foreground: _parseColor(map['foreground']!),
        background: _parseColor(map['background']!),
      );

  ExampleColorsData copyWith({
    Color? accent,
    Color? foreground,
    Color? background,
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
    required TextStyle title,
    required TextStyle content,
  })   : _title = title,
        _content = content;

  const ExampleFontStylesData._()
      : _title = null,
        _content = null;

  const factory ExampleFontStylesData.regular() = _ExampleFontStylesDataRegular;
  const factory ExampleFontStylesData.handwritten() =
      _ExampleFontStylesDataHandwritten;
  final TextStyle? _title;
  TextStyle get title => _title!;
  final TextStyle? _content;
  TextStyle get content => _content!;
  factory ExampleFontStylesData.fromJson(Map<String, Object?> map) =>
      ExampleFontStylesData(
        title: _parseTextStyle(map['title']!),
        content: _parseTextStyle(map['content']!),
      );

  ExampleFontStylesData copyWith({
    TextStyle? title,
    TextStyle? content,
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

class _ExampleFontStylesDataRegular extends ExampleFontStylesData {
  const _ExampleFontStylesDataRegular() : super._();

  @override
  TextStyle get title => _titleInstance;
  static final _titleInstance = GoogleFonts.getFont(
    'Montserrat',
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );
  @override
  TextStyle get content => _contentInstance;
  static final _contentInstance = const TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
}

class _ExampleFontStylesDataHandwritten extends ExampleFontStylesData {
  const _ExampleFontStylesDataHandwritten() : super._();

  @override
  TextStyle get title => _titleInstance;
  static final _titleInstance = GoogleFonts.getFont(
    'Architects Daughter',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
  @override
  TextStyle get content => _contentInstance;
  static final _contentInstance = GoogleFonts.getFont(
    'Yantramanav',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
}

class ExampleFontSizesData {
  const ExampleFontSizesData({
    required this.medium,
    required this.regular,
  });

  const ExampleFontSizesData.regular()
      : this.medium = 10.00,
        this.regular = 12.00;

  const ExampleFontSizesData.big()
      : this.medium = 15.00,
        this.regular = 22.00;

  final double medium;
  final double regular;
  factory ExampleFontSizesData.fromJson(Map<String, Object?> map) =>
      ExampleFontSizesData(
        medium: (map['medium']! as num).toDouble(),
        regular: (map['regular']! as num).toDouble(),
      );

  ExampleFontSizesData copyWith({
    double? medium,
    double? regular,
  }) =>
      ExampleFontSizesData(
        medium: medium ?? this.medium,
        regular: regular ?? this.regular,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleFontSizesData &&
          medium == other.medium &&
          regular == other.regular);
  @override
  int get hashCode => runtimeType.hashCode ^ medium.hashCode ^ regular.hashCode;
}

class ExampleSizesData {
  const ExampleSizesData({
    required this.avatar,
  });

  const ExampleSizesData.regular() : this.avatar = const Size(24.00, 24.00);

  const ExampleSizesData.big() : this.avatar = const Size(42.00, 42.00);

  final Size avatar;
  factory ExampleSizesData.fromJson(Map<String, Object?> map) =>
      ExampleSizesData(
        avatar: _parseSize(map['avatar']!),
      );

  ExampleSizesData copyWith({
    Size? avatar,
  }) =>
      ExampleSizesData(
        avatar: avatar ?? this.avatar,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleSizesData && avatar == other.avatar);
  @override
  int get hashCode => runtimeType.hashCode ^ avatar.hashCode;
}

class ExampleRadiusesData {
  const ExampleRadiusesData({
    required this.small,
    required this.regular,
    required this.big,
  });

  const ExampleRadiusesData.regular()
      : this.small = const Radius.circular(2.00),
        this.regular = const Radius.circular(4.00),
        this.big = const Radius.circular(12.00);

  final Radius small;
  final Radius regular;
  final Radius big;
  factory ExampleRadiusesData.fromJson(Map<String, Object?> map) =>
      ExampleRadiusesData(
        small: _parseRadius(map['small']!),
        regular: _parseRadius(map['regular']!),
        big: _parseRadius(map['big']!),
      );

  ExampleRadiusesData copyWith({
    Radius? small,
    Radius? regular,
    Radius? big,
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
    required this.small,
    required this.regular,
    required this.big,
  });

  const ExampleBorderRadiusesData.regular()
      : this.small = const BorderRadius.all(Radius.circular(2.00)),
        this.regular = const BorderRadius.all(Radius.circular(4.00)),
        this.big = const BorderRadius.all(Radius.circular(12.00));

  final BorderRadius small;
  final BorderRadius regular;
  final BorderRadius big;
  factory ExampleBorderRadiusesData.fromJson(Map<String, Object?> map) =>
      ExampleBorderRadiusesData(
        small: _parseBorderRadius(map['small']!),
        regular: _parseBorderRadius(map['regular']!),
        big: _parseBorderRadius(map['big']!),
      );

  ExampleBorderRadiusesData copyWith({
    BorderRadius? small,
    BorderRadius? regular,
    BorderRadius? big,
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
    required PathIconData sun,
  }) : _sun = sun;

  const ExampleIconsData._() : _sun = null;

  const factory ExampleIconsData.lines() = _ExampleIconsDataLines;
  const factory ExampleIconsData.filled() = _ExampleIconsDataFilled;
  final PathIconData? _sun;
  PathIconData get sun => _sun!;
  factory ExampleIconsData.fromJson(Map<String, Object?> map) =>
      ExampleIconsData(
        sun: _parsePathIconData(map['sun']!),
      );

  ExampleIconsData copyWith({
    PathIconData? sun,
  }) =>
      ExampleIconsData(
        sun: sun ?? this.sun,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is ExampleIconsData && sun == other.sun);
  @override
  int get hashCode => runtimeType.hashCode ^ sun.hashCode;
}

class _ExampleIconsDataLines extends ExampleIconsData {
  const _ExampleIconsDataLines() : super._();

  @override
  PathIconData get sun => _sunInstance;
  static final _sunInstance = PathIconData.fromSvg(
      '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM9.00001 16C9.00001 12.134 12.134 9 16 9C19.866 9 23 12.134 23 16C23 19.866 19.866 23 16 23C12.134 23 9.00001 19.866 9.00001 16ZM16 11C13.2386 11 11 13.2386 11 16C11 18.7614 13.2386 21 16 21C18.7614 21 21 18.7614 21 16C21 13.2386 18.7614 11 16 11ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/> </svg>');
}

class _ExampleIconsDataFilled extends ExampleIconsData {
  const _ExampleIconsDataFilled() : super._();

  @override
  PathIconData get sun => _sunInstance;
  static final _sunInstance = PathIconData.fromSvg(
      '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM16 9C12.134 9 9.00001 12.134 9.00001 16C9.00001 19.866 12.134 23 16 23C19.866 23 23 19.866 23 16C23 12.134 19.866 9 16 9ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/> </svg>');
}

class ExampleSpacingData {
  const ExampleSpacingData({
    required this.small,
    required this.regular,
    required this.big,
  });

  const ExampleSpacingData.regular()
      : this.small = 4.00,
        this.regular = 20.00,
        this.big = 32.00;

  final double small;
  final double regular;
  final double big;
  factory ExampleSpacingData.fromJson(Map<String, Object?> map) =>
      ExampleSpacingData(
        small: (map['small']! as num).toDouble(),
        regular: (map['regular']! as num).toDouble(),
        big: (map['big']! as num).toDouble(),
      );

  ExampleSpacingData copyWith({
    double? small,
    double? regular,
    double? big,
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
    required this.small,
    required this.regular,
    required this.big,
  });

  const ExampleEdgeInsetsData.regular()
      : this.small = const EdgeInsets.all(4.00),
        this.regular = const EdgeInsets.all(20.00),
        this.big = const EdgeInsets.all(32.00);

  final EdgeInsets small;
  final EdgeInsets regular;
  final EdgeInsets big;
  factory ExampleEdgeInsetsData.fromJson(Map<String, Object?> map) =>
      ExampleEdgeInsetsData(
        small: _parseEdgeInsets(map['small']!),
        regular: _parseEdgeInsets(map['regular']!),
        big: _parseEdgeInsets(map['big']!),
      );

  ExampleEdgeInsetsData copyWith({
    EdgeInsets? small,
    EdgeInsets? regular,
    EdgeInsets? big,
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

class ExampleDurationsData {
  const ExampleDurationsData({
    required this.quick,
    required this.regular,
    required this.slow,
  });

  const ExampleDurationsData.regular()
      : this.quick = const Duration(milliseconds: 100),
        this.regular = const Duration(milliseconds: 200),
        this.slow = const Duration(milliseconds: 1000);

  const ExampleDurationsData.slow()
      : this.quick = const Duration(milliseconds: 300),
        this.regular = const Duration(milliseconds: 500),
        this.slow = const Duration(milliseconds: 4000);

  final Duration quick;
  final Duration regular;
  final Duration slow;
  factory ExampleDurationsData.fromJson(Map<String, Object?> map) =>
      ExampleDurationsData(
        quick: _parseDuration(map['quick']!),
        regular: _parseDuration(map['regular']!),
        slow: _parseDuration(map['slow']!),
      );

  ExampleDurationsData copyWith({
    Duration? quick,
    Duration? regular,
    Duration? slow,
  }) =>
      ExampleDurationsData(
        quick: quick ?? this.quick,
        regular: regular ?? this.regular,
        slow: slow ?? this.slow,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleDurationsData &&
          quick == other.quick &&
          regular == other.regular &&
          slow == other.slow);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ quick.hashCode ^ regular.hashCode ^ slow.hashCode;
}

class ExampleThemeData {
  const ExampleThemeData({
    required this.colors,
    required this.fontStyles,
    required this.fontSizes,
    required this.sizes,
    required this.radiuses,
    required this.borderRadiuses,
    required this.icons,
    required this.spacing,
    required this.edgeInsets,
    required this.durations,
    required this.configuration,
  });

  const ExampleThemeData.fallback()
      : this.colors = const ExampleColorsData.light(),
        this.fontStyles = const ExampleFontStylesData.regular(),
        this.fontSizes = const ExampleFontSizesData.regular(),
        this.sizes = const ExampleSizesData.regular(),
        this.radiuses = const ExampleRadiusesData.regular(),
        this.borderRadiuses = const ExampleBorderRadiusesData.regular(),
        this.icons = const ExampleIconsData.lines(),
        this.spacing = const ExampleSpacingData.regular(),
        this.edgeInsets = const ExampleEdgeInsetsData.regular(),
        this.durations = const ExampleDurationsData.regular(),
        this.configuration = const ConfigurationData.dev();

  final ExampleColorsData colors;
  final ExampleFontStylesData fontStyles;
  final ExampleFontSizesData fontSizes;
  final ExampleSizesData sizes;
  final ExampleRadiusesData radiuses;
  final ExampleBorderRadiusesData borderRadiuses;
  final ExampleIconsData icons;
  final ExampleSpacingData spacing;
  final ExampleEdgeInsetsData edgeInsets;
  final ExampleDurationsData durations;
  final ConfigurationData configuration;
  factory ExampleThemeData.fromJson(Map<String, Object?> map) =>
      ExampleThemeData(
        colors:
            ExampleColorsData.fromJson(map['colors']! as Map<String, Object?>),
        fontStyles: ExampleFontStylesData.fromJson(
            map['fontStyles']! as Map<String, Object?>),
        fontSizes: ExampleFontSizesData.fromJson(
            map['fontSizes']! as Map<String, Object?>),
        sizes: ExampleSizesData.fromJson(map['sizes']! as Map<String, Object?>),
        radiuses: ExampleRadiusesData.fromJson(
            map['radiuses']! as Map<String, Object?>),
        borderRadiuses: ExampleBorderRadiusesData.fromJson(
            map['borderRadiuses']! as Map<String, Object?>),
        icons: ExampleIconsData.fromJson(map['icons']! as Map<String, Object?>),
        spacing: ExampleSpacingData.fromJson(
            map['spacing']! as Map<String, Object?>),
        edgeInsets: ExampleEdgeInsetsData.fromJson(
            map['edgeInsets']! as Map<String, Object?>),
        durations: ExampleDurationsData.fromJson(
            map['durations']! as Map<String, Object?>),
        configuration: ConfigurationData.fromJson(
            map['configuration']! as Map<String, Object?>),
      );

  ExampleThemeData copyWith({
    ExampleColorsData? colors,
    ExampleFontStylesData? fontStyles,
    ExampleFontSizesData? fontSizes,
    ExampleSizesData? sizes,
    ExampleRadiusesData? radiuses,
    ExampleBorderRadiusesData? borderRadiuses,
    ExampleIconsData? icons,
    ExampleSpacingData? spacing,
    ExampleEdgeInsetsData? edgeInsets,
    ExampleDurationsData? durations,
    ConfigurationData? configuration,
  }) =>
      ExampleThemeData(
        colors: colors ?? this.colors,
        fontStyles: fontStyles ?? this.fontStyles,
        fontSizes: fontSizes ?? this.fontSizes,
        sizes: sizes ?? this.sizes,
        radiuses: radiuses ?? this.radiuses,
        borderRadiuses: borderRadiuses ?? this.borderRadiuses,
        icons: icons ?? this.icons,
        spacing: spacing ?? this.spacing,
        edgeInsets: edgeInsets ?? this.edgeInsets,
        durations: durations ?? this.durations,
        configuration: configuration ?? this.configuration,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleThemeData &&
          colors == other.colors &&
          fontStyles == other.fontStyles &&
          fontSizes == other.fontSizes &&
          sizes == other.sizes &&
          radiuses == other.radiuses &&
          borderRadiuses == other.borderRadiuses &&
          icons == other.icons &&
          spacing == other.spacing &&
          edgeInsets == other.edgeInsets &&
          durations == other.durations &&
          configuration == other.configuration);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      colors.hashCode ^
      fontStyles.hashCode ^
      fontSizes.hashCode ^
      sizes.hashCode ^
      radiuses.hashCode ^
      borderRadiuses.hashCode ^
      icons.hashCode ^
      spacing.hashCode ^
      edgeInsets.hashCode ^
      durations.hashCode ^
      configuration.hashCode;
}

class ConfigurationMapsData {
  const ConfigurationMapsData({
    required this.server,
  });

  final String server;
  factory ConfigurationMapsData.fromJson(Map<String, Object?> map) =>
      ConfigurationMapsData(
        server: map['server']! as String,
      );

  ConfigurationMapsData copyWith({
    String? server,
  }) =>
      ConfigurationMapsData(
        server: server ?? this.server,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigurationMapsData && server == other.server);
  @override
  int get hashCode => runtimeType.hashCode ^ server.hashCode;
}

class ConfigurationData {
  const ConfigurationData({
    required this.host,
    required this.maps,
  });

  const ConfigurationData.dev()
      : this.host = 'https://dev.example.com/api',
        this.maps = const ConfigurationMapsData(
          server: 'https://maps.com/tiles',
        );

  const ConfigurationData.prerelease()
      : this.host = 'https://pre.example.com/api',
        this.maps = const ConfigurationMapsData(
          server: 'https://maps.com/tiles',
        );

  const ConfigurationData.release()
      : this.host = 'https://example.com/api',
        this.maps = const ConfigurationMapsData(
          server: 'https://maps.com/tiles',
        );

  final String host;
  final ConfigurationMapsData maps;
  factory ConfigurationData.fromJson(Map<String, Object?> map) =>
      ConfigurationData(
        host: map['host']! as String,
        maps: ConfigurationMapsData.fromJson(
            map['maps']! as Map<String, Object?>),
      );

  ConfigurationData copyWith({
    String? host,
    ConfigurationMapsData? maps,
  }) =>
      ConfigurationData(
        host: host ?? this.host,
        maps: maps ?? this.maps,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigurationData && host == other.host && maps == other.maps);
  @override
  int get hashCode => runtimeType.hashCode ^ host.hashCode ^ maps.hashCode;
}

final localizedLabels = <Locale, ExampleLocalizationData>{
  Locale.fromSubtags(languageCode: 'fr'): const ExampleLocalizationData(
    multiline: 'C\'est\nune\nexemple multiligne.',
    dates: const ExampleLocalizationDataDates(
      weekday: const ExampleLocalizationDataDatesWeekday(
        monday: 'lundi',
        tuesday: 'mardi',
        wednesday: 'mercredi',
      ),
    ),
    templated: const ExampleLocalizationDataTemplated(
      hello: 'Bonjour {{first_name}}!',
      contactMale: 'M. {{last_name}}',
      contactFemale: 'Mme. {{last_name}}',
      numbers: const ExampleLocalizationDataTemplatedNumbers(
        count: 'Il y a {{count:int}} éléments.',
        simple: 'Le prix est de {{price:double}}€',
        formatted: 'Le prix est de {{price:double[compactCurrency]}}',
      ),
      date: const ExampleLocalizationDataTemplatedDate(
        simple: 'Aujourd\'hui : {{date:DateTime}}',
        pattern: 'Aujourd\'hui : {{date:DateTime[EEE, M/d/y]}}',
      ),
    ),
    plurals: const ExampleLocalizationDataPlurals(
      manZero: 'hommes',
      manOne: 'homme',
      manMultiple: 'hommes',
    ),
  ),
  Locale.fromSubtags(languageCode: 'en'): const ExampleLocalizationData(
    multiline: 'This is\na\nmultiline example.',
    dates: const ExampleLocalizationDataDates(
      weekday: const ExampleLocalizationDataDatesWeekday(
        monday: 'monday',
        tuesday: 'tuesday',
        wednesday: 'wednesday',
      ),
    ),
    templated: const ExampleLocalizationDataTemplated(
      hello: 'Hello {{first_name}}!',
      contactMale: 'Mr {{last_name}}',
      contactFemale: 'Mrs {{last_name}}',
      numbers: const ExampleLocalizationDataTemplatedNumbers(
        count: 'There are {{count:int}} items.',
        simple: 'The price is {{price:double}}\$',
        formatted: 'The price is {{price:double[compactCurrency]}}',
      ),
      date: const ExampleLocalizationDataTemplatedDate(
        simple: 'Today : {{date:DateTime}}',
        pattern: 'Today : {{date:DateTime[EEE, M/d/y]}}',
      ),
    ),
    plurals: const ExampleLocalizationDataPlurals(
      manZero: 'man',
      manOne: 'man',
      manMultiple: 'men',
    ),
  ),
};
enum Gender {
  male,
  female,
}
enum Plural {
  zero,
  one,
  multiple,
}

class ExampleLocalizationData {
  const ExampleLocalizationData({
    required this.dates,
    required this.templated,
    required this.plurals,
    required this.multiline,
  });

  final ExampleLocalizationDataDates dates;
  final ExampleLocalizationDataTemplated templated;
  final ExampleLocalizationDataPlurals plurals;
  final String multiline;
  factory ExampleLocalizationData.fromJson(Map<String, Object?> map) =>
      ExampleLocalizationData(
        dates: ExampleLocalizationDataDates.fromJson(
            map['dates']! as Map<String, Object?>),
        templated: ExampleLocalizationDataTemplated.fromJson(
            map['templated']! as Map<String, Object?>),
        plurals: ExampleLocalizationDataPlurals.fromJson(
            map['plurals']! as Map<String, Object?>),
        multiline: map['multiline']! as String,
      );

  ExampleLocalizationData copyWith({
    ExampleLocalizationDataDates? dates,
    ExampleLocalizationDataTemplated? templated,
    ExampleLocalizationDataPlurals? plurals,
    String? multiline,
  }) =>
      ExampleLocalizationData(
        dates: dates ?? this.dates,
        templated: templated ?? this.templated,
        plurals: plurals ?? this.plurals,
        multiline: multiline ?? this.multiline,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationData &&
          dates == other.dates &&
          templated == other.templated &&
          plurals == other.plurals &&
          multiline == other.multiline);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      dates.hashCode ^
      templated.hashCode ^
      plurals.hashCode ^
      multiline.hashCode;
}

class ExampleLocalizationDataDates {
  const ExampleLocalizationDataDates({
    required this.weekday,
  });

  final ExampleLocalizationDataDatesWeekday weekday;
  factory ExampleLocalizationDataDates.fromJson(Map<String, Object?> map) =>
      ExampleLocalizationDataDates(
        weekday: ExampleLocalizationDataDatesWeekday.fromJson(
            map['weekday']! as Map<String, Object?>),
      );

  ExampleLocalizationDataDates copyWith({
    ExampleLocalizationDataDatesWeekday? weekday,
  }) =>
      ExampleLocalizationDataDates(
        weekday: weekday ?? this.weekday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataDates && weekday == other.weekday);
  @override
  int get hashCode => runtimeType.hashCode ^ weekday.hashCode;
}

class ExampleLocalizationDataDatesWeekday {
  const ExampleLocalizationDataDatesWeekday({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
  });

  final String monday;
  final String tuesday;
  final String wednesday;
  factory ExampleLocalizationDataDatesWeekday.fromJson(
          Map<String, Object?> map) =>
      ExampleLocalizationDataDatesWeekday(
        monday: map['monday']! as String,
        tuesday: map['tuesday']! as String,
        wednesday: map['wednesday']! as String,
      );

  ExampleLocalizationDataDatesWeekday copyWith({
    String? monday,
    String? tuesday,
    String? wednesday,
  }) =>
      ExampleLocalizationDataDatesWeekday(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataDatesWeekday &&
          monday == other.monday &&
          tuesday == other.tuesday &&
          wednesday == other.wednesday);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      monday.hashCode ^
      tuesday.hashCode ^
      wednesday.hashCode;
}

class ExampleLocalizationDataTemplated {
  const ExampleLocalizationDataTemplated({
    required this.numbers,
    required this.date,
    required String hello,
    required String contactMale,
    required String contactFemale,
  })   : _hello = hello,
        _contactMale = contactMale,
        _contactFemale = contactFemale;

  final ExampleLocalizationDataTemplatedNumbers numbers;
  final ExampleLocalizationDataTemplatedDate date;
  final String _hello;
  final String _contactMale;
  final String _contactFemale;

  String hello({
    required String firstName,
    required Locale locale,
  }) {
    return _hello.insertTemplateValues({'first_name': firstName}, locale);
  }

  String contact({
    required Gender gender,
    required String lastName,
    required Locale locale,
  }) {
    if (gender == Gender.male) {
      return _contactMale.insertTemplateValues({'last_name': lastName}, locale);
    }
    if (gender == Gender.female) {
      return _contactFemale
          .insertTemplateValues({'last_name': lastName}, locale);
    }
    throw Exception();
  }

  factory ExampleLocalizationDataTemplated.fromJson(Map<String, Object?> map) =>
      ExampleLocalizationDataTemplated(
        numbers: ExampleLocalizationDataTemplatedNumbers.fromJson(
            map['numbers']! as Map<String, Object?>),
        date: ExampleLocalizationDataTemplatedDate.fromJson(
            map['date']! as Map<String, Object?>),
        hello: map['hello']! as String,
        contactMale: map['contactMale']! as String,
        contactFemale: map['contactFemale']! as String,
      );

  ExampleLocalizationDataTemplated copyWith({
    ExampleLocalizationDataTemplatedNumbers? numbers,
    ExampleLocalizationDataTemplatedDate? date,
    String? hello,
    String? contactMale,
    String? contactFemale,
  }) =>
      ExampleLocalizationDataTemplated(
        numbers: numbers ?? this.numbers,
        date: date ?? this.date,
        hello: hello ?? _hello,
        contactMale: contactMale ?? _contactMale,
        contactFemale: contactFemale ?? _contactFemale,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataTemplated &&
          numbers == other.numbers &&
          date == other.date &&
          _hello == other._hello &&
          _contactMale == other._contactMale &&
          _contactFemale == other._contactFemale);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      numbers.hashCode ^
      date.hashCode ^
      _hello.hashCode ^
      _contactMale.hashCode ^
      _contactFemale.hashCode;
}

class ExampleLocalizationDataTemplatedNumbers {
  const ExampleLocalizationDataTemplatedNumbers({
    required String count,
    required String simple,
    required String formatted,
  })   : _count = count,
        _simple = simple,
        _formatted = formatted;

  final String _count;
  final String _simple;
  final String _formatted;

  String count({
    required int count,
    required Locale locale,
  }) {
    return _count.insertTemplateValues({'count': count}, locale);
  }

  String simple({
    required double price,
    required Locale locale,
  }) {
    return _simple.insertTemplateValues({'price': price}, locale);
  }

  String formatted({
    required double price,
    required Locale locale,
  }) {
    return _formatted.insertTemplateValues({'price': price}, locale);
  }

  factory ExampleLocalizationDataTemplatedNumbers.fromJson(
          Map<String, Object?> map) =>
      ExampleLocalizationDataTemplatedNumbers(
        count: map['count']! as String,
        simple: map['simple']! as String,
        formatted: map['formatted']! as String,
      );

  ExampleLocalizationDataTemplatedNumbers copyWith({
    String? count,
    String? simple,
    String? formatted,
  }) =>
      ExampleLocalizationDataTemplatedNumbers(
        count: count ?? _count,
        simple: simple ?? _simple,
        formatted: formatted ?? _formatted,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataTemplatedNumbers &&
          _count == other._count &&
          _simple == other._simple &&
          _formatted == other._formatted);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _count.hashCode ^
      _simple.hashCode ^
      _formatted.hashCode;
}

class ExampleLocalizationDataTemplatedDate {
  const ExampleLocalizationDataTemplatedDate({
    required String simple,
    required String pattern,
  })   : _simple = simple,
        _pattern = pattern;

  final String _simple;
  final String _pattern;

  String simple({
    required DateTime date,
    required Locale locale,
  }) {
    return _simple.insertTemplateValues({'date': date}, locale);
  }

  String pattern({
    required DateTime date,
    required Locale locale,
  }) {
    return _pattern.insertTemplateValues({'date': date}, locale);
  }

  factory ExampleLocalizationDataTemplatedDate.fromJson(
          Map<String, Object?> map) =>
      ExampleLocalizationDataTemplatedDate(
        simple: map['simple']! as String,
        pattern: map['pattern']! as String,
      );

  ExampleLocalizationDataTemplatedDate copyWith({
    String? simple,
    String? pattern,
  }) =>
      ExampleLocalizationDataTemplatedDate(
        simple: simple ?? _simple,
        pattern: pattern ?? _pattern,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataTemplatedDate &&
          _simple == other._simple &&
          _pattern == other._pattern);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ _simple.hashCode ^ _pattern.hashCode;
}

class ExampleLocalizationDataPlurals {
  const ExampleLocalizationDataPlurals({
    required String manZero,
    required String manOne,
    required String manMultiple,
  })   : _manZero = manZero,
        _manOne = manOne,
        _manMultiple = manMultiple;

  final String _manZero;
  final String _manOne;
  final String _manMultiple;

  String man({
    required Plural plural,
  }) {
    if (plural == Plural.zero) {
      return _manZero;
    }
    if (plural == Plural.one) {
      return _manOne;
    }
    if (plural == Plural.multiple) {
      return _manMultiple;
    }
    throw Exception();
  }

  factory ExampleLocalizationDataPlurals.fromJson(Map<String, Object?> map) =>
      ExampleLocalizationDataPlurals(
        manZero: map['manZero']! as String,
        manOne: map['manOne']! as String,
        manMultiple: map['manMultiple']! as String,
      );

  ExampleLocalizationDataPlurals copyWith({
    String? manZero,
    String? manOne,
    String? manMultiple,
  }) =>
      ExampleLocalizationDataPlurals(
        manZero: manZero ?? _manZero,
        manOne: manOne ?? _manOne,
        manMultiple: manMultiple ?? _manMultiple,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleLocalizationDataPlurals &&
          _manZero == other._manZero &&
          _manOne == other._manOne &&
          _manMultiple == other._manMultiple);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      _manZero.hashCode ^
      _manOne.hashCode ^
      _manMultiple.hashCode;
}

EdgeInsets _parseEdgeInsets(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return EdgeInsets.all(value.toDouble());
}

Color _parseColor(Object value) {
  if (!(value is String)) throw Exception();
  if (value.startsWith('#')) {
    value = value.substring(1);
  }
  return Color(int.parse(_uniformizeHexValue(value), radix: 16));
}

String _uniformizeHexValue(String? hex) {
  hex ??= '0';
  hex = hex.isEmpty ? '0' : hex;
  if (hex.length == 1) {
    return 'FF$hex$hex$hex$hex$hex$hex';
  } else if (hex.length == 2) {
    return 'FF$hex$hex$hex';
  } else if (hex.length == 3) {
    final r = hex[0];
    final g = hex[1];
    final b = hex[2];
    return 'FF$r$r$g$g$b$b';
  } else if (hex.length == 4) {
    final a = hex[0];
    final r = hex[1];
    final g = hex[2];
    final b = hex[3];
    return '$a$a$r$r$g$g$b$b';
  } else if (hex.length == 5) {
    final a1 = hex[0];
    final a2 = hex[1];
    final r = hex[2];
    final g = hex[3];
    final b = hex[4];
    return '$a1$a2$r$r$g$g$b$b';
  } else if (hex.length == 6) {
    return 'FF$hex';
  } else if (hex.length == 7) {
    final a = hex[0];
    final rgb = hex.substring(1);
    return '$a$a$rgb';
  }
  return hex.substring(0, 8);
}

Radius _parseRadius(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return Radius.circular(value.toDouble());
}

BorderRadius _parseBorderRadius(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (!(value is num)) throw Exception();
  return BorderRadius.circular(value.toDouble());
}

Size _parseSize(Object value) {
  if (value is String) {
    value = int.parse(value);
  }
  if (value is double) {
    return Size(value, value);
  }
  if (value is Map<String, Object?>) {
    final width = value['width'] as num;
    final height = value['height'] as num;
    return Size(
      width.toDouble(),
      height.toDouble(),
    );
  }

  throw Exception();
}

Duration _parseDuration(Object value) {
  if (value is String) {
    value = int.parse(value);
  }

  if (value is num) {
    return Duration(milliseconds: value.toInt());
  }

  if (value is Map<String, Object?>) {
    final milliseconds = value['milliseconds'] ?? 0;
    final seconds = value['seconds'] ?? 0;
    final minutes = value['minutes'] ?? 0;
    final hours = value['hours'] ?? 0;
    return Duration(
      milliseconds: (milliseconds as num).toInt(),
      seconds: (seconds as num).toInt(),
      minutes: (minutes as num).toInt(),
      hours: (hours as num).toInt(),
    );
  }

  throw Exception();
}

TextStyle _parseTextStyle(Object value) {
  if (!(value is Map<String, Object?>)) throw Exception();
  final source = value['source'] as String?;
  final fontFamily = value['fontFamily'] as String?;
  final TextDecoration decoration = () {
    final v = value['decoration'] as String?;
    switch (v) {
      case 'overline':
        return TextDecoration.overline;
      case 'underline':
        return TextDecoration.underline;
      default:
        return TextDecoration.none;
    }
  }();
  final FontWeight? fontWeight = () {
    final weight = (value['fontWeight'] as num?)?.toInt();
    if (weight == null) {
      return null;
    }
    return FontWeight.values[(weight ~/ 100) + 1];
  }();
  final fontSize = (value['fontSize'] as num?)?.toDouble();
  if (source != null && source.toLowerCase() == 'googlefonts') {
    return GoogleFonts.getFont(
      source,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
    );
  }
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    decoration: decoration,
  );
}

PathIconData _parsePathIconData(Object value) {
  if (!(value is String)) throw Exception();
  if (value.contains('<svg')) return PathIconData.fromSvg(value);
  return PathIconData.fromData(value);
}
