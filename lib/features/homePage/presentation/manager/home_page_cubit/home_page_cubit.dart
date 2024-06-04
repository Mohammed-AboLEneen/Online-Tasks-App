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

  void initCurrentTasksBox() async {
    currentTasksBox = await Hive.openBox<TaskCardModel>('All');
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;
    emit(GetTaskSuccessState());
  }

  void addTask(TaskCardModel task) async {
    await currentTasksBox?.add(task);
    tasks.add(task);
    emit(AddNewTaskSuccessState());
  }

  void changeTasksTopic(int index) async {
    currentTasksBox?.close();

    currentTasksBox = await Hive.openBox<TaskCardModel>(topics[index]);
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;

    emit(ChangeTaskTopicState());
  }
}
