// Cotains Code to Open Device Camera, Take Image
// and Pass it to add_place.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;

  // Function to Open Camera and Take Picture
  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    //You can also use Gallery
    //pickImage() Function returns and XFile i.e. a Future
    //Therefore we use async and await

    if (pickedImage == null) {
      //Camera is closed without taking image
      return;
    }

    // To Show the Image
    setState(() {
      _takenImage = File(pickedImage.path);
    });

    widget.onPickImage(_takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: Text("Take Picture"),
      onPressed: _takePicture,
    );

    if (_takenImage != null) {
      // Using GesturDetector to make Image Tapable
      // To Change current Image with Another
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: content,
    );
  }
}
