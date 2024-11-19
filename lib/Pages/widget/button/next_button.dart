import 'package:flutter/cupertino.dart';
import 'package:cash_crafter/constant/app_colors.dart';
import 'package:cash_crafter/constant/app_font.dart';

class NextButton extends StatelessWidget {
  final void Function() onTap;
  const NextButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 100,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Center(child: Text("Next",style: AppFont.white20,)),
      ),
    );
  }
}
