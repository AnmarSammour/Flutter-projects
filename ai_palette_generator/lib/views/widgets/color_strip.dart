import 'package:ai_palette_generator/localization/app_local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColorStrip extends StatelessWidget {
  final Color color;

  const ColorStrip({super.key, required this.color});

  String _toHexString(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final hexCode = _toHexString(color);
    final l10n = AppLocal.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: hexCode));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${l10n.copiedToClipboard}$hexCode')),
          );
        },
        child: Container(
          color: color,
          child: Center(
            child: Text(
              hexCode,
              style: TextStyle(
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
