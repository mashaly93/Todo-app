import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/shared/colors.dart';

class Mythemedata {
  static const Color primary = Color(0XFFB7935F);
  static ThemeData lightMode = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor: Colors.white,
      selectedItemColor: blue,
      unselectedItemColor: Colors.grey
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.grey,
      error: Colors.amber,
      onError: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),


    textTheme: TextTheme(
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 10,
        fontWeight: FontWeight.w100,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.elMessiri(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darktMode = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.white,
      secondary: Colors.yellow,
      onSecondary: Colors.red,
      error: Colors.amber,
      onError: Colors.grey,
      surface: Colors.white,
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 10,
        fontWeight: FontWeight.w100,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.elMessiri(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
