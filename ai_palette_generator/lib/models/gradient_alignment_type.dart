import 'package:hive/hive.dart';

part 'gradient_alignment_type.g.dart'; 

@HiveType(typeId: 4) 
enum GradientAlignmentType {
  @HiveField(0)
  linearLeftRight,
  @HiveField(1)
  linearTopBottom,
  @HiveField(2)
  linearTopLeftBottomRight,
  @HiveField(3)
  linearBottomLeftTopRight,
  @HiveField(4)
  radial,
}
