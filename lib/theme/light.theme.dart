import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        Color,
        Colors,
        ColorScheme,
        MaterialColor,
        ThemeData;

ThemeData light({
  required BuildContext context,
}) =>
    ThemeData.light(
      useMaterial3: false,
    ).copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          const Color(
            // Wenge, to contrast with the suit's colors and desaturated to not stand out too much
            0xFF645452, // WebAIM: white background, this foreground
            // ignore: deprecated_member_use
          ).value,
          // https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
          // Taupe (483C32), gives the palette with a somewhat desaturated brown
          const {
            50: Color(
              0xFFececec,
            ),
            100: Color(
              0xFFd0d0d0,
            ),
            200: Color(
              0xFFb0b0b0,
            ),
            300: Color(
              0xFF93908f,
            ),
            400: Color(
              0xFF827674,
            ),
            500: Color(
              0xFF715d5a,
            ),
            600: Color(
              0xFF645452,
            ),
            700: Color(
              0xFF544847,
            ),
            800: Color(
              0xFF443c3c,
            ),
            900: Color(
              0xFF342f2f,
            ),
          },
        ),
        accentColor: const Color(
          // Royal Purple
          0xFF7851A9, // WebAIM: FAFAFA background, this foreground, Contrast Ratio 3 (Graphical Objects and User Interface Components)
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        cardColor: Colors.white,
        errorColor: const Color(
          0xFFB00020,
        ),
      ),
    );
