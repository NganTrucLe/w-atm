import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static const colors = AppColors();
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: colors.primary500,
      accentColor: colors.white,
      fontFamily: 'SF-Pro-Display',
      backgroundColor: colors.white,
    );
  }
}
