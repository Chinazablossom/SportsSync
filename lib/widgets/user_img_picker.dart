/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.radius});

  final double radius;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  void _pickImg() async {
    final pickedImg = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (pickedImg == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImg!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),

        const SizedBox(
          height: 30,
        ),



        ///  TXT BTN
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeButton(
              label: "Add Image",
              onTap: () {
                _pickImg();
              },
            ),


          ],
        ),
      ],
    );
  }
}
*/
