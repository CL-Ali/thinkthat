// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:thinkthat/Models/PromptModel.dart';
import 'package:thinkthat/Screens/Components/GalleryLayout.dart';
import 'package:thinkthat/Screens/Components/Imagetap.dart';

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height > 640 ? 400 : 200,
            width: double.infinity,
            child: ImageOnTapLayout(
                isHomeImage: true,
                isGalleryImage: true,
                post: post!,
                color: Colors.black),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post!.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  post!.prompt,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
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
