import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/model/app_info.dart';
import 'package:iwacai_lottery_app/app/repository.dart';
import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/store/device.dart';
import 'package:iwacai_lottery_app/store/model/device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_upgrade/r_upgrade.dart';

class AppController extends GetxController {
  ///
  ///应用信息
  AppInfoVo? appInfo;

  /// 是否是最新版本
  bool latestVersion = true;

  ///
  static AppController? _instance;

  factory AppController() {
    AppController._instance ??=
        Get.put<AppController>(AppController._initialize());
    return AppController._instance!;
  }

  AppController._initialize();

  void getAppInfo({bool showLoading = false}) async {
    if (showLoading) {
      EasyLoading.show(status: '加载中');
    }
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appInfo = await AppInfoRepository.getAppInfo(
        seqNo: Profile.props.appNo,
        version: packageInfo.version,
      );
      isLatestVersion();
    } finally {
      if (showLoading && EasyLoading.isShow) {
        EasyLoading.dismiss();
      }
    }
  }

  ///
  /// 获取应用版本信息
  String get appVersion {
    return appInfo?.current.version ?? '';
  }

  ///
  /// 判断应用版本是否最新
  void isLatestVersion() {
    if (appInfo != null) {
      latestVersion =
          appInfo!.current.version.compareTo(appInfo!.main.version) >= 0;
    }
  }

  ///
  /// 应用升级存储权限获取
  Future<bool> _storagePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }
    PermissionStatus status = await Permission.storage.request();
    return status.isGranted;
  }

  ///
  /// 应用升级
  Future<void> upgrade() async {
    if (latestVersion) {
      return;
    }
    if (!await _storagePermission()) {
      return;
    }
    String apkUri = appInfo!.main.apkUri;
    DeviceInfo? deviceInfo = await AppDevice().deviceInfo();
    String? abi = deviceInfo?.abis.first;
    if (abi != null) {
      String? abiApkUri = appInfo!.main.abiApks[abi];
      if (abiApkUri != null) {
        apkUri = abiApkUri;
      }
    }
    String fileName = apkUri.substring(
      apkUri.lastIndexOf("/") + 1,
      apkUri.length,
    );
    RUpgrade.upgrade(
      apkUri,
      fileName: fileName,
      notificationStyle: NotificationStyle.speechAndPlanTime,
    );
  }

  @override
  void onInit() {
    super.onInit();
    getAppInfo();
  }
}
