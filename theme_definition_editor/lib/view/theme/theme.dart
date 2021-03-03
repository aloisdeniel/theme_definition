import 'package:flutter/widgets.dart';
import 'package:path_icon/path_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class YamlTheme extends InheritedWidget {
  const YamlTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final YamlThemeData data;

  static YamlThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<YamlTheme>();
    return widget?.data ?? YamlThemeData.fallback();
  }

  @override
  bool updateShouldNotify(covariant YamlTheme oldWidget) {
    return this.data != oldWidget.data;
  }
}

class YamlColorsData {
  const YamlColorsData({
    required this.accent1,
    required this.accent2,
    required this.background1,
    required this.background2,
    required this.foreground1,
    required this.foreground2,
    required this.foreground3,
    required this.error1,
    required this.error2,
  });

  const YamlColorsData.dark()
      : this.accent1 = const Color(0xFF885FFD),
        this.accent2 = const Color(0xFF4DC79B),
        this.background1 = const Color(0xFF202538),
        this.background2 = const Color(0xFF131727),
        this.foreground1 = const Color(0xFFF4F0FF),
        this.foreground2 = const Color(0xFF8EA6B8),
        this.foreground3 = const Color(0xFF718797),
        this.error1 = const Color(0xFFC74D54),
        this.error2 = const Color(0xFF672E31);

  const YamlColorsData.semiDark()
      : this.accent1 = const Color(0xFF926CFF),
        this.accent2 = const Color(0xFF53F9BD),
        this.background1 = const Color(0xFF282E47),
        this.background2 = const Color(0xFF1C2239),
        this.foreground1 = const Color(0xFFF8F5FF),
        this.foreground2 = const Color(0xFFA8C5D9),
        this.foreground3 = const Color(0xFF97B0C1),
        this.error1 = const Color(0xFFC74D54),
        this.error2 = const Color(0xFF672E31);

  const YamlColorsData.light()
      : this.accent1 = const Color(0xFF9672FF),
        this.accent2 = const Color(0xFF5BDFB0),
        this.background1 = const Color(0xFFE6EBFD),
        this.background2 = const Color(0xFFD0D8EE),
        this.foreground1 = const Color(0xFF252B43),
        this.foreground2 = const Color(0xFF577184),
        this.foreground3 = const Color(0xFF718797),
        this.error1 = const Color(0xFFC74D54),
        this.error2 = const Color(0xFF672E31);

  const YamlColorsData.extraLight()
      : this.accent1 = const Color(0xFF8666E1),
        this.accent2 = const Color(0xFF4ED4A4),
        this.background1 = const Color(0xFFF4F7FF),
        this.background2 = const Color(0xFFE9EEFC),
        this.foreground1 = const Color(0xFF131727),
        this.foreground2 = const Color(0xFF6A7C89),
        this.foreground3 = const Color(0xFF7F8F9B),
        this.error1 = const Color(0xFFE26169),
        this.error2 = const Color(0xFF763B3F);

  final Color accent1;
  final Color accent2;
  final Color background1;
  final Color background2;
  final Color foreground1;
  final Color foreground2;
  final Color foreground3;
  final Color error1;
  final Color error2;

  YamlColorsData copyWith({
    Color? accent1,
    Color? accent2,
    Color? background1,
    Color? background2,
    Color? foreground1,
    Color? foreground2,
    Color? foreground3,
    Color? error1,
    Color? error2,
  }) =>
      YamlColorsData(
        accent1: accent1 ?? this.accent1,
        accent2: accent2 ?? this.accent2,
        background1: background1 ?? this.background1,
        background2: background2 ?? this.background2,
        foreground1: foreground1 ?? this.foreground1,
        foreground2: foreground2 ?? this.foreground2,
        foreground3: foreground3 ?? this.foreground3,
        error1: error1 ?? this.error1,
        error2: error2 ?? this.error2,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlColorsData &&
          accent1 == other.accent1 &&
          accent2 == other.accent2 &&
          background1 == other.background1 &&
          background2 == other.background2 &&
          foreground1 == other.foreground1 &&
          foreground2 == other.foreground2 &&
          foreground3 == other.foreground3 &&
          error1 == other.error1 &&
          error2 == other.error2);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      accent1.hashCode ^
      accent2.hashCode ^
      background1.hashCode ^
      background2.hashCode ^
      foreground1.hashCode ^
      foreground2.hashCode ^
      foreground3.hashCode ^
      error1.hashCode ^
      error2.hashCode;
}

class YamlFontStylesData {
  const YamlFontStylesData({
    required TextStyle title,
    required TextStyle content,
    required TextStyle code,
  })   : _title = title,
        _content = content,
        _code = code;

  const YamlFontStylesData._()
      : _title = null,
        _content = null,
        _code = null;

  const factory YamlFontStylesData.regular() = _YamlFontStylesDataRegular;
  final TextStyle? _title;
  TextStyle get title => _title!;
  final TextStyle? _content;
  TextStyle get content => _content!;
  final TextStyle? _code;
  TextStyle get code => _code!;

  YamlFontStylesData copyWith({
    TextStyle? title,
    TextStyle? content,
    TextStyle? code,
  }) =>
      YamlFontStylesData(
        title: title ?? this.title,
        content: content ?? this.content,
        code: code ?? this.code,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlFontStylesData &&
          title == other.title &&
          content == other.content &&
          code == other.code);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ title.hashCode ^ content.hashCode ^ code.hashCode;
}

class _YamlFontStylesDataRegular extends YamlFontStylesData {
  const _YamlFontStylesDataRegular() : super._();

