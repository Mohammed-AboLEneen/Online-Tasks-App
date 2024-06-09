import 'package:hive/hive.dart';

import '../../../../constents.dart';
import '../models/task_card_model/task_card_model.dart';

class HomeLocalSource {
  Future<void> initCurrentTasksBox() async {
    await Hive.openBox<TaskCardModel>(allTasksBoxName);
    await Hive.openBox<TaskCardModel>(notDoneTasksBoxName);
    await Hive.openBox<TaskCardModel>(doneTasksBoxName);
    await Hive.openBox<TaskCardModel>(waitingTasksBoxName);
  }

  List<TaskCardModel> getTasks({required String topic}) {
    List<TaskCardModel> tasks = [];

    if (topic == allTasksBoxName) {
      tasks = Hive.box<TaskCardModel>(allTasksBoxName).values.toList();
    } else if (topic == notDoneTasksBoxName) {
      tasks = Hive.box<TaskCardModel>(notDoneTasksBoxName).values.toList();
    } else if (topic == doneTasksBoxName) {
      tasks = Hive.box<TaskCardModel>(doneTasksBoxName).values.toList();
    } else {
      tasks = Hive.box<TaskCardModel>(waitingTasksBoxName).values.toList();
    }

    return tasks;
  }

  Future<void> addTask({required TaskCardModel task}) async {
    Box box1 = Hive.box<TaskCardModel>(notDoneTasksBoxName);
    Box box2 = Hive.box<TaskCardModel>(allTasksBoxName);

    TaskCardModel newTask = TaskCardModel(
        title: task.title,
        date: task.date,
        status: task.status,
        key: task.key,
        createTime: task.createTime);
    await box2.put(task.key, task);
    await box1.put(task.key, newTask);
  }

  Future<void> deleteTask({required TaskCardModel task}) async {
    Box box1 = await Hive.openBox<TaskCardModel>(allTasksBoxName);

    Box? box2;
    if (task.status == 1) {
      box2 = await Hive.openBox<TaskCardModel>(doneTasksBoxName);
    } else {
      box2 = await Hive.openBox<TaskCardModel>(notDoneTasksBoxName);
    }

    await box1.delete(task.key);
    await box2.delete(task.key);
  }

  Future<void> changeTaskStatus({required TaskCardModel task}) async {
    int newStatus = 0;
    if (task.status == 1) {
      newStatus = 0;
    } else {
      newStatus = 1;
    }

    Box box1 = Hive.box<TaskCardModel>(allTasksBoxName);
    Box box2 = Hive.box<TaskCardModel>(notDoneTasksBoxName);
    Box box3 = Hive.box<TaskCardModel>(doneTasksBoxName);

    await box1.put(task.key, task.copyWith(status: newStatus));
    if (newStatus == 1) {
      await box2.delete(task.key);
      await box3.put(task.key, task.copyWith(status: 1));
    } else {
      await box3.delete(task.key);
      await box2.put(task.key, task.copyWith(status: 0));
    }
  }

  Future<void> editTaskContent({required TaskCardModel task}) async {
    TaskCardModel newTask = TaskCardModel(
        title: task.title,
        date: task.date,
        status: task.status,
        key: task.key,
        createTime: task.createTime);

    Box box1 = Hive.box<TaskCardModel>(allTasksBoxName);
    await box1.put(task.key, task);

    if (task.status == 0) {
      Box box2 = Hive.box<TaskCardModel>(notDoneTasksBoxName);
      await box2.put(task.key, newTask);
    }

    if (task.status == 1) {
      Box box3 = Hive.box<TaskCardModel>(doneTasksBoxName);

      await box3.put(task.key, newTask);
    }
  }
}
