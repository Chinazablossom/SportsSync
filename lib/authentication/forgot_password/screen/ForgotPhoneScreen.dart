

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

import '../../controllers/Sign_Up_Controller.dart';
import 'forget_password_OTP_modal.dart';

class ForgetPhoneScreen extends StatefulWidget{
  const ForgetPhoneScreen({super.key});



  @override
  State<ForgetPhoneScreen> createState() => _ForgetPhoneScreenState();
}

class _ForgetPhoneScreenState extends State<ForgetPhoneScreen> {

  final signUpController = Get.put(SignUpController());
  final _resetTextTextController = TextEditingController();
  var otp;


  @override
  void dispose() {
    _resetTextTextController.dispose();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 180,),
                const Text("Forgot Password",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
                const Text("Enter the phone number an OTP will be sent to",style: TextStyle(fontSize: 15),textAlign: TextAlign.center ),
                const SizedBox(height: 50,),
                Form(child: Column(
                  children: [


                    //   ENTER PHONE TXT FIELD
                    TextFormField(
                      controller: _resetTextTextController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: const Icon(
                          Icons.phone_android_outlined,
                          color: Colors.black,
                        ),
                        prefixText: "+234",
                        prefixStyle: const TextStyle(
                            color: Colors.black, fontSize: 16),
                        label: const Text("Phone Number"),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      ),
                      keyboardType: TextInputType.phone,
                    ),

                    const SizedBox(height: 30,),



                    //    NEXT BTN
                    GestureDetector(
                      onTap: () {
                      signUpController.phoneAuthentication(_resetTextTextController.text.trim());
                      Get.snackbar("Link Sent", "A resent link was sent to your number");
                      ForgetPasswordOTPModal().buildShowModalBottomSheet(context);
                      } ,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text("Send otp",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ))



              ],
            ),
          ),
        ),
      ),
    );


  }
}