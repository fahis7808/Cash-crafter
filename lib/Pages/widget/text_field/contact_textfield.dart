import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class ContactField extends StatelessWidget {
  final String? hintText;
  final void Function(Contact) onSelected;
  final List<Contact> contact;
  final String? value;
  const ContactField({Key? key, this.hintText, required this.onSelected, required this.contact, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<Contact>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Contact>.empty();
        }
        return contact.where((Contact contact) {
          return contact.displayName
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: onSelected,
      optionsViewBuilder: (context, onSelected, options){
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.secondaryColor,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: Text(
                      option.displayName,
                      style: AppFont.white20,
                    ),
                    subtitle: Text(
                      option.phones.isNotEmpty ? option.phones.first.number : '',
                      style: AppFont.text16,
                    ),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
      displayStringForOption: (Contact option) => option.displayName,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        if (value != null && controller.text.isEmpty) {
          controller.text = value!;
        }
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: AppFont.textFieldText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppFont.textFieldLabelText,
            fillColor: AppColors.containerColor,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
    );
  }
}
