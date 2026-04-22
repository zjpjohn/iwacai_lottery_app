import 'package:iwacai_lottery_app/app/model/app_info.dart';
import 'package:iwacai_lottery_app/app/model/app_verify.dart';
import 'package:iwacai_lottery_app/app/model/app_version.dart';
import 'package:iwacai_lottery_app/env/env_profile.dart';
import 'package:iwacai_lottery_app/utils/request.dart';

class AppInfoRepository {
  ///
  /// 获取应用详情
  static Future<AppInfoVo> getAppInfo({
    required String seqNo,
    required String version,
  }) {
    return HttpRequest().get('/lope/native/app/$seqNo/$version').then((value) {
      return AppInfoVo(
        appInfo: AppInfo.fromJson(value.data['appInfo']),
        current: AppVersion.fromJson(value.data['current']),
        main: MainVersion.fromJson(value.data['main']),
      );
    });
  }

  ///
  /// 获取应用一键登录配置信息
  static Future<AuthVerify> getAppVerify() {
    return HttpRequest().get('/lope/uverify/', params: {
      'appNo': Profile.props.appNo
    }).then((value) => AuthVerify.fromJson(value.data));
  }
}
