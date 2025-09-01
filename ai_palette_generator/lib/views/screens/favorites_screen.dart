import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/views/widgets/favorite_palette_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocal.of(context);
    final favoritePalettes = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFavorites),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: favoritePalettes.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      size: 80,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.favoritesEmptyTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.favoritesEmptySubtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoritePalettes.length,
              itemBuilder: (context, index) {
                final palette = favoritePalettes[index];
                return FavoritePaletteCard(
                  palette: palette,
                  onRemove: () {
                    ref
                        .read(favoritesProvider.notifier)
                        .removePalette(palette.id);
                  },
                );
              },
            ),
    );
  }
}
