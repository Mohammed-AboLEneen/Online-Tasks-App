import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_states.dart';

import '../../../../../constents.dart';
import '../../../../../cores/methods/show_date_picker.dart';
import '../../../../../cores/utlis/app_fonts.dart';
import '../../../../../cores/widgets/custom_textbutton.dart';
import '../../../../../cores/widgets/custom_textfield_rounded_border.dart';
import '../../../data/models/task_card_model.dart';

class AddNewTaskWidget extends StatefulWidget {
  const AddNewTaskWidget({super.key});

  @override
  State<AddNewTaskWidget> createState() => _AddNewTaskWidgetState();
}

class _AddNewTaskWidgetState extends State<AddNewTaskWidget> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Create New Task',
                style: AppFonts.textStyle20Bold,
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: FaIcon(FontAwesomeIcons.xmark,
                      color: Colors.red.withOpacity(.8))),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFieldRoundedBorder(
            labelText: 'Task Title',
            backgroundColor: Colors.grey.withOpacity(.2),
            textInputAction: TextInputAction.newline,
            maxLines: 4,
            minLines: 1,
            padding: const EdgeInsets.only(left: 20),
            controller: titleController,
          ),
          const SizedBox(height: 10),
          CustomTextFieldRoundedBorder(
            labelText: 'Due Date',
            backgroundColor: Colors.grey.withOpacity(.2),
            textColor: Colors.teal,
            padding: const EdgeInsets.only(left: 20),
            keyboardType: TextInputType.none,
            onTap: () async {
              DateTime? pickedDate = await showDatePickerMethod(context);

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('EEE. d/M/yyyy').format(pickedDate);

                dateController.text = formattedDate;
              }
            },
            controller: dateController,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<AddNewTaskCubit, AddNewTaskStates>(
              builder: (context, state) {
            if (state is AddNewTaskLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: mainColor,
                ),
              );
            } else {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                child: CustomTextButton(
                  text: 'Save Task',
                  isTenRounded: true,
                  textSize: 18,
                  buttonColor: mainColor,
                  onPressed: () {
                    BlocProvider.of<AddNewTaskCubit>(context).addTask(
                        TaskCardModel(
                            title: titleController.text,
                            date: dateController.text,
                            status: 0));
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
