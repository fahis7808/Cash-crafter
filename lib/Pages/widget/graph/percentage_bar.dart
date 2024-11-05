import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

class PercentageBar extends StatelessWidget {
  final double percentage1; // First percentage value
  final double percentage2; // Second percentage value

  const PercentageBar({
    Key? key,
    required this.percentage1,
    required this.percentage2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double parentWidth = constraints.maxWidth;
            double percentage2Width = percentage2 - percentage1;
            double barHeight = 18;
            double borderRadius = 5;
            return Container(
              width: parentWidth,
              height: barHeight,
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Row(
                children: [
                  // First percentage bar segment
                  Container(
                    width: parentWidth * (percentage1 / 100),
                    height: barHeight,
                    decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                  ),
                  if (percentage2Width > 0)
                    Container(
                      width: parentWidth * (percentage2Width / 100),
                      height: barHeight,
                      decoration: BoxDecoration(
                          color: AppColors.barBackground,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(borderRadius),
                              bottomRight: Radius.circular(borderRadius))),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
