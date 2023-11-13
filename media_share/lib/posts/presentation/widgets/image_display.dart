import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({this.imageFile, this.imageUrl, super.key});

  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageFile != null
        ? Image.file(
            imageFile!,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return frame == null? Container(
                height: size.height * 0.6,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):child;
            },
          )
        : Image.network(
            imageUrl!,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return  frame == null?Container(
                height: size.height * 0.6,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ):child;
            },
          );
  }
}
