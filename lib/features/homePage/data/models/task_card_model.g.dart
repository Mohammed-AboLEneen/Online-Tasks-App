// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskCardModelAdapter extends TypeAdapter<TaskCardModel> {
  @override
  final int typeId = 0;

  @override
  TaskCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCardModel(
      title: fields[0] as String,
      date: fields[1] as String,
      status: fields[2] as int,
      index: fields[3] as int,
      createTime: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCardModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.index)
      ..writeByte(4)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
