import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/constents.dart';
import 'package:todo_list_app/features/homePage/data/models/task_card_model/task_card_model.dart';
import 'package:todo_list_app/features/homePage/data/repo/home_repo_imp.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/create_task_bottom_widget.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/tasks_listview.dart';
import '../../../../cores/utlis/app_fonts.dart';
import '../../../../cores/widgets/segment_button.dart';
import '../manager/home_page_cubit/home_page_cubit.dart';
import '../manager/home_page_cubit/home_page_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //HomeRepoImp homeRepoImp = HomeRepoImp();

  // can call changes for loop many times and do the same operation more then one time.
  // so i will use this list to check if the operation already done or not.
  List<int> currentChangeOperations = [];

  @override
  void initState() {
    super.initState();

    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.contains(ConnectivityResult.none)) {
      } else {
        Box box = await Hive.openBox<TaskCardModel>('changes');
        List<TaskCardModel> changes =
            box.values.toList() as List<TaskCardModel>;

        if (changes.isNotEmpty) {
          // order the changes : add > edit > status > delete.

          print('changes ++++++++++++++++++++++++ .length: ${changes.length}');
          for (int i = 0; i < changes.length; i++) {
            if (changes[i].change.every((item) => item == 'none')) {
              box.delete(changes[i].key);
              continue;
            }

            performTaskChanges(changes[i]);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomePageCubit()..initCurrentTasksBox(),
        child: BlocBuilder<HomePageCubit, HomePageStates>(
            builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 25, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning',
                    style: AppFonts.textStyle30Medium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SegmentButtonList(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is GetTaskLoadingState)
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      ),
                    ),
                  if (state is! GetTaskLoadingState ||
                      homePageCubit.tasks.isNotEmpty)
                    TasksListview(
                        tasks: homePageCubit.tasks,
                        tasksLen: homePageCubit.allTasksCount,
                        topic: homePageCubit
                            .topics[homePageCubit.currentTopicIndex]),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CreateTaskButtonWidget(
                      tasksLength: homePageCubit.allTasksCount,
                      topic:
                          homePageCubit.topics[homePageCubit.currentTopicIndex],
                    ),
                  ),
                ],
              ),
            )),
          );
        }));
  }

  Future<void> performTaskChanges(TaskCardModel task) async {
    Box box = Hive.box<TaskCardModel>('changes');

    if (task.change[3] == 'delete' && task.change[0] == 'add') {
      box.delete(task.key);
      return;
    }

    if (task.change[3] == 'delete') {
      //await homeRepoImp.remoteSource.deleteTask(task: task);
      box.delete(task.key);
      return;
    }
    if (task.change[0] == 'add') {
      //await homeRepoImp.remoteSource.addNewTask(task: task);

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
      //await homeRepoImp.remoteSource.editTask(task: task);

      List<String> changes = task.change;
      changes[1] = 'none';
      box.put(
          task.key,
          task.copyWith(
            change: changes,
          ));
    }

    if (task.change[2] == 'status') {
      //await homeRepoImp.remoteSource.changeTaskStatus(task: task);

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

  bool isRunAlready(int key) {
    for (int i = 0; i < currentChangeOperations.length; i++) {
      if (currentChangeOperations[i] == key) {
        return true;
      }
    }
    return false;
  }
}
