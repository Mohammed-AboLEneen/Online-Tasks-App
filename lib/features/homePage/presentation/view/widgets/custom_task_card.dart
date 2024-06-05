import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/constents.dart';

import '../../../../../cores/utlis/app_fonts.dart';
import '../../../data/models/task_card_model.dart';

class CustomTaskCard extends StatelessWidget {
  final TaskCardModel taskCardModel;

  const CustomTaskCard({super.key, required this.taskCardModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: .2,
            offset: Offset(0, 1.5), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskCardModel.title,
                  style: AppFonts.textStyle20Bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Due Date: ${taskCardModel.date}',
                  style: AppFonts.textStyle15Regular,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: taskCardModel.status == 0
                ? mainColor.withOpacity(.1)
                : mainColor,
            child: FaIcon(FontAwesomeIcons.check,
                color: taskCardModel.status == 0
                    ? mainColor.withOpacity(.5)
                    : Colors.white),
          )
        ],
      ),
    );
  }
}
