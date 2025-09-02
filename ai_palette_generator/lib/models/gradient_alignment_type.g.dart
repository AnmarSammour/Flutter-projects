// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_alignment_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradientAlignmentTypeAdapter extends TypeAdapter<GradientAlignmentType> {
  @override
  final int typeId = 4;

  @override
  GradientAlignmentType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GradientAlignmentType.linearLeftRight;
      case 1:
        return GradientAlignmentType.linearTopBottom;
      case 2:
        return GradientAlignmentType.linearTopLeftBottomRight;
      case 3:
        return GradientAlignmentType.linearBottomLeftTopRight;
      case 4:
        return GradientAlignmentType.radial;
      default:
        return GradientAlignmentType.linearLeftRight;
    }
  }

  @override
  void write(BinaryWriter writer, GradientAlignmentType obj) {
    switch (obj) {
      case GradientAlignmentType.linearLeftRight:
        writer.writeByte(0);
        break;
      case GradientAlignmentType.linearTopBottom:
        writer.writeByte(1);
        break;
      case GradientAlignmentType.linearTopLeftBottomRight:
        writer.writeByte(2);
        break;
      case GradientAlignmentType.linearBottomLeftTopRight:
        writer.writeByte(3);
        break;
      case GradientAlignmentType.radial:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradientAlignmentTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
