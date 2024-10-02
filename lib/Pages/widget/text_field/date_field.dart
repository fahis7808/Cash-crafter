import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class CustomDateField extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;
  final String? labelText;
  final String? value;
  final IconData? prefixIcon;
  final void Function(String val)? onChange;

  const CustomDateField({Key? key, this.onDateSelected, this.labelText, this.onChange, this.value, this.prefixIcon}) : super(key: key);

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return GestureDetector(
      onTap: () => _selectDate(context),
      child: CustomTextField(
        prefixIcon: widget.prefixIcon,
        value: widget.value ?? formattedDate,
        onTap: () => _selectDate(context),
        readOnly: true,
        labelText: widget.labelText,
        onChanged: widget.onChange,
        suffix:widget.prefixIcon == null ? const Icon(
          Icons.calendar_month_outlined,
          color: AppColors.secondaryColor,
          size: 25
        ):null
      ),
      /* child:Text(
        formattedDate,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryColor, // Customize text color
        ),
      ),*/
    );
  }
}

//const Locale locale= Locale("en");
class DatePicker extends StatelessWidget {
  final DateTime? value;
  final DateType type;
  final ValueChanged<DateTime?>? onDateChanged;
  final FormFieldSetter<String>? onSaved;
  final VoidCallback? onEditingComplete;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final bool readOnly;
  final bool canChangeText;
  final String? label;
  final String? dateHintText;
  final String? calendarTitle;
  final String? fieldLabelText;
  final String? fieldHintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool isSuffix;
  final TextEditingController controller;
  final EdgeInsetsGeometry? padding;
  final String? Function(String? value)? validator;

  const DatePicker(
      {Key? key,
      this.firstDate,
      this.lastDate,
      this.initialDate,
      required this.controller,
      this.value,
      this.type = DateType.dmy,
      this.label,
      this.dateHintText,
      this.calendarTitle,
      this.fieldLabelText,
      this.fieldHintText,
      this.initialValue,
      this.focusNode,
      this.decoration,
      this.textInputAction,
      this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.inputFormatters,
      this.onDateChanged,
      this.readOnly = false,
      this.canChangeText = true,
      this.isSuffix = true,
      this.padding,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      controller.text = value!
          .toIso8601String()
          .substring(0, 10)
          .split("-")
          .reversed
          .join("-");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: validator,
          readOnly: readOnly,
          onTap:
              readOnly || canChangeText ? null : () => _showDatePicker(context),
          controller: controller,
          style: AppFont.textFieldText,
          decoration: InputDecoration(
            isDense: true,
            labelText: fieldLabelText,
            hintText: fieldHintText,
            suffixIcon: IconButton(
              onPressed: () => _showDatePicker(context),
              icon: Icon(
                Icons.calendar_month_outlined,
                size: 30,
                color: AppColors.primaryColor,
              ),
            ),
            contentPadding: padding ??
                const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
            labelStyle: AppFont.textFieldLabel,
            fillColor: AppColors.cardColor,
            filled: true,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
          ),
          focusNode: focusNode,
          keyboardType: TextInputType.datetime,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: value ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(1900),
        lastDate:
            lastDate ?? DateTime.now().add(const Duration(days: 365 * 100)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColors.primaryColor,
              colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
              ), // for OK/Cancel buttons
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
    if (pickedDate != null) {
      controller.text = pickedDate.parseString(type) ?? "";
      if (onDateChanged != null) {
        onDateChanged!(pickedDate);
      }
    }
  }
}

extension DateToStringConvert on DateTime? {
  String? parseString(DateType type, {Locale? locale}) {
    DateTime? value = this;
    if (value == null) {
      return '';
    }
    final inputFormat = type.toFormat(locale: locale);
    try {
      return inputFormat.format(value);
    } on Exception catch (_) {
      return null;
    }
  }
}

extension DateTypeExt on DateType {
  DateFormat toFormat({Locale? locale}) {
    switch (this) {
      case DateType.dmy:
        return DateFormat("dd-MM-yyyy", locale?.languageCode);
      case DateType.ymd:
        return DateFormat("yyyy-MM-dd", locale?.languageCode);
      case DateType.Mdy:
        return DateFormat("MMM d, yyyy", locale?.languageCode);
    }
  }
}

enum DateType {
  dmy,
  ymd,
  Mdy,
}
