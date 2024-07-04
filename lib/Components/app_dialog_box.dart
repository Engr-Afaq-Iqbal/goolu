import 'package:flutter/material.dart';

Future appDialogBox(BuildContext context,
    {String? dialogTitle, Widget? contentPage}) async {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(dialogTitle ?? ''),
      content: SizedBox(
        width: !isPortrait ? MediaQuery.of(context).size.width * 0.32 : null,
        child: contentPage,
      ),
    ),
  );
}
