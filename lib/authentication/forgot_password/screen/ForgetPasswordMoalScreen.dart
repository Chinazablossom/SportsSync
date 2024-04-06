import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ForgetMailScreen.dart';
import '../../../widgets/ForgotPasswordButton.dart';
import 'ForgotPhoneScreen.dart';


class ForgetPasswordScreen{

 static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,backgroundColor: const Color(0xffdae1e5),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select a method",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text("how do we send you the reset password link?",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: 40,
            ),
            ForgotPasswordButton(
                icon: const Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgetMailScreen());

                }),
            const SizedBox(
              height: 35,
            ),
            ForgotPasswordButton(
                icon: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgetPhoneScreen());
                }),
          ],
        ),
      ),
    );
  }

}