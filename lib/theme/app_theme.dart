import 'package:flutter/material.dart';

/// Colores y estilos extraídos del diseño (Diseño.pen)
class AppColors {
  static const primary = Color(0xFF4F46E5);
  static const primarySoft = Color(0xFF3A32A0);
  static const primaryLight = Color(0xFFA5B4FC);
  static const bg = Color(0xFF231C6B);
  static const surface = Color(0xFF2E2789);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFC5BFEE);
  static const textTertiary = Color(0xFF948CCB);
  static const border = Color(0xFF443BA5);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const danger = Color(0xFFEF4444);
  static const favorite = Color(0xFFF43F5E);

  // Colores por categoría
  static const catFlutter = Color(0xFF0553B1);
  static const catAndroid = Color(0xFF1DA260);
  static const catLayouts = Color(0xFFF59E0B);
  static const catScrollables = Color(0xFFDB2777);
  static const catSlivers = Color(0xFF7C3AED);
  static const catNavegacion = Color(0xFFDC2626);

  static Color forCategory(String category) {
    switch (category) {
      case 'Flutter':
        return catFlutter;
      case 'Android':
        return catAndroid;
      case 'Layouts':
        return catLayouts;
      case 'Scrollables':
        return catScrollables;
      case 'Slivers':
        return catSlivers;
      case 'Navegacion':
        return catNavegacion;
      default:
        return primary;
    }
  }
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      fontFamily: 'Roboto', // cambia a 'Inter' si agregas google_fonts
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.textTertiary, fontSize: 12),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
