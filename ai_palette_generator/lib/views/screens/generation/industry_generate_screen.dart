import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/palette_generator_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/models/industry_type.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndustryGenerateScreen extends ConsumerStatefulWidget {
  const IndustryGenerateScreen({super.key});

  @override
  ConsumerState<IndustryGenerateScreen> createState() =>
      _IndustryGenerateScreenState();
}

class _IndustryGenerateScreenState
    extends ConsumerState<IndustryGenerateScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(paletteGeneratorProvider.notifier)
          .generatePaletteForIndustry(IndustryType.tech);
    });
  }

  String _translateIndustry(AppLocal l10n, IndustryType type) {
    switch (type) {
      case IndustryType.islamic:
        return l10n.industryIslamic;
      case IndustryType.educational:
        return l10n.industryEducational;
      case IndustryType.banking:
        return l10n.industryBanking;
      case IndustryType.tech:
        return l10n.industryTech;
      case IndustryType.health:
        return l10n.industryHealth;
      case IndustryType.food:
        return l10n.industryFood;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final paletteState = ref.watch(paletteGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeIndustryGeneratorTitle),
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
            child: DropdownButtonFormField<IndustryType>(
              value: paletteState.asData?.value.name != null
                  ? IndustryType.values.firstWhere(
                      (e) => e.name == paletteState.asData!.value.name,
                      orElse: () => IndustryType.tech)
                  : IndustryType.tech,
              hint: Text(l10n.industryHintText),
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: IndustryType.values
                  .map((type) => DropdownMenuItem(
                      value: type, child: Text(_translateIndustry(l10n, type))))
                  .toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  ref
                      .read(paletteGeneratorProvider.notifier)
                      .generatePaletteForIndustry(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
