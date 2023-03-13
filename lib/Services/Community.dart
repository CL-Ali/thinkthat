// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:thinkthat/Models/PromptModel.dart';
import 'package:thinkthat/Utils/Constant.dart';

class CommunityApi {
  static Future<List<Post>> getPromptApi({String prompt = ''}) async {
    http.Response response = await http.get(
      Uri.parse('$URL/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List body = (jsonDecode(response.body))['data'];
      List<Post> list = Post.convertIntoList(body);
      return list;
    } else {
      return [Post(title: response.statusCode.toString())];
    }
  }

  static Future<bool> postPromptApi(Post post) async {
    http.Response response = await http.post(
      Uri.parse('$URL/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'prompt': post.prompt,
        'name': post.title,
        'photo': post.imageUrl,
      }),
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      Get.snackbar(
        "Alert",
        "Status Code : ${response.statusCode.toString()} and Reason : ${response.reasonPhrase}",
        backgroundColor: CupertinoColors.inactiveGray,
      );
      return false;
    }
    return true;
  }
}
