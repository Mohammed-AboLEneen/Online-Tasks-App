// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
//
// import '../../../data/models/task_card_model/task_card_model.dart';
// import '../../../data/repo/home_repo_imp.dart';
// import 'edit_task_states.dart';
//
// class EditTaskCubit extends Cubit<EditTaskStates> {
//   EditTaskCubit() : super(EditTaskInitialState());
//
//   static EditTaskCubit get(context) => BlocProvider.of(context);
//
//   Box? currentTasksBox;
//   HomeRepoImp homeRepoImp = HomeRepoImp();
//
//   void initCurrentTasksBox() async {
//     currentTasksBox = await Hive.openBox<TaskCardModel>('All');
//   }
//
//   Future<void> editTask({
//     required TaskCardModel task,
//   }) async {
//     await homeRepoImp.editTask(task: task);
//     emit(EditTaskSuccessState());
//   }
//
//   Future<void> deleteTask({required TaskCardModel task}) async {
//     await homeRepoImp.deleteTask(task: task);
//     emit(EditTaskSuccessState());
//   }
// }
