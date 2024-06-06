// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChangeTaskModelAdapter extends TypeAdapter<ChangeTaskModel> {
  @override
  final int typeId = 1;

  @override
  ChangeTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChangeTaskModel(
      task: fields[0] as TaskCardModel,
      change: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChangeTaskModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.change);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChangeTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
