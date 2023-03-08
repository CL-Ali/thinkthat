import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/utils/imagetap.dart';

const String URL = 'https://ai-image-generated-with-firebase.vercel.app/api/v1';
const appbarTextStyle = TextStyle();
List<Post> searchPosts = [];
List<Post> posts = [];
// List<Post> posts = [
//   Post(
//     id: 'id0',
//     imageUrl: 'assets/images/1.jpg',
//     title: 'Spiderman wall art',
//   ),
//   Post(
//     id: 'id1',
//     imageUrl: 'assets/images/2.jpg',
//     title: 'Comic book collection',
//   ),
//   Post(
//     id: 'id2',
//     imageUrl: 'assets/images/3.jpg',
//     title: 'Powerful Baby Groot',
//   ),
//   Post(
//     id: 'id3',
//     imageUrl: 'assets/images/4.jpg',
//     title: 'DC best friends',
//   ),
//   Post(
//     id: 'id4',
//     imageUrl: 'assets/images/5.jpg',
//     title: 'Spiderman in action',
//   ),
//   Post(
//     id: 'id5',
//     imageUrl: 'assets/images/6.jpg',
//     title: 'Will he save Gwen?',
//   ),
//   Post(
//     id: 'id6',
//     imageUrl: 'assets/images/7.jpg',
//     title: 'Collector Edition',
//   ),
//   Post(
//     id: 'id7',
//     imageUrl: 'assets/images/8.jpg',
//     title: 'Captain America strikes',
//   ),
//   Post(
//     id: 'id8',
//     imageUrl: 'assets/images/9.jpg',
//     title: 'The Dark Knight',
//   ),
//   Post(
//       id: 'id9',
//       imageUrl: 'assets/images/10.jpg',
//       title: 'Snap snap',
//       prompt: "BLAH BLAH"),
// ];
