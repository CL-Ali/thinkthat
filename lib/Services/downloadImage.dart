import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

Future<String> downloadImage(Uint8List imageData, String name) async {
  // Get the image data from the response body

  if (Platform.isIOS) {
    final file =
        File('${(await getApplicationDocumentsDirectory()).path}/$name.jpg');
    await file.writeAsBytes(imageData);

    final appDirectory =
        await PhotoManager.getAssetPathList(type: RequestType.image);
    final result =
        await PhotoManager.editor.saveImageWithPath(file.path, title: name);

    if (result != null) {
      print('Image saved to gallery successfully.');
    } else {
      print('Image could not be saved to gallery.');
    }
    return file.path;
  } else {
    if (await Permission.storage.request().isGranted) {
      var directory = await getExternalStorageDirectory();
      var filePath = '${directory!.path}/$name.jpg';
      final file = File(filePath);
      await file.writeAsBytes(imageData);
      final result =
          await PhotoManager.editor.saveImageWithPath(file.path, title: name);
      // await OpenFile.open(file.path);
      if (result != null) {
        Get.snackbar(
          'Image',
          'Image saved to gallery successfully.',
          backgroundColor: CupertinoColors.inactiveGray,
        );
      } else {
        Get.snackbar(
          'Image',
          'Image could not be saved to gallery.',
          backgroundColor: CupertinoColors.inactiveGray,
        );
        // }
        print(file.path);
        return file.path;
      }
    }
    return '';
  }
}