  @override
  TextStyle get title => _titleInstance;
  static final _titleInstance = GoogleFonts.getFont(
    'Montserrat',
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );
  @override
  TextStyle get content => _contentInstance;
  static final _contentInstance = GoogleFonts.getFont(
    'Roboto',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
  @override
  TextStyle get code => _codeInstance;
  static final _codeInstance = GoogleFonts.getFont(
    'Fira Code',
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
}

class YamlFontSizesData {
  const YamlFontSizesData({
    required this.small,
    required this.semiSmall,
    required this.regular,
    required this.semiBig,
    required this.big,
  });

  const YamlFontSizesData.regular()
      : this.small = 9.00,
        this.semiSmall = 11.00,
        this.regular = 12.00,
        this.semiBig = 16.00,
        this.big = 24.00;

  final double small;
  final double semiSmall;
  final double regular;
  final double semiBig;
  final double big;

  YamlFontSizesData copyWith({
    double? small,
    double? semiSmall,
    double? regular,
    double? semiBig,
    double? big,
  }) =>
      YamlFontSizesData(
        small: small ?? this.small,
        semiSmall: semiSmall ?? this.semiSmall,
        regular: regular ?? this.regular,
        semiBig: semiBig ?? this.semiBig,
        big: big ?? this.big,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlFontSizesData &&
          small == other.small &&
          semiSmall == other.semiSmall &&
          regular == other.regular &&
          semiBig == other.semiBig &&
          big == other.big);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      small.hashCode ^
      semiSmall.hashCode ^
      regular.hashCode ^
      semiBig.hashCode ^
      big.hashCode;
}

class YamlRadiusesData {
  const YamlRadiusesData({
    required this.small,
    required this.regular,
    required this.big,
    required this.extraBig,
  });

  const YamlRadiusesData.regular()
      : this.small = const Radius.circular(2.00),
        this.regular = const Radius.circular(4.00),
        this.big = const Radius.circular(12.00),
        this.extraBig = const Radius.circular(32.00);

  final Radius small;
  final Radius regular;
  final Radius big;
  final Radius extraBig;

  YamlRadiusesData copyWith({
    Radius? small,
    Radius? regular,
    Radius? big,
    Radius? extraBig,
  }) =>
      YamlRadiusesData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
        extraBig: extraBig ?? this.extraBig,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlRadiusesData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big &&
          extraBig == other.extraBig);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      small.hashCode ^
      regular.hashCode ^
      big.hashCode ^
      extraBig.hashCode;
}

class YamlBorderRadiusesData {
  const YamlBorderRadiusesData({
    required this.small,
    required this.regular,
    required this.big,
    required this.extraBig,
  });

  const YamlBorderRadiusesData.regular()
      : this.small = const BorderRadius.all(Radius.circular(2.00)),
        this.regular = const BorderRadius.all(Radius.circular(4.00)),
        this.big = const BorderRadius.all(Radius.circular(12.00)),
        this.extraBig = const BorderRadius.all(Radius.circular(32.00));

  final BorderRadius small;
  final BorderRadius regular;
  final BorderRadius big;
  final BorderRadius extraBig;

  YamlBorderRadiusesData copyWith({
    BorderRadius? small,
    BorderRadius? regular,
    BorderRadius? big,
    BorderRadius? extraBig,
  }) =>
      YamlBorderRadiusesData(
        small: small ?? this.small,
        regular: regular ?? this.regular,
        big: big ?? this.big,
        extraBig: extraBig ?? this.extraBig,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlBorderRadiusesData &&
          small == other.small &&
          regular == other.regular &&
          big == other.big &&
          extraBig == other.extraBig);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      small.hashCode ^
      regular.hashCode ^
      big.hashCode ^
      extraBig.hashCode;
}

class YamlIconsData {
  const YamlIconsData({
    required PathIconData palette,
    required PathIconData exportCode,
    required PathIconData checkmark,
    required PathIconData clipboard,
    required PathIconData textEdit,
    required PathIconData sun,
    required PathIconData moon,
    required PathIconData cornerLine,
    required PathIconData pointLine,
  })   : _palette = palette,
        _exportCode = exportCode,
        _checkmark = checkmark,
        _clipboard = clipboard,
        _textEdit = textEdit,
        _sun = sun,
        _moon = moon,
        _cornerLine = cornerLine,
        _pointLine = pointLine;

  const YamlIconsData._()
      : _palette = null,
        _exportCode = null,
        _checkmark = null,
        _clipboard = null,
        _textEdit = null,
        _sun = null,
        _moon = null,
        _cornerLine = null,
        _pointLine = null;

  const factory YamlIconsData.lines() = _YamlIconsDataLines;
  const factory YamlIconsData.filled() = _YamlIconsDataFilled;
  final PathIconData? _palette;
  PathIconData get palette => _palette!;
  final PathIconData? _exportCode;
  PathIconData get exportCode => _exportCode!;
  final PathIconData? _checkmark;
  PathIconData get checkmark => _checkmark!;
  final PathIconData? _clipboard;
  PathIconData get clipboard => _clipboard!;
  final PathIconData? _textEdit;
  PathIconData get textEdit => _textEdit!;
  final PathIconData? _sun;
  PathIconData get sun => _sun!;
  final PathIconData? _moon;
  PathIconData get moon => _moon!;
  final PathIconData? _cornerLine;
  PathIconData get cornerLine => _cornerLine!;
  final PathIconData? _pointLine;
  PathIconData get pointLine => _pointLine!;

