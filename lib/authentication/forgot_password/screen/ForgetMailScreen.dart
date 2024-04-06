import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/LargeButton.dart';

class ForgetMailScreen extends StatefulWidget {
  const ForgetMailScreen({super.key});

  @override
  State<ForgetMailScreen> createState() => _ForgetMailScreenState();
}

class _ForgetMailScreenState extends State<ForgetMailScreen> {
  final _resetEmailTextController = TextEditingController();

  Future sendResetPasswordLink() async {
    showDialog(context: context,
        builder:(context) =>  const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _resetEmailTextController.text.trim());
      Get.snackbar("Link Sent", "A resent link was sent to your mail",
          snackPosition: SnackPosition.BOTTOM);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _resetEmailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 180,
                  ),
                  const Text("Forgot Password",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                  const Text(
                      "Enter the email a verification link will be sent to",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                      child: Column(
                    children: [
                      //   ENTER E-MAIL TXT FIELD
                      TextFormField(
                        controller: _resetEmailTextController,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: const Text("E-mail"),
                          prefixIcon: const Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //    NEXT BTN
                      LargeButton(
                        label: "Send link",
                        onTap: () {
                          sendResetPasswordLink();
                        },
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
