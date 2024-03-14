// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Events.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventsAdapter extends TypeAdapter<Events> {
  @override
  final int typeId = 2;

  @override
  Events read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Events(
      date: fields[1] as DateTime,
      title: fields[2] as String,
      notification: fields[6] as bool,
      description: fields[3] as String?,
      imagepath: fields[5] as String?,
      location: fields[4] as String?,
      id: fields[0] as int?,
      reminderTime: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Events obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.imagepath)
      ..writeByte(6)
      ..write(obj.notification)
      ..writeByte(7)
      ..write(obj.reminderTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
