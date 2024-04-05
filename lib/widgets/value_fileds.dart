
import 'package:flutter/material.dart';

/// DELETEEEE
class TextWidgetField extends StatelessWidget {
  const TextWidgetField({
    super.key,
    required this.label, required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child:  Row(
        children: [
          Text(label,
          style: const TextStyle(
            color:  Color(0xff414244),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
          const SizedBox(width: 10,),
          Text(value,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        ]
      ),
    );
  }
}