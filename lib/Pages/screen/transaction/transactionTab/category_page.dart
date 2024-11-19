import 'package:flutter/material.dart';
import 'package:cash_crafter/Model/category_data.dart';
import 'package:cash_crafter/Pages/widget/button/next_button.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/constant/app_colors.dart';

class CategoryPage extends StatefulWidget {
  final bool isListData;
  final bool isIncome;
  const CategoryPage({Key? key,  this.isListData = false,  this.isIncome = false}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> selectedCategory = [];

  @override
  Widget build(BuildContext context) {
  List<CategoryItem> category = widget.isIncome ?incomeCategoryIcon : expenseCategoryIcon;

    return Scaffold(
      appBar: const CustomAppBar(title: "Category",),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: category.map((e) {

                  bool isSelected = selectedCategory.contains(e.name);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategory.remove(e.name);
                        } else {
                          selectedCategory.add(e.name);
                        }
                        if(!widget.isListData){
                          Navigator.pop(context,e.name);
                        }
                      });
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.secondaryColor
                              : const Color(0xFF080226),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height: 20,
                              child: Image.asset(
                                  "assets/icon/categoryIcon/${e.image}")),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            e.name.toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Spacer(),
            if(widget.isListData)
            Align(
              alignment: Alignment.centerRight,
              child: NextButton(onTap: () {
                Navigator.pop(context,selectedCategory);
              }),
            )
          ],
        ),
      ),
    );
  }
}
