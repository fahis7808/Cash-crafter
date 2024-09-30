import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

class AmountTextField extends StatefulWidget {
  final String? value;
  final void Function(String)? onChange;


  const AmountTextField({Key? key, required this.value, this.onChange}) : super(key: key);

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
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
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 9, right: 10),
          child: Text(
            "\u{20B9}",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor),
          ),
        ),
        SizedBox(
          width: 160,
          child: TextFormField(
            onChanged: widget.onChange,
            controller: controller,
            style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
