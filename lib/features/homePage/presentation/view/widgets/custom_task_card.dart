import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/constents.dart';

import '../../../../../cores/utlis/app_fonts.dart';

class CustomTaskCard extends StatelessWidget {
  const CustomTaskCard({super.key});

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
            blurRadius: 2.5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Name',
                style: AppFonts.textStyle20Bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Task Name',
                style: AppFonts.textStyle15Regular,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            backgroundColor: mainColor.withOpacity(.1),
            child: FaIcon(FontAwesomeIcons.check,
                color: mainColor.withOpacity(.5)),
          )
        ],
      ),
    );
  }
}
