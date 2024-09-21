import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/add_transaction_page.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import 'widget/custom_widget/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const TransactionPage(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          backgroundColor: const Color(0xFF05376C),
          child: const Icon(
            Icons.add_outlined,
            size: 32.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fahis ",
                    style: AppFont.buttonText,
                    maxLines: 1,
                  ),
                  const CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    child: Icon(Icons.account_circle_outlined,color: Colors.white,size: 30),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: CustomCard(
                        color1: const Color(0x24EAEAEA),
                        color2: const Color(0x800A015D),
                        padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance', style: AppFont.cardTitle),
                            const Spacer(),
                            Text('\u{20B9} 79564', style: AppFont.cardMainText),
                            const SizedBox(height: 10,),
                            const Row(
                              children: [
                                SizedBox(width: 10,),
                                Text("\u{20B9} 945.00",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF007505))),
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomCard(
                          color1: const Color(0x24EAEAEA),
                          // color2: Color(0x80004212),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Center content vertically
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Income",
                                      style: AppFont.cardTitle,
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Icon(
                                        Icons.arrow_outward,
                                        // Use the appropriate icon
                                        color: Colors.white, // Icon color
                                        size: 20, // Icon size
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '\u{20B9} 6253',
                                  textAlign: TextAlign.center,
                                  style: AppFont.subCardMainText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomCard(
                          color1: const Color(0x24EAEAEA),
                          // color2: Color(0x79490000),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Center content vertically
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Expense",
                                      style: AppFont.cardTitle,
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Transform.rotate(
                                        angle: 3.5,
                                        child: const Icon(
                                          Icons.arrow_outward,
                                          // Use the appropriate icon
                                          color: Colors.white, // Icon color
                                          size: 20, // Icon size
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '\u{20B9} 6253',
                                  textAlign: TextAlign.center,
                                  style: AppFont.subCardMainText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }
}
