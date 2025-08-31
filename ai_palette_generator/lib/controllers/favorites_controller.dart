import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ColorPalette>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<ColorPalette>> {
  FavoritesNotifier() : super([]);

  void addPalette(ColorPalette palette) {
    state = [palette, ...state];
  }

  void removePalette(String paletteId) {
    state = state.where((p) => p.id != paletteId).toList();
  }
}
