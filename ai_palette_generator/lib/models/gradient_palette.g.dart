// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_palette.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradientPaletteAdapter extends TypeAdapter<GradientPalette> {
  @override
  final int typeId = 3;

  @override
  GradientPalette read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradientPalette(
      id: fields[0] as String,
      colors: (fields[1] as List).cast<Color>(),
      alignmentType: fields[2] as GradientAlignmentType,
    );
  }

  @override
  void write(BinaryWriter writer, GradientPalette obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.colors)
      ..writeByte(2)
      ..write(obj.alignmentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradientPaletteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