  YamlIconsData copyWith({
    PathIconData? palette,
    PathIconData? exportCode,
    PathIconData? checkmark,
    PathIconData? clipboard,
    PathIconData? textEdit,
    PathIconData? sun,
    PathIconData? moon,
    PathIconData? cornerLine,
    PathIconData? pointLine,
  }) =>
      YamlIconsData(
        palette: palette ?? this.palette,
        exportCode: exportCode ?? this.exportCode,
        checkmark: checkmark ?? this.checkmark,
        clipboard: clipboard ?? this.clipboard,
        textEdit: textEdit ?? this.textEdit,
        sun: sun ?? this.sun,
        moon: moon ?? this.moon,
        cornerLine: cornerLine ?? this.cornerLine,
        pointLine: pointLine ?? this.pointLine,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlIconsData &&
          palette == other.palette &&
          exportCode == other.exportCode &&
          checkmark == other.checkmark &&
          clipboard == other.clipboard &&
          textEdit == other.textEdit &&
          sun == other.sun &&
          moon == other.moon &&
          cornerLine == other.cornerLine &&
          pointLine == other.pointLine);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      palette.hashCode ^
      exportCode.hashCode ^
      checkmark.hashCode ^
      clipboard.hashCode ^
      textEdit.hashCode ^
      sun.hashCode ^
      moon.hashCode ^
      cornerLine.hashCode ^
      pointLine.hashCode;
}

class _YamlIconsDataLines extends YamlIconsData {
  const _YamlIconsDataLines() : super._();

