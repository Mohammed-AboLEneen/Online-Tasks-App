import 'package:flutter_bloc/flutter_bloc.dart';

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
  int allTasksCount = 0;

  void initCurrentTasksBox() async {
    emit(GetTaskLoadingState());

    // open all boxes
    await homeRepoImp.initAllBoxes();

    tasks.addAll(homeRepoImp.getTasks(topic: topics[currentTopicIndex]));
    allTasksCount = tasks.length;

    tasks.forEach((e) => print('task: ${e.title}, key: ${e.key}'));
    print('all tasks count: ${allTasksCount}');

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

    tasks.forEach((e) => print('task: ${e.title}, key: ${e.key}'));
    if (currentTopicIndex == 0) {
      allTasksCount = tasks.length;
    }
    emit(GetTaskSuccessState());
  }
}
