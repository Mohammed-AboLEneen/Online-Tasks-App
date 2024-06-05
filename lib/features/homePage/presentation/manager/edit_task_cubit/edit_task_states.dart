abstract class EditTaskStates {}

class EditTaskInitialState extends EditTaskStates {}

class EditTaskSuccessState extends EditTaskStates {}

class EditTaskLoadingState extends EditTaskStates {}

class EditTaskFailureState extends EditTaskStates {
  final String error;

  EditTaskFailureState(this.error);
}
