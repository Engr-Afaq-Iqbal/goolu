import 'package:flutter/material.dart';

import '../Utils/dimensions.dart';
import '../Utils/utils.dart';

class AppBoxDesign extends StatelessWidget {
  final Column column;
  final double horizontalMargin;
  const AppBoxDesign(
    this.column, {
    super.key,
    this.horizontalMargin = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: SizesDimensions.width(horizontalMargin),
          vertical: SizesDimensions.height(1)),
      padding: EdgeInsets.symmetric(
          vertical: SizesDimensions.height(2),
          horizontal: SizesDimensions.width(3)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
          color: Theme.of(context).colorScheme.surfaceContainer,
          boxShadow: customBoxShadow(opacity: 0.1, context: context)),
      child: column,
    );
  }
}
