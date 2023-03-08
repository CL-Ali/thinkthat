import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/Home/component/HomeGalleryLayout.dart';
import 'package:thinkthat/utils/imagetap.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/utils/constant.dart';

class ImageScreen extends StatefulWidget {
  final bool isCreateImage;
  final Post? post;

  ImageScreen({this.isCreateImage = false, this.post});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  List<Post> suggestionList = [];
  @override
  void initState() {
    if (!widget.isCreateImage) {
      suggestionList =
          Post.searchList(widget.post!.title, isPostTap: true, posts: posts);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body:
            // ? Stack(
            //     alignment: AlignmentDirectional.topEnd,
            //     children: [
            //       GestureDetector(
            //         onTap: () => Navigator.pop(context),
            //         child: Container(
            //           // color: Colors.grey.withOpacity(0.3),
            //           color: Colors.transparent,
            //           child: Hero(
            //             tag: imageUrl,
            //             child: Image.asset(
            //               imageUrl,
            //               height: double.infinity,
            //               fit: BoxFit.contain,
            //             ),
            //           ),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             IconButton(
            //               icon: Icon(CupertinoIcons.down_arrow),
            //               onPressed: () {},
            //               color: Colors.white,
            //             ),
            //             IconButton(
            //               icon: Icon(CupertinoIcons.clear),
            //               onPressed: () => Navigator.pop(context),
            //               color: Colors.white,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   )
            widget.isCreateImage
                ? ImageOnTapLayout(
                    post: widget.post!, color: Colors.transparent)
                : ListView(
                    children: [
                      Container(
                        height: 400,
                        width: double.infinity,
                        child: ImageOnTapLayout(
                            isHomeImage: true,
                            post: widget.post!,
                            color: Colors.black),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post!.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.post!.prompt,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      GalleryLayout(
                        size: MediaQuery.of(context).size,
                        isSearching: false,
                        // isphysics: false,
                        list: suggestionList,
                      )
                    ],
                  ),
      ),
    );
  }
}
