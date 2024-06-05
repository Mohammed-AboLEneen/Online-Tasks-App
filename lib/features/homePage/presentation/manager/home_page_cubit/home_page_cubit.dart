import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'home_page_states.dart';

class HomePageCubit extends Cubit<HomePageStates> {
  HomePageCubit() : super(HomePageInitialState());

  static HomePageCubit get(context) => BlocProvider.of(context);

  List<TaskCardModel> tasks = [];

  List<String> topics = ['All', 'Not Done', 'Done'];

  Box? currentTasksBox;

  int currentTopicIndex = 0;
  int allTasksCount = 0;

  void initCurrentTasksBox() async {
    emit(GetTaskLoadingState());

    // open all boxes
    currentTasksBox = await Hive.openBox<TaskCardModel>('Not Done');
    currentTasksBox = await Hive.openBox<TaskCardModel>('Done');
    currentTasksBox = await Hive.openBox<TaskCardModel>('All');
    print(currentTasksBox?.keys.toList());
    tasks.addAll(currentTasksBox?.values.toList() as List<TaskCardModel>);
    allTasksCount = tasks.length;

    emit(GetTaskSuccessState());
  }

  Future<void> changeTaskStatus(TaskCardModel task) async {
    int newStatus = 0;
    if (task.status == 1) {
      newStatus = 0;
    } else {
      newStatus = 1;
    }

    Box box1 = Hive.box<TaskCardModel>('All');
    Box box2 = Hive.box<TaskCardModel>('Not Done');
    Box box3 = Hive.box<TaskCardModel>('Done');

    await box1.put(task.index, task.copyWith(status: newStatus));
    if (newStatus == 1) {
      box2.delete(task.index);
      box3.put(task.index, task.copyWith(status: 1));
    } else {
      box3.delete(task.index);
      box2.put(task.index, task.copyWith(status: 0));
    }

    currentTasksBox = Hive.box<TaskCardModel>(topics[currentTopicIndex]);
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;
    tasks.forEach((e) => print(' title : ${e.title}, status : ${e.status},'));

    emit(EditTaskSuccessState());
  }

  void changeTasksTopic(int index) {
    currentTopicIndex = index;

    if (index == 0) {
      currentTasksBox = Hive.box<TaskCardModel>('All');
    } else if (index == 1) {
      currentTasksBox = Hive.box<TaskCardModel>('Not Done');
    } else {
      currentTasksBox = Hive.box<TaskCardModel>('Done');
    }

    getTasks();
  }

  void getTasks() async {
    tasks = currentTasksBox?.values.toList() as List<TaskCardModel>;

    currentTasksBox?.toMap().forEach((key, value) {
      print('key : $key , value : ${value.title} : status : ${value.status}');
    });

    if (currentTopicIndex == 0) {
      allTasksCount = tasks.length;
    }
    emit(GetTaskSuccessState());
  }
}
