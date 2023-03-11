import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thinkthat/utils/constant.dart';

class GenPromptApi {
  static Future<String> genPromptApi({String prompt = ''}) async {
    http.Response response = await http.post(
      Uri.parse('$URL/dalle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'prompt': prompt}),
    );

    if (response.statusCode == 200) {
      print('generated');
      return response.body;
    } else {
      print('error generated');
      return response.statusCode.toString();
    }
  }
}
