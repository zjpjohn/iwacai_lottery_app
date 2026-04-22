import 'dart:convert';

import 'package:get/get.dart';
import 'package:iwacai_lottery_app/store/config.dart';
import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';

class OpenInstall extends GetxController {
  ///
  late OpeninstallFlutterPlugin _openInstallPlugin;

  ///
  static OpenInstall? _instance;

  factory OpenInstall() {
    OpenInstall._instance ??= Get.put<OpenInstall>(OpenInstall._internal());
    return OpenInstall._instance!;
  }

  OpenInstall._internal() {
    _openInstallPlugin = OpeninstallFlutterPlugin();
    _openInstallPlugin.init(_wakeupHandle);
  }

  void install() {
    if (!ConfigStore().firstOpen) {
      return;
    }
    _openInstallPlugin.install((Map<String, Object> data) async {
      ///安装参数判断
      if (data['bindData'] == null) {
        return;
      }

      ///安装参数
      Map<String, dynamic> params = jsonDecode(data['bindData'].toString());

      ///注册渠道
      ConfigStore().channel = int.parse(params['channel'] ?? '3');

      ///注册邀请码
      ConfigStore().inviteCode = params['code'] ?? '';
    });
  }

  ///
  /// 唤醒拉起回调
  Future _wakeupHandle(Map<String, Object> data) async {}

  ///
  /// 注册统计
  void reportRegister() {
    _openInstallPlugin.reportRegister();
  }

  ///
  /// 效果点统计
  void reportEffect({required String point}) {
    _openInstallPlugin.reportEffectPoint(point, 1);
  }
}
