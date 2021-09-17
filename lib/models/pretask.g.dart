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
      name: fields[0] as String,
      description: fields[1] as String,
      importance: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PreTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.importance);
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
