import 'package:hive/hive.dart';

import '../models/task_card_model.dart';

class HomeLocalSource {
  Future<void> initCurrentTasksBox() async {
    await Hive.openBox<TaskCardModel>('Not Done');
    await Hive.openBox<TaskCardModel>('Done');
    await Hive.openBox<TaskCardModel>('All');
  }

  Future<List<TaskCardModel>> getTasks({required String topic}) async {
    List<TaskCardModel> tasks = [];

    if (topic == 'All') {
      tasks = Hive.box<TaskCardModel>('All').values.toList();
    } else if (topic == 'Not Done') {
      tasks = Hive.box<TaskCardModel>('Not Done').values.toList();
    } else if (topic == 'Done') {
      tasks = Hive.box<TaskCardModel>('Done').values.toList();
    }

    return tasks;
  }

  Future<void> addTask({required TaskCardModel task}) async {
    Box box1 = await Hive.openBox<TaskCardModel>('Not Done');
    Box box2 = await Hive.openBox<TaskCardModel>('All');

    await box1.put(task.index, task);
    await box2.put(task.index, task);
  }

  Future<void> deleteTask({required int key, required String topic}) async {
    Box box = await Hive.openBox<TaskCardModel>(topic);
    await box.delete(key);
  }
}
