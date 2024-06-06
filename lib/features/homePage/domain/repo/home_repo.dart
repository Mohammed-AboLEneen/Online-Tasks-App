import 'package:todo_list_app/features/homePage/data/models/task_card_model/task_card_model.dart';

abstract class HomeRepo {
  Future<void> initAllBoxes();

  // get all tasks for each time user open app.
  List<TaskCardModel> getTasks({required String topic});

  // when user open in first time, get all tasks if they exist.
  Future<void> getOnlineTasks();

  Future<void> deleteTask({required TaskCardModel task});

  Future<void> addNewTask({required TaskCardModel task});

  Future<void> changeTaskStatus({
    required TaskCardModel task,
  });

  Future<void> editTask({
    required TaskCardModel task,
  });
}
