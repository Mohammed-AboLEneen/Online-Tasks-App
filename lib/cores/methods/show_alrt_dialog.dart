import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context, Widget content) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * .5 < 400
              ? 400
              : MediaQuery.sizeOf(context).width * .5,
          child: AlertDialog(
            content: content,
          ),
        ),
      );
    },
  );
}
