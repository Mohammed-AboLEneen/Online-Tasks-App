import 'package:firedart/auth/user_gateway.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constents.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> signIn({required String userName}) async {
    emit(LoadingLoginState());
    try {
      await FirebaseAuth.instance.signIn(userName, '123456');

      emit(SuccessLoginState());
    } catch (e) {
      emit(FailureLoginState('There is something wrong, try Again'));
    }
  }
}
