import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/features/homePage/data/models/task_card_model.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';

import '../../../../../constents.dart';
import '../../../../../cores/methods/show_date_picker.dart';
import '../../../../../cores/utlis/app_fonts.dart';
import '../../../../../cores/widgets/custom_textbutton.dart';
import '../../../../../cores/widgets/custom_textfield_rounded_border.dart';
import '../../manager/home_page_cubit/home_page_cubit.dart';
import 'custom_task_widget.dart';

class CreateTaskButtonWidget extends StatelessWidget {
  final String topicBox;

  const CreateTaskButtonWidget({
    super.key,
    required this.topicBox,
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
              return BlocProvider(
                  create: (context) =>
                      AddNewTaskCubit()..initCurrentTasksBox(topicBox),
                  child: const CustomContentTaskWidget(
                    isEdit: false,
                  ));
            },
          ).then((value) {
            if (value != null) {
              BlocProvider.of<HomePageCubit>(context).getTasks();
            }
          });
        },
      ),
    );
  }
}
