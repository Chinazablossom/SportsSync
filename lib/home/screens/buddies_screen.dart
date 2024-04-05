import 'package:flutter/material.dart';

class BuddiesScreen extends StatelessWidget{
  const BuddiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [
            Image.asset("assets/imgs/buddies.png",height: 700,width: 700,)
        ],
      ),
    );
  }

}