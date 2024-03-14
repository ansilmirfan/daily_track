// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlannerAdapter extends TypeAdapter<Planner> {
  @override
  final int typeId = 3;

  @override
  Planner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Planner(
      title: fields[1] as String,
      description: fields[2] as String,
      doneOrNot: fields[3] as bool,
      category: fields[5] as String,
      date: fields[4] as DateTime,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Planner obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.doneOrNot)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlannerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
