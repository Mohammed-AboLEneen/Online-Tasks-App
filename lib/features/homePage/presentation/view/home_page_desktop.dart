import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/home_page_cubit/home_page_cubit.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/custom_task_widget.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/tasks_grid_view.dart';

import '../../../../constents.dart';
import '../../../../cores/methods/show_alrt_dialog.dart';
import '../../../../cores/utlis/app_fonts.dart';
import '../../../../cores/widgets/segment_button.dart';
import '../../data/models/task_card_model/task_card_model.dart';
import '../../data/repo/home_repo_imp.dart';
import '../manager/home_page_cubit/home_page_states.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  HomeRepoImp homeRepoImp = HomeRepoImp();

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
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 25, bottom: 10),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double width = constraints.maxWidth;
                    int gridCount = 4;

                    if (width < 400) {
                      gridCount = 1;
                    } else if (width < 700) {
                      gridCount = 2;
                    } else if (width < 800) {
                      gridCount = 3;
                    } else {
                      gridCount = 4;
                    }

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Column(
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
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  await showAlertDialog(
                                      context,
                                      BlocProvider(
                                        create: (context) => AddNewTaskCubit(),
                                        child: CustomContentTaskWidget(
                                          isEdit: false,
                                          topic: homePageCubit.topics[
                                              homePageCubit.currentTopicIndex],
                                        ),
                                      )).then((value) {
                                    BlocProvider.of<HomePageCubit>(context)
                                        .getTasks();
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        if (state is GetTaskLoadingState)
                          SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          ),
                        if (state is! GetTaskLoadingState)
                          BlocBuilder<HomePageCubit, HomePageStates>(
                              builder: (context, state) {
                            if (state is GetTaskSuccessState) {
                              print('yaaaaaaa');
                            }
                            return TasksGridView(
                                tasks: homePageCubit.tasks,
                                gridCount: gridCount,
                                topic: homePageCubit
                                    .topics[homePageCubit.currentTopicIndex]);
                          })
                      ],
                    );
                  },
                ),
              ),
            ),
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
