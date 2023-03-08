import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/utils/imageLayout.dart';
import 'package:thinkthat/utils/constant.dart';

class GalleryLayout extends StatelessWidget {
  GalleryLayout({
    super.key,
    required this.size,
    this.list,
    this.isphysics = true,
    required this.isSearching,
  });

  final Size size;
  final bool isSearching;
  final bool isphysics;
  final List<Post>? list;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height,
      height: size.height - (size.height / 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MasonryGridView.count(
          physics: isphysics
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: list!.length,
          itemBuilder: (context, index) {
            Post post = list![index];
            return Column(
              children: [
                ImageLayout(post: post, isSearching: isSearching),
              ],
            );
          },
        ),
      ),
    );
  }
}