import 'package:flutter/material.dart';

import 'screens/devices_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Raspberry Pi terminal color palette
class TerminalColors {
  static const Color background = Color(0xFF0C0C0C);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF2D2D2D);
  static const Color green = Color(0xFF00FF00);
  static const Color greenDim = Color(0xFF00AA00);
  static const Color greenBright = Color(0xFF33FF33);
  static const Color red = Color(0xFFFF5555);
  static const Color yellow = Color(0xFFFFFF55);
  static const Color cyan = Color(0xFF55FFFF);
  static const Color white = Color(0xFFCCCCCC);
  static const Color grey = Color(0xFF888888);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Terminal',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: TerminalColors.background,
        colorScheme: ColorScheme.dark(
          primary: TerminalColors.green,
          secondary: TerminalColors.greenDim,
          surface: TerminalColors.surface,
          onPrimary: TerminalColors.background,
          onSecondary: TerminalColors.background,
          onSurface: TerminalColors.green,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: TerminalColors.surface,
          foregroundColor: TerminalColors.green,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'monospace',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: TerminalColors.green,
          ),
          iconTheme: IconThemeData(color: TerminalColors.green),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
          bodyMedium: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
          bodySmall: TextStyle(fontFamily: 'monospace', color: TerminalColors.greenDim),
          titleLarge: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
          titleMedium: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
          labelLarge: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
        ),
        iconTheme: const IconThemeData(color: TerminalColors.green),
        listTileTheme: const ListTileThemeData(
          textColor: TerminalColors.green,
          iconColor: TerminalColors.green,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: TerminalColors.surface,
            foregroundColor: TerminalColors.green,
            side: const BorderSide(color: TerminalColors.green),
            textStyle: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: TerminalColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: TerminalColors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: TerminalColors.greenDim),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: TerminalColors.green, width: 2),
          ),
          hintStyle: const TextStyle(fontFamily: 'monospace', color: TerminalColors.grey),
          labelStyle: const TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: TerminalColors.surface,
          contentTextStyle: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: TerminalColors.surface,
          titleTextStyle: TextStyle(fontFamily: 'monospace', color: TerminalColors.green, fontSize: 18),
          contentTextStyle: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: TerminalColors.surface,
          textStyle: TextStyle(fontFamily: 'monospace', color: TerminalColors.green),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: TerminalColors.green,
        ),
        useMaterial3: true,
      ),
      home: const DevicesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
