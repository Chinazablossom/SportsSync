import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget{
  const DiscoverScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffc5cbce),
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset("assets/imgs/discover.png",height: 700,width: 700,)
          ],
        ),
      ),
    );
  }

}