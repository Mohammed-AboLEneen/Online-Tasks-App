import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'home_page_states.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  List<TaskCardModel> tasks = [];

  Box? currentTasksBox;

  List<String> topics = ['All', 'Not Done', 'Done'];
  int currentTopicIndex = 0;

  void initCurrentTasksBox() async {
    emit(GetTaskLoadingState());
    currentTasksBox = await Hive.openBox<TaskCardModel>('All');
    print(currentTasksBox?.keys.toList());
    tasks.addAll(currentTasksBox?.values.toList() as List<TaskCardModel>);
    emit(GetTaskSuccessState());
  }

  void changeTasksTopic(int index) async {
    currentTasksBox?.close();
    currentTopicIndex = index;
    currentTasksBox = await Hive.openBox<TaskCardModel>(topics[index]);
    tasks.clear();
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;

    emit(ChangeTaskTopicState());
  }

  Future<void> editTask(TaskCardModel task, int index) async {
    await currentTasksBox?.put(index, task);
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;

    emit(EditTaskSuccessState());
  }

  void getTasks() async {
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;
    emit(GetTaskSuccessState());
  }
}
