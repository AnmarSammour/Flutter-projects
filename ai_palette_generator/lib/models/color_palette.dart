import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'color_palette.g.dart';

@HiveType(typeId: 0)
class ColorPalette {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<Color> colors;

  @HiveField(2)
  final String name;

  ColorPalette({required this.id, required this.colors, this.name = ''});
}
