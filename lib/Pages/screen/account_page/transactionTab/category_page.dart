import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Category"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color(0xFF080226),
                  border: Border.all(color: AppColors.primaryColor,width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/icon/categoryIcon/restaurant.png"),
                  const SizedBox(width: 10,),
                  const Text(
                    "Restaurant",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
