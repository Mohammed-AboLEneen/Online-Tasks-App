import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/constents.dart';

import '../../../../../cores/utlis/app_fonts.dart';
import '../../../data/models/task_card_model/task_card_model.dart';
import '../../manager/edit_task_cubit/edit_task_cubit.dart';
import '../../manager/home_page_cubit/home_page_cubit.dart';
import '../../manager/home_page_cubit/home_page_states.dart';
import 'custom_task_widget.dart';
import 'custom_task_card.dart';

class TasksListview extends StatelessWidget {
  final List<TaskCardModel> tasks;
  final int tasksLen;
  final String topic;

  const TasksListview({
    super.key,
    required this.tasks,
    required this.tasksLen,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageStates>(
        builder: (context, state) {
      return Expanded(
        child: tasks.isEmpty
            ? Center(
                child: Text(
                  'There is no tasks',
                  style: AppFonts.textStyle20Bold?.copyWith(color: mainColor),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return BlocProvider(
                                  create: (context) =>
                                      EditTaskCubit()..initCurrentTasksBox(),
                                  child: CustomContentTaskWidget(
                                    isEdit: true,
                                    task: tasks[tasks.length - 1 - index],
                                    index: tasksLen,
                                    topic: topic,
                                  ));
                            },
                          ).then((value) {
                            if (value != null) {
                              BlocProvider.of<HomePageCubit>(context)
                                  .getTasks();
                            }
                          });
                        },
                        child: CustomTaskCard(
                          taskCardModel: tasks[tasks.length - 1 - index],
                        ),
                      ),
                    ),
                itemCount: tasks.length),
      );
    });
  }
}
