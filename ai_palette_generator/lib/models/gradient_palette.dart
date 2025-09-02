import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ai_palette_generator/models/gradient_alignment_type.dart';

part 'gradient_palette.g.dart';

@HiveType(typeId: 3) 
class GradientPalette {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<Color> colors;

  @HiveField(2)
  final GradientAlignmentType alignmentType;

  GradientPalette({
    required this.id,
    required this.colors,
    required this.alignmentType,
  });
}
