import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/home/controller/profile_controller.dart';

import '../../widgets/value_fileds.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());


    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future: controller.getUserDate(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {

                      UserModel userData = snapshot.data as UserModel;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //    HEADER TXT
                          const Text(
                            "User Profile",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // USER PROFILE IMAGE
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 30),

                          Form(
                            child: Column(
                              children: [


                                //    USER-NAME TXT FIELD
                                TextWidgetField(
                                  value: userData.userName,label:"User Name" ,
                                ),

                                const SizedBox(height: 20),

                                //    USER-EMAIL TXT FIELD
                                TextWidgetField(
                                  value: userData.userEmail,label:"Email" ,
                                ),
                                const SizedBox(height: 20),


                                //    USER PHONE-NUMBER TXT FIELD
                              TextWidgetField(
                                value: userData.userPhoneNumber,label:"Phone Number" ,
                              ),

                                const SizedBox(height: 40),

                                const Text(
                                  "Interests",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                //  LIST OF INTERESTS


                              ],
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //    HEADER TXT
                          const Text(
                            "User Profile",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // USER PROFILE IMAGE
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 30),

                          const Form(
                            child: Column(
                              children: [


                                //    USER-NAME TXT FIELD
                                TextWidgetField(
                                  value: "null",label:"User Name" ,
                                ),

                                SizedBox(height: 20),

                                //    USER-EMAIL TXT FIELD
                                TextWidgetField(
                                  value: "null",label:"Email" ,
                                ),
                                SizedBox(height: 20),


                                //    USER PHONE-NUMBER TXT FIELD
                                TextWidgetField(
                                  value: "null",label:"Phone Number" ,
                                ),

                                SizedBox(height: 40),

                                Text(
                                  "Interests",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                //  LIST OF INTERESTS



                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },

              ),),
        ),
      ),
    );
  }
}
