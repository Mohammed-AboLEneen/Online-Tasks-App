import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/add_new_task_cubit/add_new_task_cubit.dart';
import 'package:todo_list_app/features/homePage/presentation/manager/edit_task_cubit/edit_task_cubit.dart';

import '../../../../../constents.dart';
import '../../../../../cores/methods/show_date_picker.dart';
import '../../../../../cores/utlis/app_fonts.dart';
import '../../../../../cores/widgets/custom_textbutton.dart';
import '../../../../../cores/widgets/custom_textfield_rounded_border.dart';
import '../../../data/models/task_card_model/task_card_model.dart';

class CustomContentTaskWidget extends StatefulWidget {
  final TaskCardModel? task;
  final bool isEdit;
  final int index;
  final String topic;

  const CustomContentTaskWidget(
      {super.key,
      this.task,
      required this.isEdit,
      required this.index,
      required this.topic});

  @override
  State<CustomContentTaskWidget> createState() =>
      _CustomContentTaskWidgetState();
}

class _CustomContentTaskWidgetState extends State<CustomContentTaskWidget> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      dateController.text = widget.task!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Text(
                  widget.isEdit ? 'Edit Task' : 'Create New Task',
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
              backgroundColor: Colors.grey.withOpacity(.2),
              textInputAction: TextInputAction.newline,
              maxLines: 4,
              minLines: 1,
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              controller: titleController,
            ),
            const SizedBox(height: 10),
            CustomTextFieldRoundedBorder(
              labelText: 'Due Date',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter date';
                }
                return null;
              },
              backgroundColor: Colors.grey.withOpacity(.2),
              textColor: Colors.teal,
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
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
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              child: CustomTextButton(
                text: 'Save Task',
                isTenRounded: true,
                textSize: 18,
                buttonColor: mainColor,
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    autovalidateMode = AutovalidateMode.always;
                    return;
                  }

                  final now = DateTime.now().millisecondsSinceEpoch;
                  final random = Random();

                  TaskCardModel task = TaskCardModel(
                      title: titleController.text,
                      date: dateController.text,
                      status: widget.task?.status ?? 0,
                      createTime: widget.task?.createTime ?? now.toString(),
                      key: widget.isEdit
                          ? widget.task?.key ?? '$now-${random.nextInt(10000)}'
                          : '$now-${random.nextInt(10000)}');

                  if (widget.isEdit) {
                    await BlocProvider.of<EditTaskCubit>(context).editTask(
                      task: task,
                    );

                    if (!context.mounted) return;
                    Navigator.pop(context, 'refresh');
                  } else {
                    await BlocProvider.of<AddNewTaskCubit>(context)
                        .addTask(task);

                    if (!context.mounted) return;
                    Navigator.pop(context, task);
                  }
                },
              ),
            ),
            if (widget.isEdit)
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                child: CustomTextButton(
                  text: 'Delete Task',
                  isTenRounded: true,
                  textSize: 18,
                  buttonColor: Colors.red.withOpacity(.8),
                  onPressed: () async {
                    await BlocProvider.of<EditTaskCubit>(context)
                        .deleteTask(task: widget.task!);

                    if (!context.mounted) return;
                    Navigator.pop(context, 'refresh');
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
