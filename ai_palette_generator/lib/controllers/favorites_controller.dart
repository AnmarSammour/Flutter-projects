import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ai_palette_generator/models/color_palette.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<ColorPalette>>((ref) {
      return FavoritesNotifier();
    });

class FavoritesNotifier extends StateNotifier<List<ColorPalette>> {

  final Box<ColorPalette> _favoritesBox = Hive.box<ColorPalette>(
    'palettes_box',
  );

  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  void _loadFavorites() {
    state = _favoritesBox.values.toList()..sort((a, b) => b.id.compareTo(a.id));
  }

  Future<void> addPalette(ColorPalette palette) async {
    await _favoritesBox.put(palette.id, palette);
    _loadFavorites();
  }

  Future<void> removePalette(String paletteId) async {
    await _favoritesBox.delete(paletteId);
    _loadFavorites();
  }

  bool isFavorite(String paletteId) {
    return _favoritesBox.containsKey(paletteId);
  }
}
