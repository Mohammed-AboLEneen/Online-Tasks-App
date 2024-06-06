import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constents.dart';
import '../../../../../cores/methods/google_auth.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  Future<void> signInWithGoogle() async {
    emit(LoadingLoginState());
    try {
      // Create a new credential
      final credential = await googleAuth();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      uId = userCredential.user?.uid ?? '';

      emit(SuccessLoginState());
    } catch (e) {
      emit(FailureLoginState('There is something wrong, try Again'));
    }
  }
}
