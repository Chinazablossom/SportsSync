import 'package:flutter/material.dart';
import 'package:sports_sync/authentication/model/intrest_model.dart';

class InterestItem extends StatelessWidget {
  const InterestItem({super.key, required this.interest});
  final Interest interest ;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(1.0), //.withOpacity(_opacity!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(9),
      child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
            onTap: () {
              /// ADD TO USER DATA
            },
            child: Text(
              interest.title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
            )),
      ),
    );
  }
}
