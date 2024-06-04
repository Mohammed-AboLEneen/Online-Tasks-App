import 'package:flutter/material.dart';
import 'package:todo_list_app/cores/widgets/custom_textbutton.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/create_task_bottom_widget.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/custom_task_card.dart';

import '../../../../constents.dart';
import '../../../../cores/utlis/app_fonts.dart';
import '../../../../cores/widgets/custom_textfield_rounded_border.dart';
import '../../../../cores/widgets/segment_button.dart';
import '../../../../cores/widgets/sliver_sizedbox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(right: 20, left: 20, top: 25, bottom: 10),
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
            const CustomTaskCard(),
            const Spacer(),
            const CreateTaskButtonWidget()
          ],
        ),
      )),
    );
  }
}
