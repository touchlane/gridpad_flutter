import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color heatWave = Color(0xFFFF7900);
const Color barneyPurple = Color(0xFF990099);
const Color aswadBlack = Color(0xFF16181c);
const Color andreaBlue = Color(0xFF4175e2);

const Color white = Color(0xFFFFFFFF);

const Color babyBlueEyes = Color(0XFF9CCAFF);
const Color lightSteelBlue = Color(0XFFBAC8DB);
const Color melon = Color(0XFFFFB4A5);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0062A1),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD0E4FF),
  onPrimaryContainer: Color(0xFF001D35),
  secondary: Color(0xFF00629F),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD0E4FF),
  onSecondaryContainer: Color(0xFF001D34),
  tertiary: Color(0xFF9C4331),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD3),
  onTertiaryContainer: Color(0xFF3F0400),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFBFF),
  onBackground: Color(0xFF1A1C1E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF9CCAFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF0062A1),
  surface: Color(0xFFFAF9FD),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE3EB),
  onSurfaceVariant: Color(0xFF42474E),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF9CCAFF),
  onPrimary: Color(0xFF003257),
  primaryContainer: Color(0xFF00497B),
  onPrimaryContainer: Color(0xFFD0E4FF),
  secondary: Color(0xFF9BCBFF),
  onSecondary: Color(0xFF003256),
  secondaryContainer: Color(0xFF004A7A),
  onSecondaryContainer: Color(0xFFD0E4FF),
  tertiary: Color(0xFFFFB4A5),
  onTertiary: Color(0xFF5F1609),
  tertiaryContainer: Color(0xFF7D2C1D),
  onTertiaryContainer: Color(0xFFFFDAD3),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE3E2E6),
  outline: Color(0xFF8C9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE3E2E6),
  inversePrimary: Color(0xFF0062A1),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF9CCAFF),
  surface: Color(0xFF121316),
  onSurface: Color(0xFFC7C6CA),
  surfaceVariant: Color(0xFF42474E),
  onSurfaceVariant: Color(0xFFC2C7CF),
);

ThemeData lightThemeData = buildThemeData(lightColorScheme);

ThemeData darkThemeData = buildThemeData(darkColorScheme);

ThemeData buildThemeData(ColorScheme colorScheme) {
  //https://m3.material.io/styles/color/the-color-system/color-roles
  //https://m3.material.io/styles/typography/type-scale-tokens
  const level2Elevation = 2.0;
  final surface2Color = ElevationOverlay.applySurfaceTint(
    colorScheme.surface,
    colorScheme.surfaceTint,
    level2Elevation,
  );
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  ).copyWith(
    appBarTheme: AppBarTheme(
      elevation: level2Elevation,
      backgroundColor: colorScheme.surface,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorScheme.brightness.inverse(),
        statusBarBrightness: colorScheme.brightness,
      ),
    ),
    cardTheme: const CardTheme(color: Color(0xFF48454E)),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),
  );
}

extension BrightnessExtension on Brightness {
  Brightness inverse() {
    switch (this) {
      case Brightness.light:
        return Brightness.dark;
      case Brightness.dark:
        return Brightness.light;
    }
  }
}
