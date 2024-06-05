import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'add_new_task_states.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskStates> {
  AddNewTaskCubit() : super(AddNewTaskInitialState());

  static AddNewTaskCubit get(context) => BlocProvider.of(context);

  Box? currentTasksBox;

  List<String> topics = ['All', 'Not Done', 'Done'];
  int currentTopicIndex = 0;

  void initCurrentTasksBox(String topicBox) async {
    currentTasksBox = await Hive.openBox<TaskCardModel>(topicBox);
  }

  Future<void> addTask(TaskCardModel task) async {
    emit(AddNewTaskLoadingState());
    int? index = await currentTasksBox?.add(task);
    emit(AddNewTaskSuccessState());
  }
}
