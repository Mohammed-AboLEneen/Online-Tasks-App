import 'package:flutter/material.dart';
import 'package:todo_list_app/constents.dart';

import 'custom_textbutton.dart';

class SegmentButtonList extends StatefulWidget {
  const SegmentButtonList({super.key});

  @override
  State<SegmentButtonList> createState() => _SegmentButtonListState();
}

class _SegmentButtonListState extends State<SegmentButtonList> {

  List<String> titles = [

    'All',
    'Not Done',
    'Done',
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: titles.asMap().entries.map((e) => Padding(
        padding: const EdgeInsets.only(right: 5),
        child: GestureDetector(
          onTap: (){

            setState(() {
              index = e.key;
            });
          },
          child: SizedBox(
              height: 35,
              child: CustomTextButton(text: e.value, textColor: e.key == index ? Colors.white : mainColor,buttonColor: e.key == index ? mainColor : mainColor.withOpacity(.1), isTenRounded: false, textSize: 13,)),
        ),
      )).toList(),
    );
  }
}
