// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pretask.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreTaskAdapter extends TypeAdapter<PreTask> {
  @override
  final int typeId = 0;

  @override
  PreTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PreTask(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      importance: fields[3] as double,
      timeStamp: fields[4] as DateTime,
      state: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PreTask obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.importance)
      ..writeByte(4)
      ..write(obj.timeStamp)
      ..writeByte(5)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
