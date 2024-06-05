import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'edit_task_states.dart';

class EditTaskCubit extends Cubit<EditTaskStates> {
  EditTaskCubit() : super(EditTaskInitialState());

  static EditTaskCubit get(context) => BlocProvider.of(context);

  Box? currentTasksBox;

  void initCurrentTasksBox() async {
    currentTasksBox = await Hive.openBox<TaskCardModel>('All');
  }

  Future<void> editTask({
    required TaskCardModel task,
  }) async {
    TaskCardModel newTask = TaskCardModel(
        title: task.title,
        date: task.date,
        status: task.status,
        index: task.index,
        createTime: task.createTime);
    if (task.status == 0) {
      Box box2 = Hive.box<TaskCardModel>('Not Done');
      await box2.put(task.index, newTask);
    }

    if (task.status == 1) {
      Box box3 = Hive.box<TaskCardModel>('Done');

      await box3.put(task.index, newTask);
    }

    currentTasksBox ??= await Hive.openBox<TaskCardModel>('All');
    await currentTasksBox?.put(task.index, task);
    emit(EditTaskSuccessState());
  }

  Future<void> deleteTask({required int index}) async {
    currentTasksBox ??= await Hive.openBox<TaskCardModel>('All');
    await currentTasksBox?.deleteAt(index);
    emit(EditTaskSuccessState());
  }
}