  @override
  PathIconData get palette => _paletteInstance;
  static final _paletteInstance = PathIconData.fromSvg(
      '<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M1.83885 3.85764C4.77986 -0.0579715 10.8685 -1.19736 15.2028 1.49752C19.4826 4.15853 21.0566 9.2746 19.3037 14.0749C17.6485 18.6075 13.2873 20.4033 10.144 18.1233C8.9666 17.2692 8.5101 16.1985 8.2895 14.4595L8.1841 13.4715L8.1387 13.0741C8.016 12.14 7.82762 11.7216 7.43435 11.5024C6.89876 11.2038 6.54213 11.1969 5.83887 11.4694L5.48775 11.615L5.30902 11.693C4.29524 12.1332 3.62085 12.2879 2.76786 12.1092L2.56761 12.062L2.40407 12.0154C-0.38489 11.1512 -0.79798 7.36827 1.83885 3.85764ZM2.82307 10.5741L2.94598 10.6105L3.07993 10.6414C3.519 10.7283 3.89425 10.6558 4.51695 10.3995L5.11912 10.1423C6.32126 9.6494 7.10436 9.6012 8.1646 10.1921C9.0822 10.7036 9.4399 11.4897 9.6223 12.8518L9.6755 13.3109L9.7297 13.8427L9.7768 14.2651C9.9489 15.6263 10.2617 16.3556 11.0248 16.9091C13.3001 18.5595 16.5592 17.2175 17.8947 13.5604C19.411 9.4082 18.0688 5.04581 14.4107 2.77137C10.7365 0.486899 5.5123 1.46453 3.03822 4.75848C0.96343 7.52082 1.21791 10.038 2.82307 10.5741ZM14.0476 8.5797C13.8689 7.91288 14.2646 7.22746 14.9314 7.04878C15.5983 6.87011 16.2837 7.26583 16.4624 7.93267C16.6411 8.5995 16.2453 9.2849 15.5785 9.4636C14.9117 9.6423 14.2262 9.2465 14.0476 8.5797ZM14.5421 12.0684C14.3635 11.4015 14.7592 10.7161 15.426 10.5374C16.0929 10.3588 16.7783 10.7545 16.957 11.4213C17.1356 12.0882 16.7399 12.7736 16.0731 12.9523C15.4062 13.1309 14.7208 12.7352 14.5421 12.0684ZM12.0691 5.57703C11.8904 4.9102 12.2861 4.22478 12.9529 4.0461C13.6198 3.86742 14.3052 4.26315 14.4839 4.92998C14.6625 5.59681 14.2668 6.28224 13.6 6.46091C12.9331 6.63959 12.2477 6.24386 12.0691 5.57703ZM12.0406 14.5754C11.8619 13.9086 12.2576 13.2232 12.9245 13.0445C13.5913 12.8658 14.2767 13.2615 14.4554 13.9284C14.6341 14.5952 14.2383 15.2806 13.5715 15.4593C12.9047 15.638 12.2192 15.2422 12.0406 14.5754ZM8.5436 4.60544C8.365 3.9386 8.7607 3.25318 9.4275 3.07451C10.0944 2.89583 10.7798 3.29156 10.9585 3.95839C11.1371 4.62522 10.7414 5.31064 10.0746 5.48932C9.4077 5.668 8.7223 5.27227 8.5436 4.60544Z" fill="#212121"/> </svg>');
  @override
  PathIconData get exportCode => _exportCodeInstance;
  static final _exportCodeInstance = PathIconData.fromSvg(
      '<svg width="19" height="21" viewBox="0 0 19 21" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M13.5 10C16.5376 10 19 12.4624 19 15.5C19 18.5376 16.5376 21 13.5 21C10.4624 21 8 18.5376 8 15.5C8 12.4624 10.4624 10 13.5 10ZM1.5028 2.62704L1.5 4.75V15.2542C1.5 17.0491 2.95507 18.5042 4.75 18.5042L7.7348 18.5051C8.0227 19.0561 8.3872 19.5608 8.8142 20.0048L4.75 20.0042C2.12665 20.0042 0 17.8776 0 15.2542V4.75C0 3.76929 0.62745 2.93512 1.5028 2.62704ZM14.2843 12.5886C14.1138 12.4705 13.8862 12.4705 13.7157 12.5886L13.6464 12.6464L13.5886 12.7157C13.4705 12.8862 13.4705 13.1138 13.5886 13.2843L13.6464 13.3536L15.2917 14.999L10.4937 15L10.4038 15.0081C10.1997 15.0451 10.0388 15.206 10.0018 15.4101L9.9937 15.5L10.0018 15.5899C10.0388 15.794 10.1997 15.9549 10.4038 15.9919L10.4937 16L15.2937 15.999L13.6464 17.6464L13.5886 17.7157C13.4536 17.9106 13.4729 18.18 13.6464 18.3536C13.82 18.5271 14.0894 18.5464 14.2843 18.4114L14.3536 18.3536L16.8832 15.8212L16.9202 15.7711L16.9622 15.691L16.9882 15.6083L16.9981 15.5444V15.4557L16.9883 15.392L16.9767 15.3488L16.9445 15.2708L16.9205 15.2293L16.8832 15.1788L14.3536 12.6464L14.2843 12.5886ZM13.75 0C14.9926 0 16 1.00736 16 2.25L16.0006 9.4984C15.5265 9.3007 15.024 9.1574 14.5009 9.0766L14.5 2.25C14.5 1.83579 14.1642 1.5 13.75 1.5H4.75C4.33579 1.5 4 1.83579 4 2.25V15.25C4 15.6642 4.33579 16 4.75 16L7.019 16.0003C7.0585 16.5198 7.1591 17.0222 7.3136 17.5004L4.75 17.5C3.50736 17.5 2.5 16.4926 2.5 15.25V2.25C2.5 1.00736 3.50736 0 4.75 0H13.75Z" fill="#212121"/> </svg>');
  @override
  PathIconData get checkmark => _checkmarkInstance;
  static final _checkmarkInstance = PathIconData.fromSvg(
      '<svg width="18" height="13" viewBox="0 0 18 13" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M5.5 10.5858L1.70711 6.7929C1.31658 6.4024 0.68342 6.4024 0.29289 6.7929C-0.09763 7.1834 -0.09763 7.8166 0.29289 8.2071L4.79289 12.7071C5.18342 13.0976 5.81658 13.0976 6.20711 12.7071L17.2071 1.70711C17.5976 1.31658 17.5976 0.68342 17.2071 0.29289C16.8166 -0.09763 16.1834 -0.09763 15.7929 0.29289L5.5 10.5858Z" fill="#212121"/> </svg>');
  @override
  PathIconData get clipboard => _clipboardInstance;
  static final _clipboardInstance = PathIconData.fromSvg(
      '<svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M9.75 0C10.9409 0 11.9156 0.92516 11.9948 2.09595L12 2.25C12 2.16531 11.9953 2.0817 11.9862 1.99944L13.75 2C14.9926 2 16 3.00736 16 4.25V17.75C16 18.9926 14.9926 20 13.75 20H2.25C1.00736 20 0 18.9926 0 17.75V4.25C0 3.00736 1.00736 2 2.25 2L4.01379 1.99944C4.00733 2.05774 4.0031 2.11671 4.00119 2.17626L4 2.25C4 1.00736 5.00736 0 6.25 0H9.75ZM9.75 4.5H6.25C5.45595 4.5 4.75797 4.08867 4.35751 3.46746L4.37902 3.5002L2.25 3.5C1.83579 3.5 1.5 3.83579 1.5 4.25V17.75C1.5 18.1642 1.83579 18.5 2.25 18.5H13.75C14.1642 18.5 14.5 18.1642 14.5 17.75V4.25C14.5 3.83579 14.1642 3.5 13.75 3.5L11.621 3.5002L11.6425 3.46746C11.242 4.08867 10.5441 4.5 9.75 4.5ZM9.75 1.5H6.25C5.83579 1.5 5.5 1.83579 5.5 2.25C5.5 2.66421 5.83579 3 6.25 3H9.75C10.1642 3 10.5 2.66421 10.5 2.25C10.5 1.83579 10.1642 1.5 9.75 1.5Z" fill="#212121"/> </svg>');
  @override
  PathIconData get textEdit => _textEditInstance;
  static final _textEditInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M20.0626 8.44532C21.319 9.70247 21.3183 11.7401 20.0612 12.9964L12.938 20.1076C12.675 20.3701 12.3511 20.5634 11.9952 20.6703L7.70221 21.9589C7.17324 22.1177 6.61572 21.8176 6.45694 21.2886C6.3987 21.0946 6.40076 20.8874 6.46285 20.6946L7.82425 16.4666C7.93389 16.1261 8.12313 15.8166 8.37628 15.5639L15.5091 8.44272C16.7674 7.18646 18.8058 7.18762 20.0626 8.44532ZM16.5689 9.50425L9.43607 16.6254C9.35168 16.7096 9.2886 16.8128 9.25206 16.9263L8.18228 20.2487L11.564 19.2336C11.6826 19.198 11.7906 19.1336 11.8782 19.046L19.0002 11.9361C19.6721 11.2647 19.6724 10.1768 19.0016 9.50564C18.3301 8.83371 17.2412 8.83309 16.5689 9.50425ZM8.15104 2.36975L8.20152 2.47487L11.454 10.724L10.297 11.879L9.556 10H5.443L4.44768 12.5209C4.30809 12.874 3.93033 13.0621 3.57164 12.9737L3.47447 12.9426C3.12137 12.803 2.93328 12.4253 3.02168 12.0666L3.05272 11.9694L6.80633 2.47427C7.04172 1.87883 7.84884 1.84415 8.15104 2.36975ZM7.50294 4.79226L6.036 8.5H8.964L7.50294 4.79226Z" fill="#212121"/> </svg>');
  @override
  PathIconData get sun => _sunInstance;
  static final _sunInstance = PathIconData.fromSvg(
      '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM9.00001 16C9.00001 12.134 12.134 9 16 9C19.866 9 23 12.134 23 16C23 19.866 19.866 23 16 23C12.134 23 9.00001 19.866 9.00001 16ZM16 11C13.2386 11 11 13.2386 11 16C11 18.7614 13.2386 21 16 21C18.7614 21 21 18.7614 21 16C21 13.2386 18.7614 11 16 11ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/> </svg>');
  @override
  PathIconData get moon => _moonInstance;
  static final _moonInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M20.0258 17.0012C17.2639 21.7848 11.1471 23.4238 6.3634 20.662C5.06068 19.9099 3.964 18.8924 3.12872 17.6794C2.84945 17.2739 3.0301 16.7138 3.49369 16.5479C7.26112 15.1995 9.27892 13.6369 10.4498 11.4018C11.6825 9.04884 12.001 6.47137 11.1387 2.93837C11.0195 2.44984 11.4053 1.98467 11.9075 2.01161C13.4645 2.09515 14.9856 2.54239 16.3649 3.33878C21.1486 6.10064 22.7876 12.2175 20.0258 17.0012ZM11.7785 12.0979C10.5272 14.4865 8.46706 16.1969 4.96104 17.5968C5.56929 18.2926 6.29275 18.8891 7.1134 19.3629C11.1796 21.7106 16.3791 20.3174 18.7267 16.2512C21.0744 12.1849 19.6812 6.98546 15.6149 4.63782C14.7379 4.13146 13.7951 3.79144 12.8228 3.62229C13.4699 7.00628 13.0525 9.66598 11.7785 12.0979Z" fill="#212121"/> </svg>');
  @override
  PathIconData get cornerLine => _cornerLineInstance;
  static final _cornerLineInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" clip-rule="evenodd" d="M11.2929 12.7071C11.1054 12.5196 11 12.2652 11 12L11 2C11 1.44772 11.4477 1 12 1C12.5523 1 13 1.44772 13 2L13 11L22 11C22.5523 11 23 11.4477 23 12C23 12.5523 22.5523 13 22 13L12 13C11.7348 13 11.4804 12.8946 11.2929 12.7071Z" fill="black"/> </svg>');
  @override
  PathIconData get pointLine => _pointLineInstance;
  static final _pointLineInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <circle cx="12" cy="12" r="3" fill="black"/> </svg>');
}

class _YamlIconsDataFilled extends YamlIconsData {
  const _YamlIconsDataFilled() : super._();

