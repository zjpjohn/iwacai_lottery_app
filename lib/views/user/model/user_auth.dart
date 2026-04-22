import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
/// 用户登录授权信息
///
class AuthInfo {
  String token = '';
  int expire = 0;
  String loginTime = '';
  AuthUser? user;

  AuthInfo.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expire = int.parse(json['expire']);
    loginTime = json['loginTime'];
    user = AuthUser.fromJson(json['user']);
  }
}

class AuthUser {
  ///用户标识，base64编码
  String uid = '';

  ///用户昵称
  String nickname = '';

  ///登录手机号
  String phone = '';

  ///用户头像
  String avatar = '';

  ///预测专家
  int expert = 0;

  ///注册渠道
  EnumValue? channel;

  AuthUser(
    this.uid,
    this.nickname,
    this.phone,
    this.avatar,
    this.expert,
  );

  AuthUser.fromJson(Map json) {
    uid = json['uid'];
    nickname = json['nickname'];
    phone = json['phone'];
    avatar = json['avatar'];
    expert = json['expert'] ?? 0;
    if (json['channel'] != null) {
      channel = EnumValue.fromJson(json['channel']);
    }
  }

  Map toJson() {
    Map json = {};
    json['uid'] = uid;
    json['nickname'] = nickname;
    json['phone'] = phone;
    json['avatar'] = avatar;
    json['expert'] = expert;
    json['channel'] = channel;
    return json;
  }
}
