// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryAdapter extends TypeAdapter<Diary> {
  @override
  final int typeId = 10;

  @override
  Diary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diary(
      title: fields[1] as String,
      content: fields[2] as String,
      dateTime: fields[3] as DateTime,
      font: fields[4] as int,
      fontcolor: fields[5] as int,
      bgcolor: fields[6] as int,
      imgpath: fields[7] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Diary obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.font)
      ..writeByte(5)
      ..write(obj.fontcolor)
      ..writeByte(6)
      ..write(obj.bgcolor)
      ..writeByte(7)
      ..write(obj.imgpath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
