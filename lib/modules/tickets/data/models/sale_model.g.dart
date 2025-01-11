// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleModelAdapter extends TypeAdapter<SaleModel> {
  @override
  final int typeId = 2;

  @override
  SaleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleModel(
      offid: fields[0] as String?,
      ticketRouteId: fields[1] as int?,
      fromTicketCounterId: fields[2] as int?,
      toTicketCounterId: fields[3] as int?,
      type: fields[4] as String?,
      price: fields[5] as double?,
      isAdvanced: fields[6] as bool?,
      saleDate: fields[7] as String?,
      journeyDate: fields[8] as String?,
      userId: fields[9] as int?,
      deviceId: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SaleModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.offid)
      ..writeByte(1)
      ..write(obj.ticketRouteId)
      ..writeByte(2)
      ..write(obj.fromTicketCounterId)
      ..writeByte(3)
      ..write(obj.toTicketCounterId)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.isAdvanced)
      ..writeByte(7)
      ..write(obj.saleDate)
      ..writeByte(8)
      ..write(obj.journeyDate)
      ..writeByte(9)
      ..write(obj.userId)
      ..writeByte(10)
      ..write(obj.deviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
