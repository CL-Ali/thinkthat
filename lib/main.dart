// ignore_for_file: library_private_types_in_public_api

// import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:thinkthat/models/promptModel.dart';
import 'package:thinkthat/screens/CreatePost/createPost.dart';
import 'package:thinkthat/screens/Home/component/HomeImageLayout.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/screens/offlineScreen.dart';
import 'package:thinkthat/utils/constant.dart';
import 'package:thinkthat/utils/imagetap.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // static Future<bool> checkInternetConnection() async {
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult == ConnectivityResult.none) {
  //   return false;
  // } else {
  //   return true;
  // }
  // }

  static bool isConnected = false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // preload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // MyApp.isConnected ?
      home: HomeScreen(),
      //  : OfflineScreen(),
    );
  }
}

class MyController extends GetxController {
  // Define your state variables
  var count = 0;

  // Define your business logic
  void increment() => count++;
}
