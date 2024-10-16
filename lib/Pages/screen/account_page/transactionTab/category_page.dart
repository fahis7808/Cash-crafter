import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/category_data.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Category"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: categoryData.map((e) =>  Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFF080226),
                  border: Border.all(color: AppColors.primaryColor,width: 2),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 20,
                      child: Image.asset("assets/icon/categoryIcon/${e["image"]}")),
                  const SizedBox(width: 10,),
                   Text(
                    e["name"].toString(),
                    style: const TextStyle(
                        fontSize: 17,
                        color: AppColors.textColor,
                        ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }
}
