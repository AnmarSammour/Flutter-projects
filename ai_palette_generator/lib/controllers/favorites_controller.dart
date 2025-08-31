import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ColorPalette>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<ColorPalette>> {
  final Box<ColorPalette> _box;

  FavoritesNotifier() : _box = Hive.box<ColorPalette>('favorites'), super([]) {
    state = _box.values.toList().reversed.toList();
  }
  void addPalette(ColorPalette palette) {
    _box.put(palette.id, palette);
    state = [palette, ...state];
  }

  void removePalette(String paletteId) {
    _box.delete(paletteId);
    state = state.where((p) => p.id != paletteId).toList();
  }
}
