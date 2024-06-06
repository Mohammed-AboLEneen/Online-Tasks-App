import 'package:hive/hive.dart';
import 'package:todo_list_app/features/homePage/data/models/task_card_model/task_card_model.dart';

part 'change_task_model.g.dart';

@HiveType(typeId: 1)
class ChangeTaskModel {
  @HiveField(0)
  TaskCardModel task;
  @HiveField(1)
  String change;

  ChangeTaskModel({required this.task, required this.change});
}
