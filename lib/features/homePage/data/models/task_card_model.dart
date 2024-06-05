import 'package:hive/hive.dart';

part 'task_card_model.g.dart';

@HiveType(typeId: 0)
class TaskCardModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final int status;
  @HiveField(3)
  final int index;
  @HiveField(4)
  final String createTime;

  TaskCardModel({
    required this.title,
    required this.date,
    required this.status,
    required this.index,
    required this.createTime,
  });

  TaskCardModel copyWith({
    String? title,
    String? date,
    int? status,
    int? index,
    String? createTime,
  }) {
    return TaskCardModel(
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      index: index ?? this.index,
      createTime: createTime ?? this.createTime,
    );
  }
}