  @override
  PathIconData get palette => _paletteInstance;
  static final _paletteInstance = PathIconData.fromSvg(
      '<svg width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M1.83885 3.85764C4.77986 -0.0579715 10.8685 -1.19736 15.2028 1.49752C19.4826 4.15853 21.0566 9.2746 19.3037 14.0749C17.6485 18.6075 13.2873 20.4033 10.144 18.1233C8.9666 17.2692 8.5101 16.1985 8.2895 14.4595L8.1841 13.4715L8.1387 13.0741C8.016 12.14 7.82762 11.7216 7.43435 11.5024C6.89876 11.2038 6.54213 11.1969 5.83887 11.4694L5.48775 11.615L5.30902 11.693C4.29524 12.1332 3.62085 12.2879 2.76786 12.1092L2.56761 12.062L2.40407 12.0154C-0.38489 11.1512 -0.79798 7.36827 1.83885 3.85764ZM14.7669 8.5797C14.9456 9.2465 15.631 9.6423 16.2978 9.4636C16.9646 9.2849 17.3604 8.5995 17.1817 7.93267C17.003 7.26583 16.3176 6.87011 15.6508 7.04878C14.9839 7.22746 14.5882 7.91288 14.7669 8.5797ZM15.2615 12.0684C15.4402 12.7352 16.1256 13.1309 16.7924 12.9523C17.4592 12.7736 17.855 12.0882 17.6763 11.4213C17.4976 10.7545 16.8122 10.3588 16.1454 10.5374C15.4785 10.7161 15.0828 11.4015 15.2615 12.0684ZM12.7884 5.57703C12.9671 6.24386 13.6525 6.63959 14.3193 6.46091C14.9861 6.28224 15.3819 5.59681 15.2032 4.92998C15.0245 4.26315 14.3391 3.86742 13.6723 4.0461C13.0054 4.22478 12.6097 4.9102 12.7884 5.57703ZM12.7599 14.5754C12.9386 15.2422 13.624 15.638 14.2908 15.4593C14.9577 15.2806 15.3534 14.5952 15.1747 13.9284C14.996 13.2615 14.3106 12.8658 13.6438 13.0445C12.9769 13.2232 12.5812 13.9086 12.7599 14.5754ZM9.263 4.60544C9.4416 5.27227 10.1271 5.668 10.7939 5.48932C11.4607 5.31064 11.8565 4.62522 11.6778 3.95839C11.4991 3.29156 10.8137 2.89583 10.1469 3.07451C9.48 3.25318 9.0843 3.9386 9.263 4.60544Z" fill="#212121"/> </svg>');
  @override
  PathIconData get exportCode => _exportCodeInstance;
  static final _exportCodeInstance = PathIconData.fromSvg(
      '<svg width="19" height="21" viewBox="0 0 19 21" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M13.5 10C16.5376 10 19 12.4624 19 15.5C19 18.5376 16.5376 21 13.5 21C10.4624 21 8 18.5376 8 15.5C8 12.4624 10.4624 10 13.5 10ZM1.5028 2.62704L1.5 4.75V15.2542C1.5 17.0491 2.95507 18.5042 4.75 18.5042L7.7348 18.5051C8.0227 19.0561 8.3872 19.5608 8.8142 20.0048L4.75 20.0042C2.12665 20.0042 0 17.8776 0 15.2542V4.75C0 3.76929 0.62745 2.93512 1.5028 2.62704ZM14.2843 12.5886C14.1138 12.4705 13.8862 12.4705 13.7157 12.5886L13.6464 12.6464L13.5886 12.7157C13.4705 12.8862 13.4705 13.1138 13.5886 13.2843L13.6464 13.3536L15.2917 14.999L10.4937 15L10.4038 15.0081C10.1997 15.0451 10.0388 15.206 10.0018 15.4101L9.9937 15.5L10.0018 15.5899C10.0388 15.794 10.1997 15.9549 10.4038 15.9919L10.4937 16L15.2937 15.999L13.6464 17.6464L13.5886 17.7157C13.4536 17.9106 13.4729 18.18 13.6464 18.3536C13.82 18.5271 14.0894 18.5464 14.2843 18.4114L14.3536 18.3536L16.8832 15.8212L16.9202 15.7711L16.9622 15.691L16.9882 15.6083L16.9981 15.5444V15.4557L16.9883 15.392L16.9767 15.3488L16.9445 15.2708L16.9205 15.2293L16.8832 15.1788L14.3536 12.6464L14.2843 12.5886ZM13.75 0C14.9926 0 16 1.00736 16 2.25L16.0006 9.4984C15.2308 9.1773 14.3861 9 13.5 9C9.9101 9 7 11.9101 7 15.5C7 16.198 7.11 16.8702 7.3136 17.5004L4.75 17.5C3.50736 17.5 2.5 16.4926 2.5 15.25V2.25C2.5 1.00736 3.50736 0 4.75 0H13.75Z" fill="#212121"/> </svg>');
  @override
  PathIconData get checkmark => _checkmarkInstance;
  static final _checkmarkInstance = PathIconData.fromSvg(
      '<svg width="18" height="13" viewBox="0 0 18 13" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M5.5 10.5858L1.70711 6.7929C1.31658 6.4024 0.68342 6.4024 0.29289 6.7929C-0.09763 7.1834 -0.09763 7.8166 0.29289 8.2071L4.79289 12.7071C5.18342 13.0976 5.81658 13.0976 6.20711 12.7071L17.2071 1.70711C17.5976 1.31658 17.5976 0.68342 17.2071 0.29289C16.8166 -0.09763 16.1834 -0.09763 15.7929 0.29289L5.5 10.5858Z" fill="#212121"/> </svg>');
  @override
  PathIconData get clipboard => _clipboardInstance;
  static final _clipboardInstance = PathIconData.fromSvg(
      '<svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M9.75 1.5H6.25C5.83579 1.5 5.5 1.83579 5.5 2.25C5.5 2.66421 5.83579 3 6.25 3H9.75C10.1642 3 10.5 2.66421 10.5 2.25C10.5 1.83579 10.1642 1.5 9.75 1.5ZM6.25 0H9.75C10.9926 0 12 1.00736 12 2.25C12 2.16531 11.9953 2.0817 11.9862 1.99944L13.75 2C14.9926 2 16 3.00736 16 4.25V17.75C16 18.9926 14.9926 20 13.75 20H2.25C1.00736 20 0 18.9926 0 17.75V4.25C0 3.00736 1.00736 2 2.25 2L4.01379 1.99944C4.00468 2.0817 4 2.16531 4 2.25C4 1.00736 5.00736 0 6.25 0Z" fill="#212121"/> </svg>');
  @override
  PathIconData get textEdit => _textEditInstance;
  static final _textEditInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M20.0626 8.44532C21.319 9.70247 21.3183 11.7401 20.0612 12.9964L12.9472 20.0984C12.6755 20.3697 12.3388 20.5669 11.9693 20.6713L7.35625 21.9745C6.78509 22.1359 6.2617 21.6013 6.43506 21.0337L7.82258 16.4905C7.93042 16.1374 8.1235 15.8162 8.38478 15.5554L15.5091 8.44272C16.7674 7.18646 18.8058 7.18762 20.0626 8.44532ZM8.15104 2.36975L8.20152 2.47487L11.454 10.724L10.297 11.879L9.556 10H5.443L4.44768 12.5209C4.30809 12.874 3.93033 13.0621 3.57164 12.9737L3.47447 12.9426C3.12137 12.803 2.93328 12.4253 3.02168 12.0666L3.05272 11.9694L6.80633 2.47427C7.04172 1.87883 7.84884 1.84415 8.15104 2.36975ZM7.50294 4.79226L6.036 8.5H8.964L7.50294 4.79226Z" fill="#212121"/> </svg>');
  @override
  PathIconData get sun => _sunInstance;
  static final _sunInstance = PathIconData.fromSvg(
      '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M16.0005 2C16.5528 2 17.0005 2.44772 17.0005 3V5C17.0005 5.55228 16.5528 6 16.0005 6C15.4482 6 15.0005 5.55228 15.0005 5V3C15.0005 2.44772 15.4482 2 16.0005 2ZM26.2071 7.20711C26.5977 6.81658 26.5977 6.18342 26.2071 5.79289C25.8166 5.40237 25.1835 5.40237 24.7929 5.79289L23.2929 7.29289C22.9024 7.68342 22.9024 8.31658 23.2929 8.70711C23.6835 9.09763 24.3166 9.09763 24.7071 8.70711L26.2071 7.20711ZM5.79289 5.79293C6.18341 5.4024 6.81658 5.4024 7.20711 5.79291L8.70711 7.29287C9.09764 7.68339 9.09765 8.31656 8.70713 8.70709C8.31661 9.09762 7.68344 9.09763 7.29291 8.70711L5.79291 7.20715C5.40238 6.81663 5.40237 6.18346 5.79289 5.79293ZM16 9C12.134 9 9.00001 12.134 9.00001 16C9.00001 19.866 12.134 23 16 23C19.866 23 23 19.866 23 16C23 12.134 19.866 9 16 9ZM26 16.0213C26 15.469 26.4478 15.0213 27 15.0213H29C29.5523 15.0213 30 15.469 30 16.0213C30 16.5736 29.5523 17.0213 29 17.0213H27C26.4478 17.0213 26 16.5736 26 16.0213ZM3 15C2.44772 15 2 15.4477 2 16C2 16.5523 2.44772 17 3 17H5C5.55229 17 6.00001 16.5523 6.00001 16C6.00001 15.4477 5.55229 15 5 15H3ZM23.2929 23.2929C23.6835 22.9023 24.3166 22.9023 24.7071 23.2929L26.2071 24.7929C26.5977 25.1834 26.5977 25.8166 26.2071 26.2071C25.8166 26.5976 25.1835 26.5976 24.7929 26.2071L23.2929 24.7071C22.9024 24.3166 22.9024 23.6834 23.2929 23.2929ZM8.70712 24.7071C9.09764 24.3166 9.09764 23.6834 8.70712 23.2929C8.31659 22.9023 7.68343 22.9023 7.2929 23.2929L5.7929 24.7929C5.40237 25.1834 5.40237 25.8166 5.7929 26.2071C6.18342 26.5976 6.81659 26.5976 7.20711 26.2071L8.70712 24.7071ZM16.9956 27.0192C16.9956 26.4669 16.5479 26.0192 15.9956 26.0192C15.4433 26.0192 14.9956 26.4669 14.9956 27.0192V29C14.9956 29.5523 15.4433 30 15.9956 30C16.5479 30 16.9956 29.5523 16.9956 29V27.0192Z" fill="#212121"/> </svg>');
  @override
  PathIconData get moon => _moonInstance;
  static final _moonInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M20.0258 17.0014C17.2639 21.7851 11.1471 23.4241 6.3634 20.6622C5.06068 19.9101 3.964 18.8926 3.12872 17.6797C2.84945 17.2741 3.0301 16.7141 3.49369 16.5482C7.26112 15.1997 9.27892 13.6372 10.4498 11.4021C11.6825 9.04908 12.001 6.47162 11.1387 2.93862C11.0195 2.45008 11.4053 1.98492 11.9075 2.01186C13.4645 2.09539 14.9856 2.54263 16.3649 3.33903C21.1486 6.10088 22.7876 12.2177 20.0258 17.0014Z" fill="#212121"/> </svg>');
  @override
  PathIconData get cornerLine => _cornerLineInstance;
  static final _cornerLineInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <path fill-rule="evenodd" clip-rule="evenodd" d="M11.2929 12.7071C11.1054 12.5196 11 12.2652 11 12L11 2C11 1.44772 11.4477 1 12 1C12.5523 1 13 1.44772 13 2L13 11L22 11C22.5523 11 23 11.4477 23 12C23 12.5523 22.5523 13 22 13L12 13C11.7348 13 11.4804 12.8946 11.2929 12.7071Z" fill="black"/> </svg>');
  @override
  PathIconData get pointLine => _pointLineInstance;
  static final _pointLineInstance = PathIconData.fromSvg(
      '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <circle cx="12" cy="12" r="3" fill="black"/> </svg>');
}

class YamlSpacingData {
  const YamlSpacingData({
    required this.extraSmall,
    required this.small,
    required this.semiSmall,
    required this.regular,
    required this.semiBig,
    required this.big,
    required this.extraBig,
  });

