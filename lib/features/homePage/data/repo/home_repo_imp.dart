// import 'package:todo_list_app/features/homePage/data/models/task_card_model/task_card_model.dart';
// import 'package:todo_list_app/features/homePage/data/sources/remote_source.dart';
// import 'package:todo_list_app/features/homePage/domain/repo/home_repo.dart';
//
// import '../sources/local_source.dart';
//
// class HomeRepoImp implements HomeRepo {
//   HomeLocalSource localSource = HomeLocalSource();
//   // HomePageRemoteSource remoteSource = HomePageRemoteSource();
//
//   @override
//   Future<void> addNewTask({required TaskCardModel task}) async {
//     await localSource.addTask(task: task);
//     await remoteSource.addNewTask(task: task);
//   }
//
//   @override
//   Future<void> deleteTask({required TaskCardModel task}) async {
//     await localSource.deleteTask(task: task);
//
//     remoteSource.deleteTask(task: task);
//   }
//
//   @override
//   List<TaskCardModel> getTasks({required String topic}) {
//     return localSource.getTasks(topic: topic);
//   }
//
//   @override
//   Future<void> initAllBoxes() async {
//     await localSource.initCurrentTasksBox();
//   }
//
//   @override
//   Future<void> changeTaskStatus({required TaskCardModel task}) async {
//     print('task.status print(' '); ${task.status}');
//     await localSource.changeTaskStatus(task: task);
//     remoteSource.changeTaskStatus(task: task);
//   }
//
//   @override
//   Future<void> editTask({required TaskCardModel task}) async {
//     await localSource.editTaskContent(task: task);
//
//     remoteSource.editTask(task: task);
//   }
//
//   @override
//   Future<void> getOnlineTasks() async {
//     await remoteSource.getData();
//   }
// }
