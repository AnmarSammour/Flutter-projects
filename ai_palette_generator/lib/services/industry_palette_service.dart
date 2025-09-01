import 'package:ai_palette_generator/models/industry_type.dart';
import 'package:flutter/material.dart';
import 'package:ai_palette_generator/models/color_palette.dart';

class IndustryPaletteService {
  static ColorPalette getPaletteForIndustry(IndustryType type) {
    List<Color> colors;

    switch (type) {
      case IndustryType.islamic:
        colors = [
          const Color(0xFF00695C),
          const Color(0xFFD4AF37),
          const Color(0xFFF5F5DC),
          const Color(0xFF4DB6AC),
          const Color(0xFF263238),
        ];
        break;
      case IndustryType.educational:
        colors = [
          const Color(0xFFF44336),
          const Color(0xFF2196F3),
          const Color(0xFFFFEB3B),
          const Color(0xFF4CAF50),
          const Color(0xFFFFFFFF),
        ];
        break;
      case IndustryType.banking:
        colors = [
          const Color(0xFF0D47A1),
          const Color(0xFF1976D2),
          const Color(0xFFCFD8DC),
          const Color(0xFFFFC107),
          const Color(0xFF424242),
        ];
        break;
      case IndustryType.tech:
        colors = [
          const Color(0xFF3F51B5),
          const Color(0xFF00BCD4),
          const Color(0xFF1A1A2E),
          const Color(0xFFE94560),
          const Color(0xFFFFFFFF),
        ];
        break;
      case IndustryType.health:
        colors = [
          const Color(0xFF00796B),
          const Color(0xFF4FC3F7),
          const Color(0xFFE0F7FA),
          const Color(0xFF81C784),
          const Color(0xFF37474F),
        ];
        break;
      case IndustryType.food:
        colors = [
          const Color(0xFFD32F2F),
          const Color(0xFFFFA000),
          const Color(0xFFFFF8E1),
          const Color(0xFF795548),
          const Color(0xFF4E342E),
        ];
        break;
    }

    return ColorPalette(
      id: 'industry_${type.name}_${DateTime.now().millisecondsSinceEpoch}',
      colors: colors,
      name: type.name,
    );
  }
}
