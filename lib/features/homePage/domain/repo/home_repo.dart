import 'package:todo_list_app/features/homePage/data/models/task_card_model.dart';

abstract class HomeRepo {
  Future<void> initAllBoxes();

  List<TaskCardModel> getTasks({required String topic});

  Future<void> deleteTask({required int index, required int status});

  Future<void> addNewTask({required TaskCardModel task});

  Future<void> changeTaskStatus({
    required TaskCardModel task,
  });

  Future<void> editTask({
    required TaskCardModel task,
  });
}
