import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 1; // أعطه ID فريد

  @override
  Color read(BinaryReader reader) {
    // اقرأ القيمة الرقمية للون
    final value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    // اكتب القيمة الرقمية للون
    writer.writeInt(obj.value);
  }
}
