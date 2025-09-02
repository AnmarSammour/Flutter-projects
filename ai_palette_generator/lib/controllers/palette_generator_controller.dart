import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart'
    as http; 
import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:ai_palette_generator/models/industry_type.dart';
import 'package:ai_palette_generator/services/industry_palette_service.dart';
import 'package:ai_palette_generator/services/ai_palette_service.dart';

final paletteGeneratorProvider =
    StateNotifierProvider<PaletteGeneratorNotifier, AsyncValue<ColorPalette>>((
      ref,
    ) {
      return PaletteGeneratorNotifier();
    });

class PaletteGeneratorNotifier extends StateNotifier<AsyncValue<ColorPalette>> {
  final AiPaletteService _aiService = AiPaletteService();

  PaletteGeneratorNotifier() : super(const AsyncValue.loading()) {
    generateRandomPalette();
  }

  Color _colorFromRgb(List<dynamic> rgb) =>
      Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1.0);
  List<int> _colorToRgb(Color color) => [color.red, color.green, color.blue];

  Future<void> generateRandomPalette({int count = 5}) async {
    state = const AsyncValue.loading();
    try {
      final url = Uri.parse('http://colormind.io/api/');
      final body = json.encode({'model': 'default'});
      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> colorsRgb = json.decode(response.body)['result'];
        final List<Color> colors = colorsRgb
            .map((rgb) => _colorFromRgb(rgb))
            .toList();
        state = AsyncValue.data(
          ColorPalette(
            id: DateTime.now().toIso8601String(),
            colors: colors.take(count).toList(),
          ),
        );
      } else {
        throw Exception('Failed to load palette from Colormind API');
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> generatePaletteFromBase(Color baseColor, {int count = 5}) async {
    state = const AsyncValue.loading();
    try {
      final url = Uri.parse('http://colormind.io/api/');
      final input = [_colorToRgb(baseColor), "N", "N", "N", "N"];
      final body = json.encode({'model': 'default', 'input': input});
      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> colorsRgb = json.decode(response.body)['result'];
        final List<Color> colors = colorsRgb
            .map((rgb) => _colorFromRgb(rgb))
            .toList();
        state = AsyncValue.data(
          ColorPalette(
            id: DateTime.now().toIso8601String(),
            colors: colors.take(count).toList(),
          ),
        );
      } else {
        throw Exception('Failed to load palette from Colormind API');
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  void generatePaletteForIndustry(IndustryType type) {
    state = const AsyncValue.loading();
    try {
      final palette = IndustryPaletteService.getPaletteForIndustry(type);
      state = AsyncValue.data(palette);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> generatePaletteFromText(
    String description, {
    int count = 5,
  }) async {
    if (description.trim().isEmpty) {
      await generateRandomPalette(count: count);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final colors = await _aiService.getPaletteFromDescription(
        description,
        count,
      );
      state = AsyncValue.data(
        ColorPalette(
          id: DateTime.now().toIso8601String(),
          colors: colors,
          name: description,
        ),
      );
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
