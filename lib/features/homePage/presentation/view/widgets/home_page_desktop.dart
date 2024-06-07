import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/home_page_cubit/home_page_cubit.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/tasks_grid_view.dart';

import '../../../../../constents.dart';
import '../../../../../cores/utlis/app_fonts.dart';
import '../../../../../cores/widgets/segment_button.dart';
import '../../manager/home_page_cubit/home_page_states.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomePageCubit()..initCurrentTasksBox(),
        child: BlocBuilder<HomePageCubit, HomePageStates>(
            builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 25, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Morning',
                              style: AppFonts.textStyle30Medium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SegmentButtonList(),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.plus,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is GetTaskLoadingState)
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: mainColor,
                          ),
                        ),
                      ),
                    if (state is! GetTaskLoadingState ||
                        homePageCubit.tasks.isNotEmpty)
                      TasksGridView(
                          tasks: homePageCubit.tasks,
                          tasksLen: homePageCubit.allTasksCount,
                          topic: homePageCubit
                              .topics[homePageCubit.currentTopicIndex]),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
