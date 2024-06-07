import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../data/models/task_card_model/task_card_model.dart';
import '../../../data/repo/home_repo_imp.dart';
import 'home_page_states.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  HomeRepoImp homeRepoImp = HomeRepoImp();
  List<TaskCardModel> tasks = [];

  List<String> topics = ['All', 'Not Done', 'Done'];

  int currentTopicIndex = 0;

  void initCurrentTasksBox() async {
    emit(GetTaskLoadingState());

    // open all boxes
    await homeRepoImp.initAllBoxes();

    Box box = Hive.box<TaskCardModel>('All');
    // if there is no data stored in hive boxes, get data from server.
    if (box.isEmpty) {
      await homeRepoImp.getOnlineTasks();
    }

    tasks.addAll(homeRepoImp.getTasks(topic: topics[currentTopicIndex]));

    for (var i in tasks) {
      print('key: ${i.title}, change: ${i.status} : ${i.key}');
    }

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
    print('geeeeeeeeeeeeeeeeet');
    tasks = homeRepoImp.getTasks(topic: topics[currentTopicIndex]);

    emit(GetTaskSuccessState());
  }
}
