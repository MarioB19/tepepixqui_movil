import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue.shade700,
  onPrimary: Colors.white,
  primaryContainer: Colors.blue.shade100,
  onPrimaryContainer: Colors.blue.shade900,
  secondary: Colors.blue.shade500,
  onSecondary: Colors.white,
  secondaryContainer: Colors.blue.shade200,
  onSecondaryContainer: Colors.blue.shade800,
  tertiary: Colors.blue.shade300,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.blue.shade50,
  onTertiaryContainer: Colors.blue.shade900,
  error: Colors.red.shade700,
  onError: Colors.white,
  errorContainer: Colors.red.shade100,
  onErrorContainer: Colors.red.shade900,
  background: Colors.white,
  onBackground: Colors.black,
  surface: Colors.grey.shade100,
  onSurface: Colors.black,
  surfaceVariant: Colors.grey.shade200,
  onSurfaceVariant: Colors.black87,
  outline: Colors.black,
  outlineVariant: Colors.grey.shade300,
  shadow: Colors.black.withOpacity(0.1),
  scrim: Colors.black.withOpacity(0.3),
  inverseSurface: Colors.black,
  onInverseSurface: Colors.white,
  inversePrimary: Colors.blue.shade200,
  surfaceTint: Colors.blue.shade50,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blue.shade200,
  onPrimary: Colors.black,
  primaryContainer: Colors.blue.shade800,
  onPrimaryContainer: Colors.blue.shade50,
  secondary: Colors.blue.shade400,
  onSecondary: Colors.black,
  secondaryContainer: Colors.blue.shade700,
  onSecondaryContainer: Colors.blue.shade100,
  tertiary: Colors.blue.shade300,
  onTertiary: Colors.black,
  tertiaryContainer: Colors.blue.shade800,
  onTertiaryContainer: Colors.blue.shade100,
  error: Colors.red.shade300,
  onError: Colors.black,
  errorContainer: Colors.red.shade800,
  onErrorContainer: Colors.red.shade100,
  background: Colors.grey.shade900,
  onBackground: Colors.white,
  surface: Colors.grey.shade800,
  onSurface: Colors.white,
  surfaceVariant: Colors.grey.shade700,
  onSurfaceVariant: Colors.white70,
  outline: Colors.white,
  outlineVariant: Colors.grey.shade700,
  shadow: Colors.black.withOpacity(0.3),
  scrim: Colors.black.withOpacity(0.5),
  inverseSurface: Colors.white,
  onInverseSurface: Colors.black,
  inversePrimary: Colors.blue.shade700,
  surfaceTint: Colors.blue.shade900,
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  primaryColor: lightColorScheme.primary,
  hintColor: Colors.black,
  scaffoldBackgroundColor: lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  cardTheme: CardTheme(
    color: lightColorScheme.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: lightColorScheme.outline),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: lightColorScheme.primary,
      side: BorderSide(color: lightColorScheme.outline),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: lightColorScheme.primary,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return lightColorScheme.surfaceVariant;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primaryContainer;
      }
      return lightColorScheme.surfaceVariant;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return lightColorScheme.surfaceVariant;
    }),
    checkColor: MaterialStateProperty.all(lightColorScheme.onPrimary),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return lightColorScheme.primary;
      }
      return lightColorScheme.surfaceVariant;
    }),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: lightColorScheme.secondary,
    foregroundColor: lightColorScheme.onSecondary,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: lightColorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightColorScheme.inverseSurface,
    contentTextStyle: TextStyle(color: lightColorScheme.onInverseSurface),
    actionTextColor: lightColorScheme.inversePrimary,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: lightColorScheme.surfaceVariant,
    labelStyle: TextStyle(color: lightColorScheme.onSurfaceVariant),
    side: BorderSide.none,
  ),
  dividerTheme: DividerThemeData(
    color: lightColorScheme.outline,
    thickness: 1,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorScheme.outline),
    ),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: lightColorScheme.primary),
    ),
    hintStyle: TextStyle(color: Colors.black),
    fillColor: lightColorScheme.surface,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  primaryColor: darkColorScheme.primary,
  hintColor: Colors.white,
  scaffoldBackgroundColor: darkColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  cardTheme: CardTheme(
    color: darkColorScheme.surface,
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: darkColorScheme.outline),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: darkColorScheme.primary,
      side: BorderSide(color: darkColorScheme.outline),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: darkColorScheme.primary,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return darkColorScheme.surfaceVariant;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primaryContainer;
      }
      return darkColorScheme.surfaceVariant;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return darkColorScheme.surfaceVariant;
    }),
    checkColor: MaterialStateProperty.all(darkColorScheme.onPrimary),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return darkColorScheme.primary;
      }
      return darkColorScheme.surfaceVariant;
    }),
  ),


  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: darkColorScheme.secondary,
    foregroundColor: darkColorScheme.onSecondary,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: darkColorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: darkColorScheme.inverseSurface,
    contentTextStyle: TextStyle(color: darkColorScheme.onInverseSurface),
    actionTextColor: darkColorScheme.inversePrimary,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: darkColorScheme.surfaceVariant,
    labelStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
    side: BorderSide.none,
  ),
  dividerTheme: DividerThemeData(
    color: darkColorScheme.outline,
    thickness: 1,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: darkColorScheme.outline),
    ),
 
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: darkColorScheme.primary),
    ),
    hintStyle: TextStyle(color: Colors.white),
    fillColor: darkColorScheme.surface,
  ),
);