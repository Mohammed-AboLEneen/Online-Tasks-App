import 'package:flutter/material.dart';
import 'package:todo_list_app/cores/widgets/custom_textbutton.dart';
import 'package:todo_list_app/features/homePage/presentation/view/widgets/custom_task_card.dart';

import '../../../../constents.dart';
import '../../../../cores/utlis/app_fonts.dart';
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
            SegmentButtonList(),
            const SizedBox(
              height: 20,
            ),
            CustomTaskCard(),
            const Spacer(),
            SizedBox(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              child: CustomTextButton(
                text: 'Create Task',
                isTenRounded: true,
                textSize: 18,
                buttonColor: mainColor,
              ),
            )
          ],
        ),
      )),
    );
  }
}
