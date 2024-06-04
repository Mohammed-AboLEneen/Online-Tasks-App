import 'package:hive/hive.dart';

part 'task_card_model.g.dart';

@HiveType(typeId: 0)
class TaskCardModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String status;

  TaskCardModel({
    required this.title,
    required this.date,
    required this.status,
  });
}
