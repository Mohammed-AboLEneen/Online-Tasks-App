import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_app/constents.dart';

import '../../../../../cores/utlis/app_fonts.dart';
import '../../../data/models/task_card_model.dart';
import '../../manager/home_page_cubit/home_page_cubit.dart';

class CustomTaskCard extends StatefulWidget {
  final TaskCardModel taskCardModel;

  const CustomTaskCard({super.key, required this.taskCardModel});

  @override
  State<CustomTaskCard> createState() => _CustomTaskCardState();
}

class _CustomTaskCardState extends State<CustomTaskCard> {
  late bool status;

  @override
  void initState() {
    super.initState();
    status = widget.taskCardModel.status == 1 ? true : false;
  }

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
                  widget.taskCardModel.title,
                  style: AppFonts.textStyle20Bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Due Date: ${widget.taskCardModel.date}',
                  style: AppFonts.textStyle15Regular,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<HomePageCubit>(context)
                  .changeTaskStatus(widget.taskCardModel)
                  .then((value) {
                setState(() {
                  status = !status;
                });
              });
            },
            child: CircleAvatar(
              backgroundColor: widget.taskCardModel.status == 1
                  ? mainColor
                  : mainColor.withOpacity(.1),
              child: FaIcon(FontAwesomeIcons.check,
                  color: widget.taskCardModel.status == 1
                      ? Colors.white
                      : mainColor.withOpacity(.5)),
            ),
          )
        ],
      ),
    );
  }
}
