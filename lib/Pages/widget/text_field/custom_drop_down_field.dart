import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class CustomDropdownField<T extends Object> extends StatelessWidget {
  final String? text;
  final T? value;
  final String? labelText;
  final String? hintText;
  final EdgeInsetsGeometry? padding;
  final List<T> items;

  // final String Function(T value) textConv;
  final void Function(T? value)? onChanged;
  final String? Function(T? value)? validator;
  final bool readOnly;

  const CustomDropdownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.text,
    required this.value,
    this.padding,
    this.labelText,
    this.hintText,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<T>(
        dropdownColor: AppColors.backgroundColors,
        isExpanded: true,
        validator: validator,
        icon: const Icon(
          Icons.arrow_drop_down_outlined,
          size: 30,
          color: AppColors.secondaryColor,
        ),
        value: items.where((element) => element == value).isNotEmpty
            ? value
            : null,
        items: readOnly
            ? null
            : items.isEmpty
                ? null
                : items.toSet().toList().map((e) {
                    return DropdownMenuItem(
                      value: e,
                      enabled: true,
                      child: Text(
                        e.toString(),
                        style: AppFont.textFieldText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
        onChanged: onChanged,
        style: AppFont.textFieldText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppFont.textFieldText,
            label: Text(labelText ?? ""),
            labelStyle: AppFont.textFieldLabelText,
            fillColor: AppColors.containerColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 2, color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
