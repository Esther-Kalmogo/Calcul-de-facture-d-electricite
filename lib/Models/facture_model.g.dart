// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactureAdapter extends TypeAdapter<Facture> {
  @override
  final int typeId = 0;

  @override
  Facture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Facture(
      date: fields[0] as DateTime,
      consommation: fields[1] as double,
      prix: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Facture obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.consommation)
      ..writeByte(2)
      ..write(obj.prix);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
