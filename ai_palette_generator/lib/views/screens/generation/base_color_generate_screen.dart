import 'package:ai_palette_generator/controllers/favorites_controller.dart';
import 'package:ai_palette_generator/controllers/palette_generator_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/views/widgets/color_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseColorGenerateScreen extends ConsumerStatefulWidget {
  const BaseColorGenerateScreen({super.key});

  @override
  ConsumerState<BaseColorGenerateScreen> createState() =>
      _BaseColorGenerateScreenState();
}

class _BaseColorGenerateScreenState
    extends ConsumerState<BaseColorGenerateScreen> {
  int _colorCount = 5;
  Color _baseColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generate();
    });
  }

  void _generate() {
    ref
        .read(paletteGeneratorProvider.notifier)
        .generatePaletteFromBase(_baseColor, count: _colorCount);
  }

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocal.of(context).pickColorButton),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _baseColor,
            onColorChanged: (color) => setState(() => _baseColor = color),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              _generate();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final paletteState = ref.watch(paletteGeneratorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeBaseColorGeneratorTitle),
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
                        _generate(); 
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
                  child: InkWell(
                    onTap: _openColorPicker,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: _baseColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white54),
                      ),
                      child: Center(
                        child: Text(
                          l10n.pickColorButton,
                          style: TextStyle(
                            color: _baseColor.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
