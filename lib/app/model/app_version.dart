///
/// 应用主推版本信息
class MainVersion {
  ///
  /// 版本信息
  String version = '';

  /// 全量安装包下载地址
  String apkUri = '';

  /// 分abi安装包下载地址集合
  Map<String, String> abiApks = {};

  /// 应用升级信息
  List<String> upgrades = [];

  MainVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    apkUri = json['apkUri'];
    abiApks = Map.from(json['abiApks'] ?? {}).cast<String, String>();
    upgrades = (json['upgrades'] ?? []).cast<String>();
  }
}

///
///
///  当前应用版本信息
class AppVersion {
  ///
  /// 版本信息
  String version = '';

  ///
  /// 应用描述信息
  String depiction = '';

  AppVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    depiction = json['depiction'];
  }
}
