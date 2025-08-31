import 'package:flutter/material.dart';

class ColorPalette {
  final String id;
  final List<Color> colors;
  final String name;

  ColorPalette({
    required this.id,
    required this.colors,
    this.name = '',
  });
}
