import 'package:flutter/material.dart';
import 'package:sports_sync/authentication/model/intrest_model.dart';
import 'package:sports_sync/widgets/intrests_item.dart';

class InterestListBuilder extends StatelessWidget {
  const InterestListBuilder(this.interests,
          {super.key,});

  final List<Interest> interests;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: interests.length,
        itemBuilder: (ctx, index) => InterestItem(interest: interests[index])

    );
  }
}