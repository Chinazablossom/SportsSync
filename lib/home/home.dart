import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'controller/NavigationController.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());


    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      bottomNavigationBar: Obx(
        () => GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.white.withOpacity(0.1),
            gap: 10,
            selectedIndex: controller.selectedIndex.value ,
            onTabChange: (index) => controller.selectedIndex.value = index,
            tabs:
            const [
              GButton(icon: Icons.people_outline_sharp, text: "Buddies", ),
              GButton(icon: Icons.language_rounded, text: "Discover",     ),
              GButton(icon: Icons.settings, text: "Settings",   ),
              GButton(icon: Icons.person, text: "Profile",   ),
            ]),
      ),
      body: Expanded(child: Obx(() => controller.screens[controller.selectedIndex.value])),

    );
  }

}














