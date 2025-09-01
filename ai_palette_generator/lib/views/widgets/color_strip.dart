import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_palette_generator/localization/app_local.dart';

class ColorStrip extends StatelessWidget {
  final Color color;
  final double? height; // جعله اختيارياً

  const ColorStrip({super.key, required this.color, this.height});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocal.of(context);
    final hexCode =
        '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
    final textColor = color.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

    // --- التصحيح: إزالة Expanded ---
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hexCode));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.copiedMessage}$hexCode'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        height: height, // استخدام الارتفاع إذا تم تحديده
        width: double.infinity, // تأكد من أنه يملأ العرض
        color: color,
        child: Center(
          child: Text(
            hexCode,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              shadows: const [
                Shadow(
                  blurRadius: 1.0,
                  color: Colors.black26,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
