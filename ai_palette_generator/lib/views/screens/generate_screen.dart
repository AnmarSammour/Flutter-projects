import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/palette_generator_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/models/industry_type.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateScreen extends ConsumerStatefulWidget {
  const GenerateScreen({super.key});

  @override
  ConsumerState<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends ConsumerState<GenerateScreen> {
  int _colorCount = 5;
  Color? _baseColor;
  final TextEditingController _hexController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  IndustryType? _selectedIndustry;

  @override
  void dispose() {
    _hexController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocal.of(context).pickColorButton),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _baseColor ?? Colors.blue,
            onColorChanged: (color) {
              setState(() {
                _baseColor = color;
                _hexController.text = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              if (_baseColor != null) {
                ref.read(paletteGeneratorProvider.notifier).generatePaletteFromBase(_baseColor!, count: _colorCount);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paletteState = ref.watch(paletteGeneratorProvider);
    final l10n = AppLocal.of(context);

    // التصحيح: تمت إزالة الشرطة السفلية من اسم الدالة المحلية
    String translateIndustry(IndustryType type) {
      switch (type) {
        case IndustryType.islamic: return l10n.industryIslamic;
        case IndustryType.educational: return l10n.industryEducational;
        case IndustryType.banking: return l10n.industryBanking;
        case IndustryType.tech: return l10n.industryTech;
        case IndustryType.health: return l10n.industryHealth;
        case IndustryType.food: return l10n.industryFood;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.generateScreenTitle),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          paletteState.when(
            data: (palette) => IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: l10n.savePaletteButton,
              onPressed: () {
                ref.read(favoritesProvider.notifier).addPalette(palette);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.paletteSaved)));
              },
            ),
            loading: () => const Center(child: Padding(padding: EdgeInsets.all(16.0), child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)))),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: paletteState.when(
              data: (palette) => Column(children: palette.colors.map((c) => ColorStrip(color: c)).toList()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('${l10n.errorFailedToLoad}\n\n${err.toString()}', textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.colorCountLabel, style: Theme.of(context).textTheme.titleMedium),
                      DropdownButton<int>(
                        value: _colorCount,
                        items: [2, 3, 4, 5].map((v) => DropdownMenuItem(value: v, child: Text(v.toString()))).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) setState(() => _colorCount = newValue);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildControlPanel(l10n, translateIndustry),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel(AppLocal l10n, String Function(IndustryType) translate) {
    return Column(
      children: [
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: l10n.aiDescriptionLabel,
            hintText: l10n.aiDescriptionHint,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            icon: const Icon(Icons.auto_awesome),
            label: Text(l10n.generateFromDescription),
            onPressed: () {
              ref.read(paletteGeneratorProvider.notifier).generatePaletteFromText(
                _descriptionController.text,
                count: _colorCount,
              );
            },
          ),
        ),
        const Divider(height: 24, thickness: 1),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _hexController,
                decoration: InputDecoration(
                  labelText: l10n.baseColorLabel,
                  hintText: '#RRGGBB',
                  border: const OutlineInputBorder(),
                  prefixIcon: _baseColor != null ? Padding(padding: const EdgeInsets.all(8.0), child: CircleAvatar(backgroundColor: _baseColor, radius: 12)) : null,
                ),
                onSubmitted: (value) {
                  try {
                    final color = Color(int.parse(value.replaceFirst('#', '0xff')));
                    setState(() { _baseColor = color; });
                    ref.read(paletteGeneratorProvider.notifier).generatePaletteFromBase(color, count: _colorCount);
                  } catch (e) {/* ignore */}
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.color_lens_outlined), onPressed: _openColorPicker, tooltip: l10n.pickColorButton),
          ],
        ),
        const Divider(height: 24, thickness: 1),
        DropdownButtonFormField<IndustryType>(
          value: _selectedIndustry,
          hint: Text(l10n.industryHintText),
          isExpanded: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: IndustryType.values.map((type) => DropdownMenuItem(value: type, child: Text(translate(type)))).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() { _selectedIndustry = newValue; });
              ref.read(paletteGeneratorProvider.notifier).generatePaletteForIndustry(newValue);
            }
          },
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.shuffle),
            label: Text(l10n.refreshButton),
            onPressed: () {
              ref.read(paletteGeneratorProvider.notifier).generateRandomPalette(count: _colorCount);
            },
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
      ],
    );
  }
}