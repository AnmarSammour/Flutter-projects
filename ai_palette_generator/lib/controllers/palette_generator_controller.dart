import 'dart:convert';
import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// 1. Provider to manage the state.
final paletteGeneratorProvider =
    StateNotifierProvider<PaletteGeneratorNotifier, AsyncValue<ColorPalette>>((
      ref,
    ) {
      return PaletteGeneratorNotifier();
    });

// 2. The State Notifier (the actual controller).
class PaletteGeneratorNotifier extends StateNotifier<AsyncValue<ColorPalette>> {
  // The initial state is 'loading', then the function to fetch data is called.
  PaletteGeneratorNotifier() : super(const AsyncValue.loading()) {
    generateRandomPalette();
  }

  // Helper function to convert an RGB list to a Color object.
  Color _colorFromRgb(List<dynamic> rgb) {
    return Color.fromRGBO(rgb[0], rgb[1], rgb[2], 1.0);
  }

  //Convert a Color object to an RGB list
  List<int> _colorToRgb(Color color) {
    return [color.red, color.green, color.blue];
  }

  // Fetch a random color palette from the API.
  Future<void> generateRandomPalette({int count = 5}) async {
    state = const AsyncValue.loading(); // Show a loading state to the user.
    try {
      final url = Uri.parse('http://colormind.io/api/');
      final body = json.encode({'model': 'default'});

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> colorsRgb = json.decode(response.body)['result'];
        final List<Color> colors = colorsRgb
            .map((rgb) => _colorFromRgb(rgb))
            .toList();

        // The Colormind API always returns 5 colors, so we take only the required number.
        final finalColors = colors.take(count).toList();

        // Update the state with the new data.
        state = AsyncValue.data(
          ColorPalette(
            id: DateTime.now().toIso8601String(),
            colors: finalColors,
          ),
        );
      } else {
        // Handle cases where the request fails (e.g., a 500 error).
        throw Exception('Failed to load palette from API');
      }
    } catch (e, s) {
      // Handle any other errors (e.g., no internet connection).
      state = AsyncValue.error(e, s);
    }
  }

  Future<void> generatePaletteFromBase(Color baseColor, {int count = 5}) async {
    state = const AsyncValue.loading();
    try {
      final url = Uri.parse('http://colormind.io/api/');
      final List<dynamic> input = [_colorToRgb(baseColor), "N", "N", "N", "N"];

      final body = json.encode({'model': 'default', 'input': input});

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final List<dynamic> colorsRgb = json.decode(response.body)['result'];
        final List<Color> colors = colorsRgb
            .map((rgb) => _colorFromRgb(rgb))
            .toList();

        final finalColors = colors.take(count).toList();

        state = AsyncValue.data(
          ColorPalette(
            id: DateTime.now().toIso8601String(),
            colors: finalColors,
          ),
        );
      } else {
        throw Exception('Failed to load palette from API');
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
