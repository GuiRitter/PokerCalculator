import 'package:flutter/material.dart'
    show
        AppBarTheme,
        Brightness,
        BuildContext,
        Color,
        ColorScheme,
        MaterialColor,
        ThemeData;

ThemeData dark({
  required BuildContext context,
}) =>
    ThemeData.dark(
      useMaterial3: false,
    ).copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          const Color(
            // Arylide yellow, to contrast with the suit's colors and desaturated to not stand out too much
            0xFFE9D66B, // WebAIM: 424242 background, this foreground
          ).value,
          // https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
          // Drab dark brown (4A412A), gives the palette with a somewhat desaturated yellow that doesn't turn into orange while being slightly orangish
          const {
            50: Color(
              0xFFfff9dc,
            ),
            100: Color(
              0xFFfff4d7,
            ),
            200: Color(
              0xFFfaedd0,
            ),
            300: Color(
              0xFFecdfc2,
            ),
            400: Color(
              0xFFc8bca0,
            ),
            500: Color(
              0xFFa99d82,
            ),
            600: Color(
              0xFF7f745b,
            ),
            700: Color(
              0xFF6a6047,
            ),
            800: Color(
              0xFF4a412a,
            ),
            900: Color(
              0xFF282008,
            ),
          },
        ),
        accentColor: const Color(
          // Royal Purple, brighter in order to fit
          0xFF8E6BB8, // WebAIM: 303030 background, this foreground, Contrast Ratio 3 (Graphical Objects and User Interface Components)
        ),
        backgroundColor: const Color(
          0xFF121212,
        ),
        brightness: Brightness.dark,
        cardColor: const Color(
          0xFF121212,
        ),
        errorColor: const Color(
          0xFFCF6679,
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: Color(
          // Same as 800 above
          0xFF6a6047, // WebAIM: this background, white foreground
        ),
      ),
    );
