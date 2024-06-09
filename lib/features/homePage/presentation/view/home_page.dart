import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list_app/constents.dart';
import 'package:todo_list_app/features/homePage/data/repo/home_repo_imp.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/create_task_bottom_widget.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/tasks_listview.dart';
import '../../../../cores/utlis/app_fonts.dart';
import 'widgets/segment_button_list.dart';
import '../manager/home_page_cubit/home_page_cubit.dart';
import '../manager/home_page_cubit/home_page_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeRepoImp homeRepoImp = HomeRepoImp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomePageCubit()
          ..initConnectivity()
          ..initCurrentTasksBox(),
        child: BlocBuilder<HomePageCubit, HomePageStates>(
            builder: (context, state) {
          HomePageCubit homePageCubit = HomePageCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 25, bottom: 10),
              child: Column(
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
                  const SizedBox(
                    height: 20,
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
                    TasksListview(
                        tasks: homePageCubit.tasks,
                        topic: homePageCubit
                            .topics[homePageCubit.currentTopicIndex]),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CreateTaskButtonWidget(
                      topic:
                          homePageCubit.topics[homePageCubit.currentTopicIndex],
                    ),
                  ),
                ],
              ),
            )),
          );
        }));
  }
}
