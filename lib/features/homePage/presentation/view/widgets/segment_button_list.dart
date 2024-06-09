import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/constents.dart';

import '../../manager/home_page_cubit/home_page_cubit.dart';
import '../../../../../cores/widgets/custom_textbutton.dart';

class SegmentButtonList extends StatefulWidget {
  const SegmentButtonList({super.key});

  @override
  State<SegmentButtonList> createState() => _SegmentButtonListState();
}

class _SegmentButtonListState extends State<SegmentButtonList> {
  List<String> titles = ['All', 'Not Done', 'Done', 'Waiting'];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: titles
          .asMap()
          .entries
          .map((e) => Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<HomePageCubit>(context)
                        .changeTasksTopic(e.key);

                    setState(() {
                      index = e.key;
                    });
                  },
                  child: SizedBox(
                      height: 35,
                      child: CustomTextButton(
                        text: e.value,
                        textColor: e.key == index ? Colors.white : mainColor,
                        buttonColor: e.key == index
                            ? mainColor
                            : mainColor.withOpacity(.1),
                        isTenRounded: false,
                        textSize: 13,
                      )),
                ),
              ))
          .toList(),
    );
  }
}
