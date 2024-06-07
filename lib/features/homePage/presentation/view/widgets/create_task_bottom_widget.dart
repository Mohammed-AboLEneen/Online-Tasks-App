import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';

import '../../../../../constents.dart';

import '../../../../../cores/widgets/custom_textbutton.dart';

import '../../manager/home_page_cubit/home_page_cubit.dart';
import 'custom_task_widget.dart';

class CreateTaskButtonWidget extends StatelessWidget {
  final int tasksLength;
  final String topic;

  const CreateTaskButtonWidget({
    super.key,
    required this.tasksLength,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.sizeOf(context).width,
      child: CustomTextButton(
        text: 'Create Task',
        isTenRounded: true,
        textSize: 18,
        buttonColor: mainColor,
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return CustomContentTaskWidget(
                isEdit: false,
                index: tasksLength,
                topic: topic,
              );
            },
          ).then((task) {
            if (task != null) {
              // BlocProvider.of<HomePageCubit>(context).getTasks();
            }
          });
        },
      ),
    );
  }
}
