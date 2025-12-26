import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_palette_generator/controllers/gradient_favorites_controller.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/models/gradient_alignment_type.dart';
import 'package:ai_palette_generator/models/gradient_palette.dart';

class GradientGeneratorScreen extends ConsumerStatefulWidget {
  final GradientPalette? existingGradient;

  const GradientGeneratorScreen({super.key, this.existingGradient});

  @override
  ConsumerState<GradientGeneratorScreen> createState() =>
      _GradientGeneratorScreenState();
}

class _GradientGeneratorScreenState
    extends ConsumerState<GradientGeneratorScreen> {
  late List<Color> _gradientColors;
  late GradientAlignmentType _alignmentType;
  late String _gradientId;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingGradient != null) {
      final gradient = widget.existingGradient!;
      _gradientColors = List.from(gradient.colors);
      _alignmentType = gradient.alignmentType;
      _gradientId = gradient.id;
    } else {
      _gradientColors = [Colors.deepPurple, Colors.pinkAccent];
      _alignmentType = GradientAlignmentType.linearLeftRight;
      _gradientId = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    final isFav = ref
        .read(gradientFavoritesProvider.notifier)
        .isFavorite(_gradientId);
    if (mounted && isFav != _isFavorite) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  void _toggleFavorite() {
    final notifier = ref.read(gradientFavoritesProvider.notifier);
    if (_isFavorite) {
      notifier.removeGradient(_gradientId);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("تم الحذف من المفضلة")));
    } else {
      final newGradient = GradientPalette(
        id: _gradientId,
        colors: _gradientColors,
        alignmentType: _alignmentType,
      );
      notifier.addGradient(newGradient);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocal.of(context).gradientSaved)),
      );
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gradientScreenTitle),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.redAccent : null,
            ),
            tooltip: l10n.gradientSave,
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: l10n.gradientCopyCode,
            onPressed: _copyCssCode,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: _buildGradient(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.cardColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.gradientAlignment,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<GradientAlignmentType>(
                    value: _alignmentType,
                    items: GradientAlignmentType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_translateAlignment(type, l10n)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() => _alignmentType = newValue);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                  ),
                  const Divider(height: 32),
                  Text(l10n.gradientColors, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _gradientColors.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _gradientColors.length) {
                          return _buildAddColorButton();
                        }
                        return _buildColorBox(index, l10n);
                      },
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

  Future<void> _editColor(int index) async {
    final Color newColor = await showColorPickerDialog(
      context,
      _gradientColors[index],
    );
    if (mounted) {
      setState(() {
        final updatedColors = List<Color>.from(_gradientColors);
        updatedColors[index] = newColor;
        _gradientColors = updatedColors;
      });
    }
  }

  Future<void> _addNewColor() async {
    final Color newColor = await showColorPickerDialog(context, Colors.green);
    if (mounted) {
      setState(() {
        _gradientColors = [..._gradientColors, newColor];
      });
    }
  }

  void _copyCssCode() {
    final colorsString = _gradientColors.map((c) => '#${c.hex}').join(', ');
    String cssCode;
    if (_alignmentType == GradientAlignmentType.radial) {
      cssCode = 'background: radial-gradient(circle, $colorsString);';
    } else {
      String direction = 'to right';
      switch (_alignmentType) {
        case GradientAlignmentType.linearTopBottom:
          direction = 'to bottom';
          break;
        case GradientAlignmentType.linearTopLeftBottomRight:
          direction = 'to bottom right';
          break;
        case GradientAlignmentType.linearBottomLeftTopRight:
          direction = 'to top right';
          break;
        default:
          direction = 'to right';
      }
      cssCode = 'background: linear-gradient($direction, $colorsString);';
    }
    Clipboard.setData(ClipboardData(text: cssCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocal.of(context).gradientCodeCopied)),
    );
  }

  Gradient _buildGradient() {
    switch (_alignmentType) {
      case GradientAlignmentType.radial:
        return RadialGradient(colors: _gradientColors);
      case GradientAlignmentType.linearTopBottom:
        return LinearGradient(
          colors: _gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientAlignmentType.linearTopLeftBottomRight:
        return LinearGradient(
          colors: _gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientAlignmentType.linearBottomLeftTopRight:
        return LinearGradient(
          colors: _gradientColors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        );
      case GradientAlignmentType.linearLeftRight:
        return LinearGradient(
          colors: _gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    }
  }

  String _translateAlignment(GradientAlignmentType type, AppLocal l10n) {
    switch (type) {
      case GradientAlignmentType.radial:
        return l10n.alignRadial;
      case GradientAlignmentType.linearLeftRight:
        return l10n.alignLinearLeftRight;
      case GradientAlignmentType.linearTopBottom:
        return l10n.alignLinearTopBottom;
      case GradientAlignmentType.linearTopLeftBottomRight:
        return l10n.alignLinearTopLeftBottomRight;
      case GradientAlignmentType.linearBottomLeftTopRight:
        return l10n.alignLinearBottomLeftTopRight;
    }
  }

  Widget _buildColorBox(int index, AppLocal l10n) {
    return GestureDetector(
      onTap: () => _editColor(index),
      child: Container(
        width: 60,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: _gradientColors[index],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30),
        ),
        child: Stack(
          children: [
            if (_gradientColors.length > 2)
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => setState(() {
                    final updatedColors = List<Color>.from(_gradientColors);
                    updatedColors.removeAt(index);
                    _gradientColors = updatedColors;
                  }),
                  tooltip: l10n.gradientRemoveColor,
                ),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.copy, color: Colors.white, size: 16),
                onPressed: () {
                  final hexCode = '#${_gradientColors[index].hex}';
                  Clipboard.setData(ClipboardData(text: hexCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${l10n.copiedMessage}$hexCode')),
                  );
                },
                tooltip: l10n.copiedMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddColorButton() {
    return GestureDetector(
      onTap: _addNewColor,
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white38),
        ),
        child: const Icon(Icons.add, color: Colors.white70),
      ),
    );
  }
}
