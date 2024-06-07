import 'package:hive/hive.dart';

import '../models/task_card_model/task_card_model.dart';

class HomeLocalSource {
  Future<void> initCurrentTasksBox() async {
    print('Not Done ${await Hive.boxExists('Not Done')}');
    print('Done ${await Hive.boxExists('Done')}');
    print('All ${await Hive.boxExists('All')}');

    await Hive.openBox<TaskCardModel>('Not Done');
    await Hive.openBox<TaskCardModel>('Done');
    await Hive.openBox<TaskCardModel>('All');
    await Hive.openBox<TaskCardModel>('changes');

    print('init current tasks box');
  }

  List<TaskCardModel> getTasks({required String topic}) {
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
    Box box1 = Hive.box<TaskCardModel>('Not Done');
    Box box2 = Hive.box<TaskCardModel>('All');

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
    Box box1 = await Hive.openBox<TaskCardModel>('All');

    Box? box2;
    if (task.status == 1) {
      box2 = await Hive.openBox<TaskCardModel>('Done');
    } else {
      box2 = await Hive.openBox<TaskCardModel>('Not Done');
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

    Box box1 = Hive.box<TaskCardModel>('All');
    Box box2 = Hive.box<TaskCardModel>('Not Done');
    Box box3 = Hive.box<TaskCardModel>('Done');

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

    Box box1 = Hive.box<TaskCardModel>('All');
    await box1.put(task.key, task);

    if (task.status == 0) {
      Box box2 = Hive.box<TaskCardModel>('Not Done');
      await box2.put(task.key, newTask);
    }

    if (task.status == 1) {
      Box box3 = Hive.box<TaskCardModel>('Done');

      await box3.put(task.key, newTask);
    }
  }
}
