import 'package:flutter/material.dart';

class IncomeExpanceCard extends StatelessWidget {

 final String value;
 final String text;
 final IconData iconData;
 final Color iconcColor;


 IncomeExpanceCard({
   required this.value,
   required this.text,
   required this.iconData,
   required this.iconcColor,
});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding:const EdgeInsets.all(
            6.0,
          ),
          margin:const EdgeInsets.only(
            right: 8.0,
          ),
          child: Icon(
            iconData,
            size: 28.0,
            color: iconcColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.white70,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
