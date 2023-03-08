import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeImageLayout.dart';

class ImageLayout extends StatelessWidget {
  const ImageLayout({
    super.key,
    required this.post,
    this.isSearching,
    this.isCreatePrompt,
  });

  final Post post;
  final bool? isSearching;
  final bool? isCreatePrompt;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageScreen(
                              post: post,
                              isCreateImage: isCreatePrompt == null
                                  ? false
                                  : isCreatePrompt!
                                      ? true
                                      : false,
                            )));
              },
              child: isCreatePrompt == null || !isCreatePrompt!
                  ? Image.network(
                      post.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64.decode(post.imageUrl),
                      fit: BoxFit.cover,
                      height: 300,
                      width: 300,
                    ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.black.withOpacity(0.2),
            //     // color: Colors.transparent,
            //   ),
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           post.title,
            //           style: const TextStyle(
            //               fontWeight: FontWeight.w700,
            //               color: Colors.white54,
            //               fontSize: 12),
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             // optionModelSheet(context);
            //           },
            //           child: const Icon(
            //             CupertinoIcons.down_arrow,
            //             color: Colors.white54,
            //             size: 15,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
