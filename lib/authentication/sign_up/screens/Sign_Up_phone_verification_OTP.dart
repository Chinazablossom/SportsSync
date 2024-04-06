import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/controllers/OTP_controller.dart';

import '../../../widgets/LargeButton.dart';
import '../../controllers/Sign_Up_Controller.dart';

class SignUpPhoneVerificationOTP extends StatelessWidget {
  const SignUpPhoneVerificationOTP({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    var otp;

    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Icon(Icons.phone_android_outlined, size: 170),
                //"OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80 )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    "Lets Verify your phone number, Enter the code sent to ${signUpController.signUpPhoneNumber.text}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700)),

                const SizedBox(
                  height: 50,
                ),

                OtpTextField(
                  keyboardType: TextInputType.number,
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    otp = code;
                    OTPController.instance.verifyOTPSignUp(otp);
                  },
                ),
                const SizedBox(
                  height: 50,
                ),

                //  VERIFICATION BTN
                LargeButton(
                    label: "Verify",
                    onTap: () {
                      OTPController.instance.verifyOTPSignUp(otp);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
