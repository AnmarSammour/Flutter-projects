import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:ai_palette_generator/services/ai_palette_service.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DesignContext { app, logo, painting, other }

final aiPaletteProvider =
    StateNotifierProvider.autoDispose<
      AiPaletteNotifier,
      AsyncValue<List<ColorAnalysis>>
    >((ref) {
      return AiPaletteNotifier();
    });

class AiPaletteNotifier extends StateNotifier<AsyncValue<List<ColorAnalysis>>> {
  AiPaletteNotifier() : super(const AsyncValue.data([]));

  Future<void> generate({
    required String description,
    required int count,
    required BuildContext context,
    required DesignContext designContext,
  }) async {
    if (description.trim().isEmpty) return;
    state = const AsyncValue.loading();
    final languageCode = Localizations.localeOf(context).languageCode;
    try {
      final result = await AiPaletteService().getPaletteFromDescription(
        description: description,
        colorCount: count,
        languageCode: languageCode,
        designContext: designContext.name,
      );
      state = AsyncValue.data(result);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

class AiGenerateScreen extends ConsumerStatefulWidget {
  const AiGenerateScreen({super.key});

  @override
  ConsumerState<AiGenerateScreen> createState() => _AiGenerateScreenState();
}

class _AiGenerateScreenState extends ConsumerState<AiGenerateScreen> {
  final _descriptionController = TextEditingController();
  final _colorCountController = TextEditingController(text: '5');
  DesignContext _selectedContext = DesignContext.app;

  @override
  void dispose() {
    _descriptionController.dispose();
    _colorCountController.dispose();
    super.dispose();
  }

  String _translateContext(AppLocal l10n, DesignContext context) {
    switch (context) {
      case DesignContext.app:
        return l10n.contextApp;
      case DesignContext.logo:
        return l10n.contextLogo;
      case DesignContext.painting:
        return l10n.contextPainting;
      case DesignContext.other:
        return l10n.contextOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final paletteState = ref.watch(aiPaletteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAiGeneratorTitle),
        actions: [
          paletteState.maybeWhen(
            data: (data) => data.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.favorite_border),
                    tooltip: l10n.savePaletteButton,
                    onPressed: () {
                      final palette = ColorPalette(
                        id: DateTime.now().toIso8601String(),
                        colors: data.map((e) => e.color).toList(),
                        name: _descriptionController.text,
                      );
                      ref.read(favoritesProvider.notifier).addPalette(palette);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.paletteSaved)),
                      );
                    },
                  )
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<DesignContext>(
                  value: _selectedContext,
                  items: DesignContext.values
                      .map(
                        (context) => DropdownMenuItem(
                          value: context,
                          child: Text(_translateContext(l10n, context)),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedContext = newValue;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: l10n.designContextLabel,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: l10n.aiDescriptionLabel,
                    hintText: l10n.aiDescriptionHint,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _colorCountController,
                        decoration: InputDecoration(
                          labelText: l10n.colorCountLabel,
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.auto_awesome),
                        label: Text(l10n.generateButton),
                        onPressed: () {
                          final count =
                              int.tryParse(_colorCountController.text) ?? 5;
                          ref
                              .read(aiPaletteProvider.notifier)
                              .generate(
                                description: _descriptionController.text,
                                count: count,
                                context: context,
                                designContext: _selectedContext,
                              );
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: paletteState.when(
              data: (analysisList) {
                if (analysisList.isEmpty) {
                  return Center(child: Text(l10n.aiScreenInitialText));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: analysisList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    final analysis = analysisList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColorStrip(color: analysis.color),
                        const SizedBox(height: 8),
                        Text(
                          analysis.name,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          analysis.usageSuggestion,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
    );
  }
}