  const YamlSpacingData.regular()
      : this.extraSmall = 2.00,
        this.small = 4.00,
        this.semiSmall = 8.00,
        this.regular = 10.00,
        this.semiBig = 20.00,
        this.big = 32.00,
        this.extraBig = 48.00;

  final double extraSmall;
  final double small;
  final double semiSmall;
  final double regular;
  final double semiBig;
  final double big;
  final double extraBig;

  YamlSpacingData copyWith({
    double? extraSmall,
    double? small,
    double? semiSmall,
    double? regular,
    double? semiBig,
    double? big,
    double? extraBig,
  }) =>
      YamlSpacingData(
        extraSmall: extraSmall ?? this.extraSmall,
        small: small ?? this.small,
        semiSmall: semiSmall ?? this.semiSmall,
        regular: regular ?? this.regular,
        semiBig: semiBig ?? this.semiBig,
        big: big ?? this.big,
        extraBig: extraBig ?? this.extraBig,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlSpacingData &&
          extraSmall == other.extraSmall &&
          small == other.small &&
          semiSmall == other.semiSmall &&
          regular == other.regular &&
          semiBig == other.semiBig &&
          big == other.big &&
          extraBig == other.extraBig);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      extraSmall.hashCode ^
      small.hashCode ^
      semiSmall.hashCode ^
      regular.hashCode ^
      semiBig.hashCode ^
      big.hashCode ^
      extraBig.hashCode;
}

class YamlEdgeInsetsData {
  const YamlEdgeInsetsData({
    required this.extraSmall,
    required this.small,
    required this.semiSmall,
    required this.regular,
    required this.semiBig,
    required this.big,
    required this.extraBig,
  });

