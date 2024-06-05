import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'add_new_task_states.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskStates> {
  AddNewTaskCubit() : super(AddNewTaskInitialState());

  static AddNewTaskCubit get(context) => BlocProvider.of(context);

  Box? currentTasksBox;

  void initCurrentTasksBox() async {
    currentTasksBox = Hive.box<TaskCardModel>('All');
  }

  Future<void> addTask(TaskCardModel task) async {
    emit(AddNewTaskLoadingState());

    Box box1 = Hive.box<TaskCardModel>('Not Done');

    TaskCardModel newTask = TaskCardModel(
        title: task.title,
        date: task.date,
        status: task.status,
        index: task.index,
        createTime: DateTime.now().toString());

    await currentTasksBox?.put(task.index, newTask);
    await box1.put(task.index, task);

    print(box1.get(task.index).title);

    emit(AddNewTaskSuccessState());
  }
}
