import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/constents.dart';
import 'package:todo_list_app/cores/utlis/shared_pre_helper.dart';
import 'package:todo_list_app/cores/widgets/custom_textbutton.dart';
import 'package:todo_list_app/cores/widgets/custom_textfield_rounded_border.dart';
import 'package:todo_list_app/features/homePage/presentation/view/home_page.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/home_page_desktop.dart';
import 'package:todo_list_app/features/login/presentation/manager/register_cubit/register_cubit.dart';

import 'package:todo_list_app/features/login/presentation/view/widgets/custom_top_clipper.dart';

import '../../../../cores/utlis/app_fonts.dart';

import '../manager/register_cubit/register_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
        if (state is SuccessRegisterState) {
          SharedPreferenceHelper.setString(key: 'id', value: uId);

          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
            return const HomePageDesktop();
          }));
        } else if (state is FailureRegisterState) {}
      }, builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          body: Form(
            key: _formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
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
                            'Enter Your New Account User Name',
                            style: AppFonts.textStyle20Bold,
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  child: CustomTextFieldRoundedBorder(
                    controller: _emailController,
                    labelText: 'User Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  height: 45,
                  child: CustomTextButton(
                    text: 'Register Now',
                    isTenRounded: true,
                    textColor: Colors.white,
                    buttonColor: mainColor.withOpacity(.8),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.signUp(userName: _emailController.text);
                      } else {
                        autovalidateMode = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * .3,
                  height: 45,
                  child: CustomTextButton(
                    text: 'Back To Login',
                    isTenRounded: true,
                    textColor: Colors.black.withOpacity(.7),
                    buttonColor: Colors.grey.withOpacity(.8),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                if (state is LoadingRegisterState)
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
