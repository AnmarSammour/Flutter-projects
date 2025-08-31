import 'package:ai_palette_generator/models/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoritePaletteCard extends StatelessWidget {
  final ColorPalette palette;
  final VoidCallback onRemove;

  const FavoritePaletteCard({
    super.key,
    required this.palette,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias, // لضمان أن المحتوى يتبع الحواف الدائرية
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شريط الألوان
          SizedBox(
            height: 80,
            child: Row(
              children: palette.colors.map((color) {
                return Expanded(
                  child: Container(color: color),
                );
              }).toList(),
            ),
          ),
          // تفاصيل اللوحة
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // أكواد HEX
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: palette.colors.map((color) {
                      final hexCode = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                      return InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: hexCode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم نسخ: $hexCode')),
                          );
                        },
                        child: Text(
                          hexCode,
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // زر الحذف
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                  onPressed: onRemove,
                  tooltip: 'إزالة من المفضلة',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
