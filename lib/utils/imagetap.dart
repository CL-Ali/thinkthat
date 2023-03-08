import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeImageLayout.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/utils/constant.dart';

class ImageOnTapLayout extends StatelessWidget {
  const ImageOnTapLayout({
    super.key,
    required this.post,
    this.isHomeImage = false,
    required this.color,
  });
  final Color color;
  final bool isHomeImage;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: () => isHomeImage
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageScreen(
                            post: post,
                            isCreateImage: true,
                          )),
                )
              : Navigator.pop(context),
          child: Container(
            // color: Colors.grey.withOpacity(0.3),
            // color: color,
            color: Colors.black,
            child: isHomeImage
                ? Image.network(
                    post.imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    fit: isHomeImage ? BoxFit.cover : BoxFit.contain,
                  )
                : Image.memory(
                    base64.decode(post.imageUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: isHomeImage ? BoxFit.cover : BoxFit.contain,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: isHomeImage
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.down_arrow),
                      onPressed: () {
                        MyNetworkImage(
                          imageUrl: post.imageUrl,
                        );
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
