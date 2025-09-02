import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:ai_palette_generator/models/gradient_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/gradient_favorites_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/views/screens/gradient_generator_screen.dart';
import 'package:ai_palette_generator/views/widgets/favorite_palette_card.dart';
import 'package:ai_palette_generator/views/widgets/favorite_gradient_card.dart'; 
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final favoritePalettes = ref.watch(favoritesProvider);
    final favoriteGradients = ref.watch(gradientFavoritesProvider);

    final allFavorites = [...favoritePalettes, ...favoriteGradients];
    allFavorites.sort((a, b) {
      String aId = (a is ColorPalette)
          ? a.id
          : (a is GradientPalette)
          ? a.id
          : '';
      String bId = (b is ColorPalette)
          ? b.id
          : (b is GradientPalette)
          ? b.id
          : '';
      return bId.compareTo(aId);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFavorites),
      ),
      body: allFavorites.isEmpty
          ? Center()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: allFavorites.length,
              itemBuilder: (context, index) {
                final item = allFavorites[index];

                if (item is ColorPalette) {
                  return FavoritePaletteCard(
                    palette: item,
                    onRemove: () => ref
                        .read(favoritesProvider.notifier)
                        .removePalette(item.id),
                  );
                } else if (item is GradientPalette) {
                  return FavoriteGradientCard(
                    gradient: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              GradientGeneratorScreen(existingGradient: item),
                        ),
                      );
                    },
                    onRemove: () => ref
                        .read(gradientFavoritesProvider.notifier)
                        .removeGradient(item.id),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }
}
