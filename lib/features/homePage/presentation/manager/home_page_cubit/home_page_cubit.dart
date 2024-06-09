import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../../constents.dart';
import '../../../data/models/task_card_model/task_card_model.dart';
import '../../../data/repo/home_repo_imp.dart';
import 'home_page_states.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  HomeRepoImp homeRepoImp = HomeRepoImp();
  List<TaskCardModel> tasks = [];

  List<String> topics = ['All', 'Not Done', 'Done', 'Waiting'];

  int currentTopicIndex = 0;

  void initCurrentTasksBox() async {
    emit(GetTaskLoadingState());

    // open all boxes
    await homeRepoImp.initAllBoxes();

    Box box = Hive.box<TaskCardModel>(allTasksBoxName);
    // if there is no data stored in hive boxes, get data from server.
    if (box.isEmpty) {
      await homeRepoImp.getOnlineTasks();
    }

    tasks.addAll(homeRepoImp.getTasks(topic: topics[currentTopicIndex]));

    emit(GetTaskSuccessState());
  }

  Future<void> changeTaskStatus(TaskCardModel task) async {
    await homeRepoImp.changeTaskStatus(task: task);
    tasks = homeRepoImp.getTasks(topic: topics[currentTopicIndex]);

    emit(EditTaskSuccessState());
  }

  void changeTasksTopic(int index) {
    currentTopicIndex = index;
    getTasks();
  }

  void getTasks() async {
    tasks = homeRepoImp.getTasks(topic: topics[currentTopicIndex]);

    emit(GetTaskSuccessState());
  }

  void initConnectivity() async {
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.contains(ConnectivityResult.none)) {
      } else {
        Box box = await Hive.openBox<TaskCardModel>(waitingTasksBoxName);
        List<TaskCardModel> changes =
            box.values.toList() as List<TaskCardModel>;

        if (changes.isNotEmpty) {
          // order the changes : add > edit > status > delete.
          for (int i = 0; i < changes.length; i++) {
            if (changes[i].change.every((item) => item == 'none')) {
              box.delete(changes[i].key);
              continue;
            }

            performTaskChanges(changes[i]).then((value) {
              if (topics[currentTopicIndex] == waitingTasksBoxName) {
                tasks = homeRepoImp.getTasks(topic: topics[currentTopicIndex]);
                emit(GetTaskSuccessState());
              }
            });
          }
        }
      }
    });
  }

  Future<void> performTaskChanges(TaskCardModel task) async {
    Box box = Hive.box<TaskCardModel>(waitingTasksBoxName);

    if (task.change[3] == 'delete' && task.change[0] == 'add') {
      box.delete(task.key);
      return;
    }

    if (task.change[3] == 'delete') {
      await homeRepoImp.remoteSource.deleteTask(task: task);
      box.delete(task.key);
      return;
    }
    if (task.change[0] == 'add') {
      await homeRepoImp.remoteSource.addNewTask(task: task);

      List<String> changes = task.change;
      changes[0] = 'none';
      await box.put(
          task.key,
          task.copyWith(
            change: changes,
          ));

      TaskCardModel boxTask = box.get(task.key);
      print('boxTask change After Add: ${boxTask.change}');
    }

    if (task.change[1] == 'edit' && task.change[0] != 'add') {
      await homeRepoImp.remoteSource.editTask(task: task);

      List<String> changes = task.change;
      changes[1] = 'none';
      box.put(
          task.key,
          task.copyWith(
            change: changes,
          ));
    }

    if (task.change[2] == 'status') {
      await homeRepoImp.remoteSource.changeTaskStatus(task: task);

      List<String> changes = task.change;
      changes[2] = 'none';
      box.put(
          task.key,
          task.copyWith(
            change: changes,
          ));
    }

    box.delete(task.key);
  }
}
