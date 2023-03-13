// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:thinkthat/Services/downloadImage.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/ImageScreen/ImageScreen.dart';
import 'package:http/http.dart' as http;

class ImageOnTapLayout extends StatefulWidget {
  ImageOnTapLayout({
    super.key,
    required this.post,
    this.isHomeImage = false,
    this.isGalleryImage = false,
    this.isPop = false,
    required this.color,
  });
  final Color color;
  final bool isHomeImage;
  bool isGalleryImage;
  final Post post;
  bool isPop;

  @override
  State<ImageOnTapLayout> createState() => _ImageOnTapLayoutState();
}

class _ImageOnTapLayoutState extends State<ImageOnTapLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: widget.isHomeImage && !widget.isPop
              ? () {
                  Get.to(
                      ImageScreen(
                        post: widget.post,
                        isCreateImage: true,
                        isGalleryImage: widget.isGalleryImage,
                      ),
                      transition: Transition.cupertino);
                }
              : () {
                  Navigator.pop(context);
                },
          child: Container(
            color: Colors.black,
            child: widget.isGalleryImage
                ? Image.network(
                    widget.post.imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: widget.isHomeImage ? BoxFit.contain : BoxFit.cover,
                  )
                : Image.memory(
                    base64.decode(widget.post.imageUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: widget.isHomeImage ? BoxFit.cover : BoxFit.contain,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (widget.isHomeImage && !widget.isGalleryImage) || !widget.isPop
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(CupertinoIcons.down_arrow),
                      onPressed: () async {
                        if (widget.isGalleryImage) {
                          final response =
                              await http.get(Uri.parse(widget.post.imageUrl));

                          final bytes = response.bodyBytes;
                          final uint8list = Uint8List.fromList(bytes);
                          await downloadImage(uint8list, widget.post.prompt);
                        } else {
                          await downloadImage(
                              base64.decode(widget.post.imageUrl),
                              widget.post.prompt);
                        }
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.clear),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class MyNetworkImage extends StatelessWidget {
  final String imageUrl;
  const MyNetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(imageUrl), context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(imageUrl);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
