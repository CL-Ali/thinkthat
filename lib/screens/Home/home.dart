import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thinkthat/Services/Community.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/CreatePost/createPost.dart';
import 'package:thinkthat/screens/Home/component/HomeGalleryLayout.dart';
import 'package:thinkthat/utils/imagetap.dart';
import 'package:thinkthat/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  bool isSearching = false;
  String searchImage = '';
  TextEditingController searchPostController = TextEditingController();
  preload() async {
    List<Post> list = await CommunityApi.getPromptApi();
    setState(() {
      posts = list;
    });
  }

// Stack(
//       children: [
//         ListView.builder(
//           itemCount: widget.imageUrls.length,
//           itemBuilder: (context, index) {
//             return CachedNetworkImage(
//               imageUrl: widget.imageUrls[index],
//               errorWidget: (context, url, error) => Icon(Icons.error),
//               fit: BoxFit.cover,
//             );
//           },
//           onMomentumScrollBegin: (context) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//           onMomentumScrollEnd: (context) {
//             setState(() {
//               _isLoading = true;
//             });
//           },
//         ),
//         if (_isLoading) CircularProgressIndicator(),
//       ],
//     );
  @override
  void initState() {
    preload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _buildAppBar(size.height),
            posts.isEmpty || (isSearching && searchPosts.isEmpty)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: GalleryLayout(
                      size: size,
                      isSearching: isSearching,
                      list: isSearching ? searchPosts : posts,
                    ),
                  ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: Container(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            // backgroundColor: Colors.orange.withOpacity(0.8),
            backgroundColor: Colors.white,
            isExtended: true,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreatePrompt()));
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(height) {
    return Container(
      height: height / 5,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: height / 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // isSearch
                // ?
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text('ThinkThat',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cupertino'))),
                SizedBox(width: 16.0),
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
                // CircleAvatar(
                //   backgroundImage: AssetImage('assets/images/logo.png'),
                // ),
              ],
            ),
          ),

          Flexible(
            child: SizedBox(
              height: 50,
              child: CupertinoSearchTextField(
                // autofocus: true,
                controller: searchPostController,
                onChanged: (value) {
                  setState(() {
                    searchImage = value;
                  });
                  if (searchImage.isEmpty || searchImage == null) {
                    isSearching = false;
                  } else {
                    isSearching = true;
                    searchPosts = Post.searchList(searchImage, posts: posts);
                  }
                },
                // decoration: InputDecoration(
                //   hintText: 'Search',
                //   prefixIcon: Icon(Icons.search),
                //   suffixIcon: IconButton(
                //     icon: Icon(Icons.close),
                //     onPressed: () {
                //       setState(() {
                //         isSearch = false;
                //       });
                //     },
                //   ),
                // ),
              ),
            ),
          ),
          // : Row(
          //     children: [
          //       IconButton(
          //         icon: Icon(Icons.search, size: 27),
          //         onPressed: () {
          //           setState(() {
          //             isSearch = true;
          //           });
          //         },
          //       ),
          //       Text('Search',
          //           style: TextStyle(
          //               fontSize: 20, fontWeight: FontWeight.bold))
          //     ],
          // ),
          // if (!isSearch) Spacer(),
        ],
      ),
    );
  }
}
