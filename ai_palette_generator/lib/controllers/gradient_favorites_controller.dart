import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ai_palette_generator/models/gradient_palette.dart';

final gradientFavoritesProvider =
    StateNotifierProvider<GradientFavoritesNotifier, List<GradientPalette>>((
      ref,
    ) {
      return GradientFavoritesNotifier();
    });

class GradientFavoritesNotifier extends StateNotifier<List<GradientPalette>> {
  final Box<GradientPalette> _box = Hive.box<GradientPalette>('gradients_box');

  GradientFavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  void _loadFavorites() {
    state = _box.values.toList()..sort((a, b) => b.id.compareTo(a.id));
  }

  Future<void> addGradient(GradientPalette gradient) async {
    await _box.put(gradient.id, gradient);
    _loadFavorites();
  }

  Future<void> removeGradient(String gradientId) async {
    await _box.delete(gradientId);
    _loadFavorites();
  }

  bool isFavorite(String gradientId) {
    return _box.containsKey(gradientId);
  }
}
