// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/Services/Community.dart';
import 'package:thinkthat/Models/PromptModel.dart';
import 'package:thinkthat/Screens/CreatePost/CreatePost.dart';
import 'package:thinkthat/Screens/Components/GalleryLayout.dart';
import 'package:thinkthat/Utils/Constant.dart';

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
                ? const Center(
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
        floatingActionButton: SizedBox(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            isExtended: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePrompt()));
            },
            child: const Icon(
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
      padding: const EdgeInsets.all(8),
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
                    child: const Text('ThinkThat',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cupertino'))),
                const SizedBox(width: 16.0),
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
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
                  if (searchImage.isEmpty) {
                    isSearching = false;
                  } else {
                    isSearching = true;
                    searchPosts = Post.searchList(searchImage, posts: posts);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
