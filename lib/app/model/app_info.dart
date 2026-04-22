import 'package:iwacai_lottery_app/app/model/app_version.dart';

class AppInfo {
  ///
  /// 应用标识
  String seqNo = '';

  ///
  /// 应用名称
  String name = '';

  ///
  /// 应用图标
  String logo = '';

  ///
  /// 应用版权
  String copyright = '';

  ///
  /// 应用联系方式
  String telephone = '';

  ///
  /// 应用地址
  String address = '';

  ///
  /// 备案信息
  String record = '';

  AppInfo.fromJson(Map<String, dynamic> json) {
    seqNo = json['seqNo'];
    name = json['name'];
    logo = json['logo'];
    copyright = json['copyright'];
    telephone = json['telephone'];
    address = json['address'];
    record = json['record'];
  }
}

class AppInfoVo {
  /// 应用信息
  AppInfo appInfo;

  /// 当前版本信息
  AppVersion current;

  /// 应用主推版本
  MainVersion main;

  AppInfoVo({
    required this.appInfo,
    required this.current,
    required this.main,
  });
}
