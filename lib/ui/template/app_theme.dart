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
  static const Color nearlyDarkBrown = Color(0xFFf76d16);
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

  static Color levelColor(int level) {//report
    switch (level) {
      case 0:
        return Color(0xffff5050); //ff5050
      case 1:
        return Color(0xff008080); //008080
      case 2:
        return Color(0xff4dd2ff);//4dd2ff
      case 3:
        return Color(0xff751aff);//751aff
      case 4:
        return Color(0xffe6b800);//e6b800
      case 5:
        return Color(0xff40bf80);//40bf80
      case 6:
        return Color(0xff999900);//999900
      case 7:
        return Color(0xff991f00); //991f00
      case 8:
        return Color(0xffff00ff); //ff00ff
      case 9:
        return Color(0xff0000b3); //0000b3
      case 10:
        return Color(0xff52527a);//52527a
      case 11:
        return Color(0xff734d26); //734d26
    }
  }

  static Color monthColor(int count) {
    int c=(count/24).floor();
    if (c <1) {
      return Color(0xffff1a1a); // <ngay, gio
    } else {
      if (c >= 1 && c < 7) {
        return Color(0xffe68a00); //<tuan
      } else {
        if (c >= 7 && c < 30) {
          return Color(0xffffff00);// <thang
        } else {
          if (c >= 30 && c < 365) {
            return Color(0xfff5f5f0);// <nam
          } else
            return Color(0xffc2c2a3); // >nam
        }
      }
    }
  }

  static Color listColorMonth(int index) {
    switch (index) {
      case 0:
        return Color(0xffff1a1a);
      case 1:
        return Color(0xffe68a00);
      case 2:
        return Color(0xffffff00);
      case 3:
        return Color(0xffc2c2a3);
      case 4:
        return Color(0xfff5f5f0);
    }
  }
}
