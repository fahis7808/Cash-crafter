import 'package:flutter/material.dart';
import '../../../constant/app_colors.dart';

class AmountTextField extends StatefulWidget {
  final double? value;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  const AmountTextField({Key? key, this.value, this.onChange, this.validator})
      : super(key: key);

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.value?.toString() ?? "0";
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
    return SizedBox(
      width: 200,
      height: 60,
      child: TextFormField(
        onChanged: widget.onChange,
        controller: controller,
        validator: widget.validator,
        style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColors.white),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          isDense: true,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("\u{20B9}",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor)),
          ),
          contentPadding: EdgeInsets.only(left: 0,right: 10,top: 0),
          hintText: "0.0",
          hintStyle: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: AppColors.cardColor),
          border: InputBorder.none,

        ),
      ),
    );
  }
}