  const YamlEdgeInsetsData.regular()
      : this.extraSmall = const EdgeInsets.all(2.00),
        this.small = const EdgeInsets.all(4.00),
        this.semiSmall = const EdgeInsets.all(8.00),
        this.regular = const EdgeInsets.all(10.00),
        this.semiBig = const EdgeInsets.all(20.00),
        this.big = const EdgeInsets.all(32.00),
        this.extraBig = const EdgeInsets.all(48.00);

  final EdgeInsets extraSmall;
  final EdgeInsets small;
  final EdgeInsets semiSmall;
  final EdgeInsets regular;
  final EdgeInsets semiBig;
  final EdgeInsets big;
  final EdgeInsets extraBig;

  YamlEdgeInsetsData copyWith({
    EdgeInsets? extraSmall,
    EdgeInsets? small,
    EdgeInsets? semiSmall,
    EdgeInsets? regular,
    EdgeInsets? semiBig,
    EdgeInsets? big,
    EdgeInsets? extraBig,
  }) =>
      YamlEdgeInsetsData(
        extraSmall: extraSmall ?? this.extraSmall,
        small: small ?? this.small,
        semiSmall: semiSmall ?? this.semiSmall,
        regular: regular ?? this.regular,
        semiBig: semiBig ?? this.semiBig,
        big: big ?? this.big,
        extraBig: extraBig ?? this.extraBig,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlEdgeInsetsData &&
          extraSmall == other.extraSmall &&
          small == other.small &&
          semiSmall == other.semiSmall &&
          regular == other.regular &&
          semiBig == other.semiBig &&
          big == other.big &&
          extraBig == other.extraBig);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      extraSmall.hashCode ^
      small.hashCode ^
      semiSmall.hashCode ^
      regular.hashCode ^
      semiBig.hashCode ^
      big.hashCode ^
      extraBig.hashCode;
}

class YamlDurationsData {
  const YamlDurationsData({
    required this.quick,
    required this.regular,
    required this.slow,
  });

