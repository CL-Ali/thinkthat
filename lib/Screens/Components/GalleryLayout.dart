// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/ImageScreen/components/imageLayout.dart';

class GalleryLayout extends StatelessWidget {
  const GalleryLayout({
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
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
    );
  }
}
