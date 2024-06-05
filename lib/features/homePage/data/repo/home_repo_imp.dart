import 'package:todo_list_app/features/homePage/data/models/task_card_model.dart';
import 'package:todo_list_app/features/homePage/domain/repo/home_repo.dart';

import '../sources/local_source.dart';

class HomeRepoImp implements HomeRepo {
  HomeLocalSource localSource = HomeLocalSource();

  @override
  Future<void> addNewTask({required TaskCardModel task}) async {
    await localSource.addTask(task: task);
  }

  @override
  Future<void> deleteTask({required int index, required int status}) async {
    await localSource.deleteTask(
      key: index,
      status: status,
    );
  }

  @override
  List<TaskCardModel> getTasks({required String topic}) {
    return localSource.getTasks(topic: topic);
  }

  @override
  Future<void> initAllBoxes() async {
    await localSource.initCurrentTasksBox();
  }

  @override
  Future<void> changeTaskStatus({required TaskCardModel task}) async {
    await localSource.changeTaskStatus(task: task);
  }

  @override
  Future<void> editTask({required TaskCardModel task}) async {
    await localSource.editTaskContent(task: task);
  }
}
