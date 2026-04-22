import 'dart:io';

import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:iwacai_lottery_app/store/model/device_info.dart';

class AppDevice extends GetxController {
  ///
  static AppDevice? _instance;

  ///单例工厂
  factory AppDevice() {
    AppDevice._instance ??= Get.put<AppDevice>(AppDevice._initialize());
    return AppDevice._instance!;
  }

  //私有构造函数
  AppDevice._initialize();

  Future<DeviceInfo?> deviceInfo() async {
    if (!Platform.isAndroid) {
      return null;
    }
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    return DeviceInfo(build: build);
  }
}
