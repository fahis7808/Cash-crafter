import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/profile_Provider.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
        child: Consumer<ProfileProvider>(
          builder: (context,data,_) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.containerColor,
                      child: Text(
                        "F",
                        style: AppFont.text25,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                     CustomTextField(
                      value: data.userData.username,
                      labelText: "Name",
                     prefixIcon: FluentIcons.person_12_regular,
                      // suffix: edit(),
                       onChanged: (val){
                        data.userData.username = val;
                       },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     CustomTextField(
                      value: data.userData.phone,
                      labelText: "Number",
                      prefixIcon: FluentIcons.phone_16_regular,
                      // suffix: edit(),
                       keyboardType: TextInputType.number,
                       onChanged: (val){
                        data.userData.phone = val;
                       },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     CustomTextField(
                      value: data.userData.email,
                      labelText: "E-mail",
                      prefixIcon: FluentIcons.mail_12_regular,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     CustomTextField(
                      value: data.userData.job,
                      labelText: "Job",
                      prefixIcon: FluentIcons.briefcase_32_regular,
                      // suffix: edit(),
                       onChanged: (val){
                        data.userData.job = val;
                       },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        buttonText: "Update",
                        onPressed: () {
                          data.getData();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => HomePage()));
                        })
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  Widget edit(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
      child: Text("Edit",style: AppFont.textFieldLabelText,),
    );
  }
}
