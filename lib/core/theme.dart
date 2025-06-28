import 'package:flutter/material.dart';

// light mode colors
const Color _lightPrimaryColor = Color(0xFF6621BA);
const Color _lightOnPrimaryColor = Colors.white;
const Color _lightSecondaryColor = Color(0xFF6078FF);
const Color _lightOnSecondaryColor = Colors.white;
const Color _lightSurfaceColor = Color(0xFF9BACBF);
const Color _lightOnSurfaceColor = Color(0xFF1D1D3C);
const Color _lightErrorColor = Color(0xFFF98A17);
const Color _lightOnErrorColor = Colors.white;
const Color _lightOutlineColor = Color(0xFFBDBDBD);
const Color _lightSurfaceContainerHighest = Color(0xFFEAEDF1);

// dark mode colors
const Color _darkPrimaryColor = Color(0xFF6621BA);
const Color _darkOnPrimaryColor = Colors.white;
const Color _darkSecondaryColor = Color(0xFF6078FF);
const Color _darkOnSecondaryColor = Colors.white;
const Color _darkSurfaceColor = Color(0xFF000000);
const Color _darkOnSurfaceColor = Color(0xFFFFFFFF);
const Color _darkErrorColor = Color(0xFFF98A17);
//const Color _darkOnErrorColor = Colors.black;
const Color _darkOutlineColor = Color(0xFF424242);
const Color _darkSurfaceContainerHighest = Color(0xFF1D1D3C);


class AppTheme {
  // screen breakpoints for responsive design
  static const double _smallScreenBreakpoint = 600.0;
  static const double _mediumScreenBreakpoint = 1000.0;

  // method to get responsive size
  static double responsiveSize(BuildContext context, double small, double large) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < _smallScreenBreakpoint) {
      return small;
    } else if (screenWidth < _mediumScreenBreakpoint) {
      return (small + large) / 2; // Valor intermedio
    } else {
      return large;
    }
  }

  // method to get responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < _smallScreenBreakpoint) {
      return const EdgeInsets.all(16.0);
    } else if (screenWidth < _mediumScreenBreakpoint) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  static final ThemeData lightTheme = _buildLightTheme();
  static final ThemeData darkTheme = _buildDarkTheme();

  // lightmode constructor
  static ThemeData _buildLightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      // Configuration de ColorScheme (Material 3)
      colorScheme: base.colorScheme.copyWith(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        secondary: _lightSecondaryColor,
        onSecondary: _lightOnSecondaryColor,
        surface: _lightSurfaceColor,
        onSurface: _lightOnSurfaceColor,
        error: _lightErrorColor,
        onError: _lightOnErrorColor,
        outline: _lightOutlineColor,
        surfaceContainerHighest: _lightSurfaceContainerHighest,
      ),

      // theme for text styles
      textTheme: _buildLightTextTheme(base.textTheme),

      // theme for InputFields (TextFormField, DropdownButtonFormField, etc.)
      inputDecorationTheme: InputDecorationTheme(
        filled: true, // Fondo relleno
        fillColor: _lightSurfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightOutlineColor.withAlpha((255 * 0.5).round())),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _lightPrimaryColor, width: 2),
        ),
        labelStyle: TextStyle(color: _lightOnSurfaceColor.withAlpha((255 * 0.7).round())),
        hintStyle: TextStyle(color: _lightOnSurfaceColor.withAlpha((255 * 0.5).round())),
        prefixIconColor: _lightOnSurfaceColor.withAlpha((255 * 0.7).round()),
      ),

      // theme for AlertDialogs
      dialogTheme: DialogThemeData(
        backgroundColor: _lightSurfaceColor,
        titleTextStyle: TextStyle(
          color: _lightOnSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: _lightOnSurfaceColor.withAlpha((255 * 0.8).round()),
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // darkmode constructor
  static ThemeData _buildDarkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      // configuration de ColorScheme (Material 3)
      colorScheme: base.colorScheme.copyWith(
        primary: _darkPrimaryColor,
        onPrimary: _darkOnPrimaryColor,
        secondary: _darkSecondaryColor,
        onSecondary: _darkOnSecondaryColor,
        surface: _darkSurfaceColor,
        onSurface: _darkOnSurfaceColor,
        error: _darkErrorColor,
        outline: _darkOutlineColor,
        surfaceContainerHighest: _darkSurfaceContainerHighest,
      ),
      // textTheme: _buildDarkTextTheme(base.textTheme),
      textTheme: _buildDarkTextTheme(base.textTheme),

      // theme for InputFields (TextFormField, DropdownButtonFormField, etc.)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkOutlineColor.withAlpha((255 * 0.5).round())),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _darkPrimaryColor, width: 2),
        ),
        labelStyle: TextStyle(color: _darkOnSurfaceColor.withAlpha((255 * 0.7).round())),
        hintStyle: TextStyle(color: _darkOnSurfaceColor.withAlpha((255 * 0.5).round())),
        prefixIconColor: _darkOnSurfaceColor.withAlpha((255 * 0.7).round()),
      ),

      // theme for AlertDialogs
      dialogTheme: DialogThemeData(
        backgroundColor: _darkSurfaceColor,
        titleTextStyle: TextStyle(
          color: _darkOnSurfaceColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: _darkOnSurfaceColor.withAlpha((255 * 0.8).round()),
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // text themes for light and dark modes
  static TextTheme _buildLightTextTheme(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(color: _lightOnSurfaceColor),
      titleLarge: base.titleLarge?.copyWith(color: _lightOnSurfaceColor),
      titleMedium: base.titleMedium?.copyWith(color: _lightOnSurfaceColor),
      bodyMedium: base.bodyMedium?.copyWith(color: _lightOnSurfaceColor),
      bodySmall: base.bodySmall?.copyWith(color: _lightOnSurfaceColor),
      labelLarge: base.labelLarge?.copyWith(color: _lightOnSurfaceColor),
    );
  }
  // text themes for dark mode
  static TextTheme _buildDarkTextTheme(TextTheme base) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(color: _darkOnSurfaceColor),
      titleLarge: base.titleLarge?.copyWith(color: _darkOnSurfaceColor),
      titleMedium: base.titleMedium?.copyWith(color: _darkOnSurfaceColor),
      bodyMedium: base.bodyMedium?.copyWith(color: _darkOnSurfaceColor),
      bodySmall: base.bodySmall?.copyWith(color: _darkOnSurfaceColor),
      labelLarge: base.labelLarge?.copyWith(color: _darkOnSurfaceColor),
    );
  }
}
