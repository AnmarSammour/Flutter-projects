import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/palette_generator_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
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
                _hexController.text =
                    '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              _generatePalette();
            },
          ),
        ],
      ),
    );
  }

  void _generatePalette() {
    final paletteNotifier = ref.read(paletteGeneratorProvider.notifier);
    if (_baseColor != null) {
      paletteNotifier.generatePaletteFromBase(_baseColor!, count: _colorCount);
    } else {
      paletteNotifier.generateRandomPalette(count: _colorCount);
    }
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paletteState = ref.watch(paletteGeneratorProvider);
    final l10n = AppLocal.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.generateScreenTitle),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          paletteState.when(
            data: (palette) => IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                ref.read(favoritesProvider.notifier).addPalette(palette);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(l10n.paletteSaved)));
              },
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: paletteState.when(
              data: (palette) => Column(
                children: palette.colors
                    .map((color) => ColorStrip(color: color))
                    .toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) =>
                  Center(child: Text(l10n.errorFailedToLoad)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _hexController,
                          decoration: InputDecoration(
                            labelText: l10n.baseColorLabel,
                            hintText: '#RRGGBB',
                            border: const OutlineInputBorder(),
                            prefixIcon: _baseColor != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: _baseColor,
                                      radius: 12,
                                    ),
                                  )
                                : null,
                          ),
                          onSubmitted: (value) {
                            try {
                              final color = Color(
                                int.parse(value.replaceFirst('#', '0xff')),
                              );
                              setState(() {
                                _baseColor = color;
                              });
                              _generatePalette();
                            } catch (e) {}
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.color_lens_outlined),
                        onPressed: _openColorPicker,
                        tooltip: l10n.pickColorButton,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.colorCountLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      DropdownButton<int>(
                        value: _colorCount,
                        items: [2, 3, 4, 5].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              _colorCount = newValue;
                            });
                            _generatePalette();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _generatePalette,
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.refreshButton),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
