// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FilterNumbers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterNumbersAdapter extends TypeAdapter<FilterNumbers> {
  @override
  final int typeId = 2;

  @override
  FilterNumbers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterNumbers()..filterNumber = (fields[0] as Map).cast<int, int>();
  }

  @override
  void write(BinaryWriter writer, FilterNumbers obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.filterNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterNumbersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
