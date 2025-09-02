import 'package:ai_palette_generator/models/gradient_alignment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:ai_palette_generator/models/gradient_palette.dart';

class FavoriteGradientCard extends StatelessWidget {
  final GradientPalette gradient;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const FavoriteGradientCard({
    super.key,
    required this.gradient,
    required this.onTap,
    required this.onRemove,
  });

  Gradient _buildGradient() {
    switch (gradient.alignmentType) {
      case GradientAlignmentType.radial:
        return RadialGradient(colors: gradient.colors);
      case GradientAlignmentType.linearTopBottom:
        return LinearGradient(
          colors: gradient.colors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case GradientAlignmentType.linearTopLeftBottomRight:
        return LinearGradient(
          colors: gradient.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case GradientAlignmentType.linearBottomLeftTopRight:
        return LinearGradient(
          colors: gradient.colors,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        );
      case GradientAlignmentType.linearLeftRight:
      return LinearGradient(
          colors: gradient.colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
    }
  }

  void _copyCssCode(BuildContext context) {
    final l10n = AppLocal.of(context);
    final colorsString = gradient.colors.map((c) => '#${c.value.toRadixString(16).substring(2)}').join(', ');
    String cssCode;

    if (gradient.alignmentType == GradientAlignmentType.radial) {
      cssCode = 'background: radial-gradient(circle, $colorsString);';
    } else {
      String direction = 'to right'; 
      switch (gradient.alignmentType) {
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
          break;
      }
      cssCode = 'background: linear-gradient($direction, $colorsString);';
    }

    Clipboard.setData(ClipboardData(text: cssCode));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.gradientCodeCopied)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocal.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: _buildGradient(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: theme.cardColor.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.gradientType, 
                    style: theme.textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.code, size: 20),
                        tooltip: l10n.gradientCopyCode,
                        onPressed: () => _copyCssCode(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 20),
                        tooltip: l10n.removeFavoriteTooltip,
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
