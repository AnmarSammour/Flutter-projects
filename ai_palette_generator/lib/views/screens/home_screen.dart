import 'package:ai_palette_generator/views/widgets/option_card.dart';
import 'package:flutter/material.dart';
import 'package:ai_palette_generator/localization/app_local.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  l10n.appTitle,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children: [
                    OptionCard(
                      title: l10n.homeGeneratePaletteTitle,
                      subtitle: l10n.homeGeneratePaletteSubtitle,
                      icon: Icons.palette_outlined,
                      color: Colors.blueAccent,
                      onTap: () {},
                    ),
                    OptionCard(
                      title: l10n.homeUploadImageTitle,
                      subtitle: l10n.homeUploadImageSubtitle,
                      icon: Icons.image_outlined,
                      color: Colors.greenAccent,
                      onTap: () {},
                    ),
                    OptionCard(
                      title: l10n.homeFavoritesTitle,
                      subtitle: l10n.homeFavoritesSubtitle,
                      icon: Icons.favorite_border,
                      color: Colors.redAccent,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
