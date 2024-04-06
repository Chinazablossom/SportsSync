import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

import '../../controllers/OTP_controller.dart';

class ForgetPasswordOTPModal{

  var otp;
   Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,backgroundColor: const Color(0xffdae1e5),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter the 6 digit OTP",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
               const SizedBox(
              height: 40,
            ),


            OtpTextField(
              keyboardType: TextInputType.number,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                OTPController.instance.verifyOTPForgotPassword(otp);
              },
            ),
            const SizedBox(height: 50,),



            //  VERIFICATION BTN
            LargeButton(label: "Verify", onTap: () {
              OTPController.instance.verifyOTPForgotPassword(otp);
            })



          ],
        ),
      ),
    );
  }

}