import 'package:flutter/material.dart';
import 'package:sports_sync/widgets/intrests_item.dart';
import 'package:sports_sync/widgets/user_img_picker.dart';

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
            child:  const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Lets Get You Started",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  //UserImagePicker(radius: 80),
                  SizedBox(height: 20,),

                  Text(
                    "What are your interests?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  //InterestItem(interest: "Basketball"),



                ]),
          ),
        ),
      ),
    );
  }
}
