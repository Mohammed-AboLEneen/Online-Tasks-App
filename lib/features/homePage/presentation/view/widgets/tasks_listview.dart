import 'package:flutter/material.dart';
import 'package:todo_list_app/constents.dart';

import '../../../../../cores/utlis/app_fonts.dart';
import '../../../data/models/task_card_model.dart';
import 'custom_task_card.dart';

class TasksListview extends StatelessWidget {
  final List<TaskCardModel> tasks;

  const TasksListview({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
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
                    child: CustomTaskCard(
                      taskCardModel: tasks[index],
                    ),
                  ),
              itemCount: tasks.length),
    );
  }
}
