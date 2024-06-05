abstract class AddNewTaskStates {}

class AddNewTaskInitialState extends AddNewTaskStates {}

class AddNewTaskSuccessState extends AddNewTaskStates {}

class AddNewTaskLoadingState extends AddNewTaskStates {}

class AddNewTaskFailureState extends AddNewTaskStates {
  final String error;

  AddNewTaskFailureState(this.error);
}
