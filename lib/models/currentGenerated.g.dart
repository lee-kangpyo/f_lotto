// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currentGenerated.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentGeneratedAdapter extends TypeAdapter<CurrentGenerated> {
  @override
  final int typeId = 3;

  @override
  CurrentGenerated read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentGenerated()
      ..lottoNumber = (fields[0] as List).cast<int>()
      ..createDate = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CurrentGenerated obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lottoNumber)
      ..writeByte(1)
      ..write(obj.createDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentGeneratedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
