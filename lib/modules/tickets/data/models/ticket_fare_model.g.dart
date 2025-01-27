// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_fare_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketFareModelAdapter extends TypeAdapter<TicketFareModel> {
  @override
  final int typeId = 0;

  @override
  TicketFareModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketFareModel(
      status: fields[0] as bool?,
      message: fields[1] as String?,
      prices: (fields[2] as List?)?.cast<Prices>(),
    );
  }

  @override
  void write(BinaryWriter writer, TicketFareModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.prices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketFareModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PricesAdapter extends TypeAdapter<Prices> {
  @override
  final int typeId = 1;

  @override
  Prices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Prices(
      id: fields[0] as int?,
      studentPrice: fields[1] as int?,
      generalPrice: fields[2] as int?,
      toTicketCounterName: fields[3] as String?,
      toTicketCounterNameBn: fields[4] as String?,
      counterShortName: fields[5] as dynamic,
      toTicketCounterId: fields[6] as dynamic,
      routeName: fields[7] as String?,
      routeId: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Prices obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.studentPrice)
      ..writeByte(2)
      ..write(obj.generalPrice)
      ..writeByte(3)
      ..write(obj.toTicketCounterName)
      ..writeByte(4)
      ..write(obj.toTicketCounterNameBn)
      ..writeByte(5)
      ..write(obj.counterShortName)
      ..writeByte(6)
      ..write(obj.toTicketCounterId)
      ..writeByte(7)
      ..write(obj.routeName)
      ..writeByte(8)
      ..write(obj.routeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PricesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
