import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/task_card_model.dart';
import 'edit_task_states.dart';

class EditTaskCubit extends Cubit<EditTaskStates> {
  EditTaskCubit() : super(EditTaskInitialState());

  static EditTaskCubit get(context) => BlocProvider.of(context);

  Box? currentTasksBox;
  String topicBox = 'All';

  void initCurrentTasksBox(String topicBox) async {
    print('edit task box : $topicBox');
    this.topicBox = topicBox;
    currentTasksBox = await Hive.openBox<TaskCardModel>(topicBox);
  }

  Future<void> editTask(
      {required TaskCardModel task, required int index}) async {
    currentTasksBox ??= await Hive.openBox<TaskCardModel>(topicBox);
    await currentTasksBox?.putAt(index, task);
    emit(EditTaskSuccessState());
  }
}
