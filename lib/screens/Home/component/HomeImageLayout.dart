import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeGalleryLayout.dart';
import 'package:thinkthat/utils/imagetap.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/utils/constant.dart';

class ImageScreen extends StatefulWidget {
  final bool isCreateImage;
  final bool isGalleryImage;
  final Post? post;

  ImageScreen(
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

class HomeGalleryLayoutScreen extends StatelessWidget {
  HomeGalleryLayoutScreen({
    super.key,
    required this.post,
    required this.suggestionList,
  });
  Post? post;

  final List<Post> suggestionList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: ImageOnTapLayout(
                isHomeImage: true,
                isGalleryImage: true,
                post: post!,
                color: Colors.black),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post!.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  post!.prompt,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: GalleryLayout(
              size: MediaQuery.of(context).size,
              isSearching: false,
              // isphysics: false,
              list: suggestionList,
            ),
          )
        ],
      ),
    );
  }
}
