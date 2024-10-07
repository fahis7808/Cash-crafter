import 'package:flutter/material.dart';
import 'package:money_manage_app2/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_colors.dart';
import '../../../util/snack_bar.dart';
import '../home_screen/home_page.dart';

class GoogleFBButton extends StatelessWidget {
  const GoogleFBButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<AuthenticationProvider>(context,listen: false);
    return  Row(
      children: [
        GoogleFBCard(
          name: "Google",
          onTap: () {
            data.signInWithGoogle().then((value) {
              if (value == "Signed on Google") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
              } else {
                final snackBar =
                CustomSnackBar.errorSnackBar(value);
                ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar);
              }
            });
          },
        ),
        const SizedBox(
          width: 10,
        ),
        GoogleFBCard(
          name: "Facebook",
          onTap: () {
            data.signInWithFacebook();
          },
        )
      ],
    );
  }
}
class GoogleFBCard extends StatelessWidget {
  final String name;
  final void Function() onTap;

  const GoogleFBCard({Key? key, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.cardColor, width: 2)),
            child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ))),
      ),
    );
  }
}
