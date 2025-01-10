// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_ticket_fare_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalTicketFareModelAdapter extends TypeAdapter<LocalTicketFareModel> {
  @override
  final int typeId = 1;

  @override
  LocalTicketFareModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalTicketFareModel(
      routeId: fields[0] as int,
      fromCounterId: fields[1] as int,
      toCounterId: fields[2] as int,
      type: fields[3] as String,
      price: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, LocalTicketFareModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.routeId)
      ..writeByte(1)
      ..write(obj.fromCounterId)
      ..writeByte(2)
      ..write(obj.toCounterId)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalTicketFareModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
