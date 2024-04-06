import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/controllers/Sign_Up_Controller.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_Up_phone_verification_OTP.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

import '../../controllers/mail_verification_controllers.dart';

class SignUpVerificationEmailScreen extends StatelessWidget {
  const SignUpVerificationEmailScreen({super.key, required this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final mailController = Get.put(MailVerificationController());

    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Icon(
                Icons.mark_email_read_outlined,
                size: 170,
              ),
              const Text(
                "Lets Verify Your Email adrress",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                "We Sent a verification link to $email, Please check your email and click on the link we sent to verify your email adrress",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 50,
              ),

              //  CONTINUE BTN
              GestureDetector(
                onTap: () {
                  mailController.manualVerificationLinkChecker();


                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Show CircularProgressIndicator when loading
                      Obx(() => Visibility(
                        visible: (mailController.isLoading.value),
                        child: const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      )),
                      const SizedBox(width: 10),
                      const Text("Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            /*  LargeButton(
                  label: "Continue",
                  onTap: () async {
                    mailController.manualVerificationLinkChecker();
                  }),
*/





              const SizedBox(
                height: 50,
              ),

              //   RESEND VERIFICATION LINK BTN
              TextButton(
                onPressed: () {
                  mailController.sendEmailVerificationLink();
                },
                child: const Text(
                  "Resend Verification Link",
                  style: TextStyle(color: Color(0xff3850c9), fontSize: 18),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // BACK TO AUTHENTICATION SCREEN
              TextButton(
                onPressed: () {
                  AuthenticationRepository.instance.logOutUser();
                },
                child: const Text(
                  "<- Back to Login",
                  style: TextStyle(color: Color(0xff3850c9), fontSize: 18),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
