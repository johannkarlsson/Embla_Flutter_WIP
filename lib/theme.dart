/*
 * This file is part of the Embla Flutter app
 * Copyright (c) 2020-2022 Miðeind ehf. <mideind@mideind.is>
 * Original author: Sveinbjorn Thordarson
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// Configure app theme: colors, fonts and other styling

import 'package:flutter/material.dart';

extension HexColor on Color {
  // Get standard Flutter Color object from hex string in the
  // format "aabbcc" or "ffaabbcc", with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

// Session button circle colors, outermost to innermost
final Color circleColor1 = HexColor.fromHex('#f9f0f0');
final Color circleColor2 = HexColor.fromHex('#f9e2e1');
final Color circleColor3 = HexColor.fromHex('#f9dcdb');

const String defaultFontFamily = 'Lato';
const double defaultFontSize = 19.0;
const double sessionFontSize = 24.0;

const menuTextStyle = TextStyle(fontSize: defaultFontSize);
const sessionTextStyle =
    TextStyle(fontSize: sessionFontSize, fontStyle: FontStyle.italic);

// Define default (light) app styling and color scheme
final Color lightMainColor = HexColor.fromHex('#e83939');
final Color lightBgColor = HexColor.fromHex('#f9f9f9');
final Color lightTextColor = HexColor.fromHex('#202020');

final lightThemeData = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBgColor,
    primarySwatch: Colors.red,
    primaryColor: lightMainColor,
    backgroundColor: lightBgColor,
    fontFamily: defaultFontFamily,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      subtitle2: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      overline: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      button: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      caption: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      bodyText1: TextStyle(color: lightMainColor, fontSize: 16.0),
      bodyText2: TextStyle(color: lightMainColor, fontSize: 16.0),
      headline1: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      headline2: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      headline3: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      headline4: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      headline5: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
      headline6: TextStyle(color: lightTextColor, fontSize: defaultFontSize),
    ),
    cardTheme: const CardTheme(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        // side: BorderSide(
        //   color: lightMainColor,
        //   width: 0.4,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: lightBgColor,
      iconTheme: IconThemeData(color: lightMainColor),
    ));

// Define dark mode app styling and color scheme
final darkMainColor = HexColor.fromHex('#f7f7f7');
final darkBgColor = HexColor.fromHex('#202020');

final darkThemeData = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBgColor,
    primarySwatch: Colors.grey,
    primaryColor: darkMainColor,
    backgroundColor: darkBgColor,
    fontFamily: defaultFontFamily,
    textTheme: TextTheme(
      subtitle1: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      subtitle2: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      overline: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      button: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      caption: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      bodyText1: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      bodyText2: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline1: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline2: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline3: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline4: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline5: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
      headline6: TextStyle(color: darkMainColor, fontSize: defaultFontSize),
    ),
    cardTheme: const CardTheme(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        // side: BorderSide(
        //   color: darkMainColor,
        //   width: 0.4,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    ),
    appBarTheme: AppBarTheme(
      color: darkBgColor,
      iconTheme: IconThemeData(color: darkMainColor),
    ));

final standardAppBar = AppBar(
  bottomOpacity: 0.0,
  elevation: 0.0,
  toolbarOpacity: 1.0,
);

String img4theme(String imgName, var context) {
  if (context == null) {
    return imgName;
  }
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark) {
    imgName = "${imgName}_dark";
  }
  return imgName;
}

Color color4ctx(var context) {
  if (context == null) {
    return lightMainColor;
  }
  var brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark) {
    return darkMainColor;
  }
  return lightMainColor;
}

List circleColors4Context(var context) {
  Color circleColor1 = HexColor.fromHex('#f9f0f0');
  Color circleColor2 = HexColor.fromHex('#f9e2e1');
  Color circleColor3 = HexColor.fromHex('#f9dcdb');
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    circleColor1 = HexColor.fromHex('#f0f0f0');
    circleColor2 = HexColor.fromHex('#e4e4e4');
    circleColor3 = HexColor.fromHex('#dcdcdc');
  }
  return [circleColor1, circleColor2, circleColor3];
}
