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
    currentTasksBox ??= await Hive.openBox<TaskCardModel>('All');
    await currentTasksBox?.putAt(task.index, task);
    emit(EditTaskSuccessState());
  }

  Future<void> deleteTask({required int index}) async {
    currentTasksBox ??= await Hive.openBox<TaskCardModel>('All');
    await currentTasksBox?.deleteAt(index);
    emit(EditTaskSuccessState());
  }
}
