abstract class HomePageStates {}

class HomePageInitialState extends HomePageStates {}

class AddNewTaskSuccessState extends HomePageStates {}

class AddNewTaskFailureState extends HomePageStates {
  final String error;

  AddNewTaskFailureState(this.error);
}

class ChangeTaskTopicState extends HomePageStates {}

class GetTaskSuccessState extends HomePageStates {}

class GetTaskFailureState extends HomePageStates {
  final String error;

  GetTaskFailureState(this.error);
}
