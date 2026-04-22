import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/env/log_profile.dart';
import 'package:iwacai_lottery_app/store/model/history_model.dart';
import 'package:iwacai_lottery_app/store/model/oss_policy.dart';
import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/utils/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

///浏览历史Key
const browseHistoryKey = 'browse_history';

///首次打开Key
const firstOpenKey = 'device_first_open';

/// 搜索历史key
const historyKey = 'sport_search_history';

///
/// 应用协议同意标识Key
const protocolAgreeKey = 'app_protocol_agree';

class ConfigStore extends GetxController {
  ///
  static ConfigStore? _instance;

  factory ConfigStore() {
    ConfigStore._instance ??= Get.put(ConfigStore._initialize());
    return ConfigStore._instance!;
  }

  ConfigStore._initialize();

  ///
  ///历史跳转信息
  HistoryInfo? history;

  ///
  /// oss文件上传信息
  OssPolicy? policy;

  ///应用包信息
  PackageInfo? _platform;

  ///应用使用协议
  int? _agree;

  ///
  /// 当前未授权登录的页面
  Routing? _unAuthedRoute;

  Routing? get unAuthedRoute => _unAuthedRoute;

  set unAuthedRoute(Routing? route) {
    if (route == null) {
      _unAuthedRoute = null;
      return;
    }
    _unAuthedRoute = Routing(
      current: route.current,
      args: route.args,
      route: route.route,
    );
  }

  set agree(int value) {
    _agree = value;
    Storage().putInt(protocolAgreeKey, value);
    update();
  }

  int get agree {
    _agree ??= Storage().getInt(protocolAgreeKey) ?? 0;
    return _agree!;
  }

  set ossPolicy(OssPolicy? ossPolicy) {
    policy = ossPolicy;
    if (ossPolicy != null) {
      Storage().putObject('cloud_oss_policy', ossPolicy);
    }
  }

  OssPolicy? get ossPolicy {
    if (policy == null) {
      Map? data = Storage().getObject('cloud_oss_policy');
      if (data != null) {
        policy = OssPolicy.fromJson(data);
      }
    }
    return policy;
  }

  Future<OssPolicy?> getOssPolicy() async {
    OssPolicy? getPolicy = ossPolicy;
    if (getPolicy == null ||
        getPolicy.expire <= DateTime.now().millisecondsSinceEpoch) {
      try {
        getPolicy = await HttpRequest().get('/lope/oss/policy',
            params: {'dir': 'app_sport_${Profile.props.appNo}'}).then((value) {
          OssPolicy newPolicy = OssPolicy.fromJson(value.data);
          ossPolicy = newPolicy;
          return newPolicy;
        });
      } catch (error) {
        logger.e('load oss policy error.', error: error);
        EasyLoading.showToast('获取签名错误');
      }
    }
    return getPolicy;
  }

  String get version => _platform?.version ?? '';

  String get inviteCode {
    return Storage().getString('user_invite') ?? '';
  }

  set inviteCode(String code) {
    Storage().putString('user_invite', code);
  }

  int get channel {
    return Storage().getInt('user_channel', defValue: 3)!;
  }

  set channel(int channel) {
    Storage().putInt('user_channel', channel);
  }

  void saveInviteCode(String inviteCode) {
    Storage().putString('user_invite', inviteCode);
  }

  ///设置最新浏览记录
  void saveHistory({String? remark}) {
    Routing routing = Get.routing;
    history = HistoryInfo(routing.current, routing.args, remark);
    Storage().putObject('browse_history', history!);
  }

  bool get firstOpen {
    return Storage().getInt(firstOpenKey) != null;
  }

  ///标记首次打开APP
  void openApp() {
    Storage().putInt(firstOpenKey, 1);
  }

  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  ///
  /// 获取本地搜索历史列表
  List<String> get histories {
    String? histories = Storage().getString(historyKey);
    if (histories == null || histories.isEmpty) {
      return [];
    }
    return histories.split(";").reversed.toList();
  }

  ///
  /// 本地保存搜索历史
  set histories(List<String>? histories) {
    if (histories != null) {
      String history = histories.reversed.toList().join(";");
      Storage().putString(historyKey, history);
      return;
    }
    Storage().remove(historyKey);
  }

  @override
  void onInit() {
    super.onInit();
    getPlatform();
  }
}
