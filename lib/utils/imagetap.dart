import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/Services/downloadImage.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeImageLayout.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/utils/constant.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageScreen(
                              post: widget.post,
                              isCreateImage: true,
                              isGalleryImage: widget.isGalleryImage,
                            )),
                  );
                }
              : () {
                  // setState(() {
                  //   widget.isPop = true;
                  // });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => ImageScreen(
                  //             post: widget.post,
                  //             isCreateImage: true,
                  //             isGalleryImage: widget.isGalleryImage,
                  //           )),
                  // );
                  Navigator.pop(context);
                },
          child: Container(
            // color: Colors.grey.withOpacity(0.3),
            // color: color,
            // height: double.infinity,
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
              :
              // isHomeImage
              //     ? Container()
              //     :
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.down_arrow),
                      onPressed: () async {
                        if (widget.isGalleryImage) {
                          final response =
                              await http.get(Uri.parse(widget.post.imageUrl));

                          // Convert the response body to a Uint8List
                          final bytes = response.bodyBytes;
                          final uint8list = Uint8List.fromList(bytes);
                          await downloadImage(uint8list, widget.post.prompt);
                        } else {
                          await downloadImage(
                              base64.decode(widget.post.imageUrl),
                              widget.post.prompt);
                        }
                        // MyNetworkImage(
                        //   imageUrl: widget.post.imageUrl,
                        // );
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.clear),
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
  MyNetworkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(NetworkImage(imageUrl), context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.network(imageUrl);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
