import 'package:flutter/material.dart';

class BrandColors {
  static Color get prussianBlue => const Color(0xFF003049);

  static Color get prussianBlueDark => const Color(0xFF002b42);

  static Color get bitterSweet => const Color(0xFFFF715B);
}

final colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: BrandColors.prussianBlue,
  primaryVariant: BrandColors.prussianBlueDark,
  onPrimary: Colors.white,
  secondary: BrandColors.bitterSweet,
  secondaryVariant: BrandColors.bitterSweet,
  onSecondary: Colors.black87,
  background: BrandColors.prussianBlueDark,
  onBackground: Colors.white,
  surface: BrandColors.prussianBlue,
  onSurface: Colors.white,
  error: Colors.redAccent,
  onError: Colors.black87,
);
