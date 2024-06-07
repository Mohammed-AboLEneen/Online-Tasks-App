import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constents.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> signUp({required String userName}) async {
    emit(LoadingRegisterState());
    try {
      User user = await FirebaseAuth.instance.signUp(userName, '123456');

      uId = user.id;

      emit(SuccessRegisterState());
    } catch (e) {
      print(e);
      emit(FailureRegisterState('There is something wrong, try Again'));
    }
  }
}