  const YamlDurationsData.regular()
      : this.quick = const Duration(milliseconds: 100),
        this.regular = const Duration(milliseconds: 200),
        this.slow = const Duration(milliseconds: 1000);

  const YamlDurationsData.slow()
      : this.quick = const Duration(milliseconds: 300),
        this.regular = const Duration(milliseconds: 500),
        this.slow = const Duration(milliseconds: 4000);

  final Duration quick;
  final Duration regular;
  final Duration slow;

  YamlDurationsData copyWith({
    Duration? quick,
    Duration? regular,
    Duration? slow,
  }) =>
      YamlDurationsData(
        quick: quick ?? this.quick,
        regular: regular ?? this.regular,
        slow: slow ?? this.slow,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlDurationsData &&
          quick == other.quick &&
          regular == other.regular &&
          slow == other.slow);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ quick.hashCode ^ regular.hashCode ^ slow.hashCode;
}

class YamlThemeData {
  const YamlThemeData({
    required this.colors,
    required this.fontStyles,
    required this.fontSizes,
    required this.radiuses,
    required this.borderRadiuses,
    required this.icons,
    required this.spacing,
    required this.edgeInsets,
    required this.durations,
  });

  const YamlThemeData.fallback()
      : this.colors = const YamlColorsData.dark(),
        this.fontStyles = const YamlFontStylesData.regular(),
        this.fontSizes = const YamlFontSizesData.regular(),
        this.radiuses = const YamlRadiusesData.regular(),
        this.borderRadiuses = const YamlBorderRadiusesData.regular(),
        this.icons = const YamlIconsData.lines(),
        this.spacing = const YamlSpacingData.regular(),
        this.edgeInsets = const YamlEdgeInsetsData.regular(),
        this.durations = const YamlDurationsData.regular();

  final YamlColorsData colors;
  final YamlFontStylesData fontStyles;
  final YamlFontSizesData fontSizes;
  final YamlRadiusesData radiuses;
  final YamlBorderRadiusesData borderRadiuses;
  final YamlIconsData icons;
  final YamlSpacingData spacing;
  final YamlEdgeInsetsData edgeInsets;
  final YamlDurationsData durations;

  YamlThemeData copyWith({
    YamlColorsData? colors,
    YamlFontStylesData? fontStyles,
    YamlFontSizesData? fontSizes,
    YamlRadiusesData? radiuses,
    YamlBorderRadiusesData? borderRadiuses,
    YamlIconsData? icons,
    YamlSpacingData? spacing,
    YamlEdgeInsetsData? edgeInsets,
    YamlDurationsData? durations,
  }) =>
      YamlThemeData(
        colors: colors ?? this.colors,
        fontStyles: fontStyles ?? this.fontStyles,
        fontSizes: fontSizes ?? this.fontSizes,
        radiuses: radiuses ?? this.radiuses,
        borderRadiuses: borderRadiuses ?? this.borderRadiuses,
        icons: icons ?? this.icons,
        spacing: spacing ?? this.spacing,
        edgeInsets: edgeInsets ?? this.edgeInsets,
        durations: durations ?? this.durations,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is YamlThemeData &&
          colors == other.colors &&
          fontStyles == other.fontStyles &&
          fontSizes == other.fontSizes &&
          radiuses == other.radiuses &&
          borderRadiuses == other.borderRadiuses &&
          icons == other.icons &&
          spacing == other.spacing &&
          edgeInsets == other.edgeInsets &&
          durations == other.durations);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      colors.hashCode ^
      fontStyles.hashCode ^
      fontSizes.hashCode ^
      radiuses.hashCode ^
      borderRadiuses.hashCode ^
      icons.hashCode ^
      spacing.hashCode ^
      edgeInsets.hashCode ^
      durations.hashCode;
}
