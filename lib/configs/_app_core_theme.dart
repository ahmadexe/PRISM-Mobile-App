part of 'configs.dart';

class AppCoreTheme {
  Color? primary;
  Color? primaryLight;
  Color? primaryDark;

  Color? accent;
  Color? accentLight;
  Color? accentDark;

  Color? background;
  Color? backgroundSub;
  Color? scaffold;
  Color? scaffoldDark;

  Color? danger;
  Color? grey;
  Color? yellow;
  Color? ghostGrey;

  Color? text;
  Color? textLight;
  Color? textGrey;
  Color? lightGrey;

  Color? shadow; // Normal shadowOnBackground
  Color? shadowSub; // Shadow light

  Color? white;
  Color? pink;

  Color? fieldLight;
  Color? fieldDark;

  AppCoreTheme({
    this.primary,
    this.primaryLight,
    this.primaryDark,
    this.accent,
    this.accentLight,
    this.danger,
    this.grey,
    this.accentDark,
    this.background,
    this.yellow,
    this.ghostGrey,
    this.backgroundSub,
    this.scaffold,
    this.scaffoldDark,
    this.text,
    this.textLight,
    this.textGrey,
    this.shadow,
    this.shadowSub,
    this.lightGrey,
    this.white,
    this.pink,
    this.fieldLight,
    this.fieldDark,
  });

  AppCoreTheme copyWith(
      {Color? primary,
      Color? primaryLight,
      Color? primaryDark,
      Color? accent,
      Color? accentLight,
      Color? accentDark,
      Color? background,
      Color? backgroundSub,
      Color? scaffold,
      Color? red,
      Color? grey,
      Color? scaffoldDark,
      Color? text,
      Color? lightGrey,
      Color? yellow,
      Color? ghostGrey,
      Color? textSub,
      Color? textSub2,
      Color? shadow,
      Color? shadowSub,
      Color? upsellCard,
      Color? hotelChipRefundable,
      Color? hotelChipAirportTransfer,
      Color? white,
      Color? pink,
      Color? fieldLight,
      Color? fieldDark,
      }) {
    return AppCoreTheme(
      danger: red ?? danger,
      grey: grey ?? this.grey,
      ghostGrey: ghostGrey ?? this.ghostGrey,
      yellow: yellow ?? this.yellow,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      accentDark: accentDark ?? this.accentDark,
      background: background ?? this.background,
      backgroundSub: backgroundSub ?? this.backgroundSub,
      scaffold: scaffold ?? this.scaffold,
      scaffoldDark: scaffoldDark ?? this.scaffoldDark,
      text: text ?? this.text,
      textLight: textSub ?? textLight,
      textGrey: textSub2 ?? textGrey,
      shadow: shadow ?? this.shadow,
      shadowSub: shadowSub ?? this.shadowSub,
      lightGrey: lightGrey ?? this.lightGrey,
      white: white ?? this.white,
      pink: pink ?? this.pink,
      fieldLight: fieldLight ?? this.fieldLight,
      fieldDark: fieldDark ?? this.fieldDark,
    );
  }
}
