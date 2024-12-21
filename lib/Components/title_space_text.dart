import 'package:flutter/material.dart';

import '../Utils/font_styles.dart';

class TitleSpaceTxt extends StatelessWidget {
  final String? title;
  final String? txt;
  const TitleSpaceTxt({super.key, this.title, this.txt});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customText(
          text: '$title',
          textStyle: regular14NavyBlue.copyWith(
            color: Theme.of(context).iconTheme.color,
          ),
          maxLines: 2,
          textAlign: TextAlign.start,
        ),
        // Directionality(
        //   textDirection: TextDirection.ltr,
        //   child: customText(
        //     text: '$txt',
        //     textStyle: bold14NavyBlue,
        //     maxLines: 2,
        //     textAlign: TextAlign.end,
        //   ),
        // ),
        customText(
          text: '$txt',
          textStyle: bold14NavyBlue.copyWith(
            color: Theme.of(context).iconTheme.color,
          ),
          maxLines: 2,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
