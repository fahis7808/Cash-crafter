import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import '../../constant/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? value;
  final String? text;
  final String? labelText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? hintText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? padding;
  final bool readOnly;
  final bool isPassWord;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final void Function()? onEditingComplete;
  final String? Function(String? value)? validator;

  const CustomTextField(
      {super.key,
        this.text,
        this.suffixIcon,
        this.prefixIcon,
        this.labelText,
        this.hintText,
        this.suffix,
        this.padding,
        this.keyboardType,
        this.readOnly = false,
        this.isPassWord = false,
        this.onChanged,
        this.onSaved,
        this.onEditingComplete,
        required this.value,
        this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value ?? "";
    controller.selection =
        TextSelection(baseOffset: 0, extentOffset: controller.text.length);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.text != widget.value) {
        controller.text = widget.value?.toString() ?? "";
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.text != null
            ? Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(widget.text ?? "", style: AppFont.textFieldLabel),
          ],
        )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: widget.keyboardType,
          style: AppFont.textFieldText,
          readOnly: widget.readOnly,
          obscureText: widget.isPassWord,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 13),
              label: Text(widget.labelText ?? ""),
              labelStyle: TextStyle(fontSize: 12),
              fillColor: AppColors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: widget.padding ??
                  const EdgeInsets.symmetric(vertical: 23, horizontal: 10),
              suffixIcon: widget.suffix,
              enabledBorder: OutlineInputBorder(
                  borderSide: widget.labelText == null
                      ? BorderSide.none
                      : const BorderSide(
                      width: 1, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                borderSide: widget.labelText == null
                    ? BorderSide.none
                    : const BorderSide(width: 2, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(30),
              )),
        )
      ],
    );
  }
}
