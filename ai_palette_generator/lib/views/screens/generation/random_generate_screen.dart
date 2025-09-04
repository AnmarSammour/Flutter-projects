import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/palette_generator_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomGenerateScreen extends ConsumerStatefulWidget {
  const RandomGenerateScreen({super.key});

  @override
  ConsumerState<RandomGenerateScreen> createState() =>
      _RandomGenerateScreenState();
}

class _RandomGenerateScreenState extends ConsumerState<RandomGenerateScreen> {
  int _colorCount = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(paletteGeneratorProvider.notifier)
          .generateRandomPalette(count: _colorCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final paletteState = ref.watch(paletteGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeRandomGeneratorTitle),
        actions: [
          paletteState.maybeWhen(
            data: (palette) => IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: l10n.savePaletteButton,
              onPressed: () {
                ref.read(favoritesProvider.notifier).addPalette(palette);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(l10n.paletteSaved)));
              },
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: paletteState.when(
              data: (palette) => Column(
                children: palette.colors
                    .map((c) => Expanded(child: ColorStrip(color: c)))
                    .toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<int>(
                    value: _colorCount,
                    items: [2, 3, 4, 5] 
                        .map((v) =>
                            DropdownMenuItem(value: v, child: Text(v.toString())))
                        .toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          _colorCount = newValue;
                        });
                        ref
                            .read(paletteGeneratorProvider.notifier)
                            .generateRandomPalette(count: newValue);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: l10n.colorCountLabel,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.shuffle),
                    label: Text(l10n.refreshButton),
                    onPressed: () {
                      ref
                          .read(paletteGeneratorProvider.notifier)
                          .generateRandomPalette(count: _colorCount);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
