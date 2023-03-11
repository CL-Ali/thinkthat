import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeImageLayout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thinkthat/utils/constant.dart';

class ImageLayout extends StatefulWidget {
  const ImageLayout({
    super.key,
    required this.post,
    this.isSearching,
    this.isCreatePrompt = false,
    this.isGallery = false,
  });

  final Post post;
  final bool? isSearching;
  final bool isCreatePrompt;
  final bool isGallery;

  @override
  State<ImageLayout> createState() => _ImageLayoutState();
}

class _ImageLayoutState extends State<ImageLayout> {
  List<Post> suggestionList = [];
  @override
  void initState() {
    if (!widget.isCreatePrompt && !widget.isGallery) {
      suggestionList =
          Post.searchList(widget.post.title, isPostTap: true, posts: posts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            GestureDetector(
              onTap: () {
                !widget.isCreatePrompt
                    ? Get.to(
                        HomeGalleryLayoutScreen(
                            post: widget.post, suggestionList: suggestionList),
                        transition: Transition.downToUp,
                        duration: Duration(milliseconds: 500),
                        preventDuplicates: false)
                    : Get.to(
                        ImageScreen(
                            post: widget.post,
                            isCreateImage: widget.isCreatePrompt),
                        transition: Transition.cupertino);
              },
              child: widget.isCreatePrompt == null || !widget.isCreatePrompt
                  ? CachedNetworkImage(
                      imageUrl: widget.post.imageUrl,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      // fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                        height: 300,
                        width: 300,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Image.memory(
                      base64.decode(widget.post.imageUrl),
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
            ),
          ],
        ));
  }
}
