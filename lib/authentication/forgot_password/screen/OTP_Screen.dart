import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130,),
              const Text("OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80 )),
              const Text("Enter the code sent to china@gmail.com",
                  style: TextStyle(fontSize: 16)),

                const SizedBox(height: 50,),

                OtpTextField(
                  keyboardType: TextInputType.number,
                  numberOfFields: 5,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    print("OTP is = $code");
                  },
                ),
                const SizedBox(height: 50,),



                //  VERIFICATION BTN
                LargeButton(label: "Verify", onTap: () {

                })
                





              ],
            ),
          ),
        ),
      ),
    );
  }

}