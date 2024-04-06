import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/home/home.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Lets Get You Started",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(radius: 80),
              const SizedBox(
                height: 20,
              ),

              const Text(
                "What are your interests?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),


              ///   PLACE WIDGET HERE

              LargeButton(
                  label: "Save",
                  onTap: () {
                    Get.to(() => Home());
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
