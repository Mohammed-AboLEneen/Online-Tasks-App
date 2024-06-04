import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constents.dart';
import '../../../../../cores/methods/show_date_picker.dart';
import '../../../../../cores/utlis/app_fonts.dart';
import '../../../../../cores/widgets/custom_textbutton.dart';
import '../../../../../cores/widgets/custom_textfield_rounded_border.dart';

class CreateTaskButtonWidget extends StatefulWidget {
  const CreateTaskButtonWidget({
    super.key,
  });

  @override
  State<CreateTaskButtonWidget> createState() => _CreateTaskButtonWidgetState();
}

class _CreateTaskButtonWidgetState extends State<CreateTaskButtonWidget> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();

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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
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
                    Text(
                      'Create New Task',
                      style: AppFonts.textStyle20Bold,
                    ),
                    const SizedBox(
                      height: 15,
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
                      c
                      padding: const EdgeInsets.only(left: 20),
                      keyboardType: TextInputType.none,
                      onTap: () async {
                        DateTime? pickedDate =
                            await showDatePickerMethod(context);

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
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
