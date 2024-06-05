import 'package:todo_list_app/features/homePage/data/models/task_card_model.dart';

abstract class HomeRepo {
  Future<void> initAllBoxes();

  Future<void> getTasks({required String topic});

  Future<void> deleteTask({required int index, required String topic});

  Future<void> addNewTask({required TaskCardModel task});
}
