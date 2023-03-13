// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:thinkthat/Models/PromptModel.dart';
import 'package:thinkthat/Screens/Components/Imagetap.dart';

class ImageScreen extends StatefulWidget {
  final bool isCreateImage;
  final bool isGalleryImage;
  final Post? post;

  const ImageScreen(
      {this.isGalleryImage = false, this.isCreateImage = false, this.post});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: widget.isCreateImage && !widget.isGalleryImage
              ? ImageOnTapLayout(
                  post: widget.post!,
                  isPop: true,
                  color: Colors.transparent,
                )
              : ImageOnTapLayout(
                  isHomeImage: true,
                  isGalleryImage: true,
                  isPop: true,
                  post: widget.post!,
                  color: Colors.black)),
    );
  }
}
