// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lotto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LottoAdapter extends TypeAdapter<Lotto> {
  @override
  final int typeId = 1;

  @override
  Lotto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lotto()
      ..lottoNumber = (fields[0] as List).cast<int>()
      ..createDate = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Lotto obj) {
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
      other is LottoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
