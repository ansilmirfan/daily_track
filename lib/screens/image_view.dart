// ignore_for_file: must_be_immutable, camel_case_types

import 'dart:io';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  String imagepath;
  ImageView({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.1,
          maxScale: 4.0,
          child: Image.file(
            File(imagepath),
          ),
        ),
      ),
    );
  }
}
