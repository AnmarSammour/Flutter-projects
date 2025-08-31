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
    // مشاهدة قائمة المفضلة
    final favoritePalettes = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navFavorites),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: favoritePalettes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 16),
                  Text(
                    'لم تقم بحفظ أي لوحات بعد', // سيتم ترجمتها لاحقاً
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
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
                    // استدعاء دالة الحذف من الـ controller
                    ref.read(favoritesProvider.notifier).removePalette(palette.id);
                  },
                );
              },
            ),
    );
  }
}
