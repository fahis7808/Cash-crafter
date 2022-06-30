import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {

  final IconData buttonIcon;
  final String textHint;
  final void Function(String) textAction;
  final TextInputType textKeyboard;



  TransactionWidget({
    required this.buttonIcon,
    required this.textHint,
    required this.textAction,
    required this.textKeyboard,
});



  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D764D),
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          padding: const EdgeInsets.all(
            12.0,
          ),
          child: Icon(
            buttonIcon,
            size: 24.0,
            // color: Colors.grey[700],
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: textHint,
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 20.0,
            ),
            onChanged: textAction,
            keyboardType: textKeyboard,
          ),
        ),
      ],
    );
  }
}
