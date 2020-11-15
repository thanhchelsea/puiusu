import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyDarkRed = Color(0xFFa1051D);

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static Color convertColors(int level) {
    if (level > 9) return Color(0xff990033);
    switch (level) {
      case 0:
        {
          return Color(0xffe6f2ff);
        }
      case 1:
        {
          return Color(0xffb3ffe6);
        }
      case 2:
        {
          return Color(0xffb3d9ff);
        }
      case 3:
        {
          return Color(0xffb3ff1a);
        }
      case 4:
        {
          return Color(0xff00e673);
        }
      case 5:
        {
          return Color(0xffffd9b3);
          break;
        }
      case 6:
        {
          return Color(0xffffad33);
        }
      case 7:
        {
          return Color(0xffff8566);
        }
      case 8:
        {
          return Color(0xffff3300);
        }
      case 9:
        {
          return Color(0xff990033);
        }
    }
  }

  static Color levelColor(int level) {
    switch (level) {
      case 0:
        return Colors.pinkAccent;
      case 1:
        return Colors.blueGrey;
      case 2:
        return Colors.greenAccent;
      case 3:
        return Colors.deepPurpleAccent;
      case 4:
        return Colors.amberAccent;
      case 5:
        return Colors.teal;
      case 6:
        return Colors.lime;
      case 7:
        return Colors.redAccent;
      case 8:
        return Colors.purpleAccent;
      case 9:
        return Colors.deepPurple;
      case 10:
        return Colors.blueGrey;
      case 11:
        return Colors.brown;
    }
  }
}
