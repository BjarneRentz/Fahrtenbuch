// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideAdapter extends TypeAdapter<Ride> {
  @override
  final int typeId = 0;

  @override
  Ride read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ride(
      fields[0] as DateTime,
      fields[1] as int,
      fields[2] as int?,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ride obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mileageStart)
      ..writeByte(2)
      ..write(obj.milageEnd)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
