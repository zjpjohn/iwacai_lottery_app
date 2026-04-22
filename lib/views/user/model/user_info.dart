import 'package:iwacai_lottery_app/views/base/model/enum_value.dart';

///
///
///
class UserInfo {
  String nickname = '';
  String phone = '';
  String wxId = '';
  String email = '';
  String avatar = '';
  EnumValue? channel;
  EnumValue? state;
  int expert = 0;
  late String gmtCreate;

  UserInfo.fromJson(Map json) {
    nickname = json['nickname'];
    phone = json['phone'];
    wxId = json['wxId'];
    email = json['email'];
    avatar = json['avatar'];
    channel = EnumValue.fromJson(json['channel']);
    state = EnumValue.fromJson(json['state']);
    expert = json['expert'];
    gmtCreate = json['gmtCreate'] ?? '';
  }
}
