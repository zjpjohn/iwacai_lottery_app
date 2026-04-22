import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class PosterUtils {
  ///
  /// 存储权限申请
  static Future<bool> _storagePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    }
    status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  ///
  /// 保存海报图片
  static void saveImage(GlobalKey key) async {
    try {
      EasyLoading.show();
      if (!await _storagePermission()) {
        EasyLoading.showError('没有权限哟');
        return;
      }
      RenderRepaintBoundary? boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      var image = await boundary!.toImage(pixelRatio: 4);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List bytes = byteData!.buffer.asUint8List();
      await ImageGallerySaver.saveImage(bytes, quality: 100);
      Future.delayed(const Duration(milliseconds: 250), () {
        EasyLoading.showToast(
          '已保存到相册',
          duration: const Duration(milliseconds: 1500),
        );
      });
    } catch (error) {
      EasyLoading.showError('海报保存失败');
    }
  }
}
