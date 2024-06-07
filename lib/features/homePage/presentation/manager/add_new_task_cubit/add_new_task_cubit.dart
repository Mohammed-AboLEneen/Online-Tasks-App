import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/task_card_model/task_card_model.dart';
import '../../../data/repo/home_repo_imp.dart';
import 'add_new_task_states.dart';

class AddNewTaskCubit extends Cubit<AddNewTaskStates> {
  AddNewTaskCubit() : super(AddNewTaskInitialState());

  static AddNewTaskCubit get(context) => BlocProvider.of(context);

  HomeRepoImp homeRepoImp = HomeRepoImp();

  Future<void> addTask(TaskCardModel task) async {
    emit(AddNewTaskLoadingState());

    await homeRepoImp.addNewTask(task: task);

    emit(AddNewTaskSuccessState());
  }
}
