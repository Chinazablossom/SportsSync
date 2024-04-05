

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'OTP_Screen.dart';

class ForgetPhoneScreen extends StatelessWidget{


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
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: "Enter your phone number",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      ),keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty ) {
                          return "Field cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // _userPassword = value!;
                      },
                    ),

                    const SizedBox(height: 30,),




                    //    NEXT BTN
                    GestureDetector(
                      onTap: () {
                      //  Get.to(() => OTPScreen());
                      } ,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text("Next",
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