import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/constents.dart';
import 'package:todo_list_app/cores/utlis/shared_pre_helper.dart';
import 'package:todo_list_app/features/homePage/presentation/view/home_page.dart';

import 'package:todo_list_app/features/login/presentation/view/widgets/custom_top_clipper.dart';

import '../../../../cores/methods/google_sign_out.dart';
import '../../../../cores/methods/show_toast.dart';
import '../../../../cores/utlis/app_fonts.dart';

import '../manager/login_cubit/login_cubit.dart';
import '../manager/login_cubit/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        if (state is SuccessLoginState) {
          showToast(
              msg: 'Login Success',
              toastMessageType: ToastMessageType.successMessage);

          SharedPreferenceHelper.setString(key: 'id', value: uId);

          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
            return const HomePage();
          }));
        } else if (state is FailureLoginState) {
          showToast(
              msg: state.message,
              toastMessageType: ToastMessageType.failureMessage);
        }
      }, builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .34,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CustomTopClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.blue,
                          mainColor,
                        ])),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * .25,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: _animationController.value,
                      child: SlideTransition(
                        position: _animation,
                        child: Text(
                          'Welcome',
                          style: AppFonts.textStyle20Bold,
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
                child: IntrinsicWidth(
                  child: TextButton(
                      onPressed: () async {
                        await googleSignOut();
                        cubit.signInWithGoogle();
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.blue.withOpacity(.4)),
                          // Set the desired background color here
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(horizontal: 5)),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder?>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )))),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.google),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Sign in with google',
                              style: AppFonts.textStyle15Regular,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              if (state is LoadingLoginState)
                Container(
                  width: MediaQuery.sizeOf(context).width * .7,
                ),
              const Spacer(
                flex: 2,
              ),
              Transform.rotate(
                angle: 2 * 1.57079633,
                child: ClipPath(
                  clipper: CustomTopClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [mainColor, Colors.blue])),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * .25,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Transform.rotate(
                          angle: 2 * 1.57079633,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.listCheck,
                                color: Colors.white,
                                size: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    return AnimatedOpacity(
                                      opacity: _animationController.value,
                                      duration: const Duration(seconds: 1),
                                      child: Text(
                                        'Online Tasks',
                                        style: AppFonts.textStyle15Regular
                                            ?.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void startAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -.5),
      end: const Offset(0.0, 0),
    ).animate(_animationController);
    _animationController.forward();
  }
}
