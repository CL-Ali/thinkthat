// ignore_for_file: library_private_types_in_public_api

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thinkthat/screens/Home/home.dart';
import 'package:thinkthat/screens/offlineScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static bool isConnected = false;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> preload() async {
    bool isConnected = await MyApp.checkInternetConnection();
    setState(() {
      MyApp.isConnected = isConnected;
    });
  }

  @override
  void initState() {
    preload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp.isConnected ? HomeScreen() : OfflineScreen(),
    );
  }
}
