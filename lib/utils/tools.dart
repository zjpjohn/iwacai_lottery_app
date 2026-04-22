import 'dart:math';

class Tools {
  ///
  ///手机号校验
  static bool phone(String phone) {
    RegExp regex = RegExp(
        r'^((1[358][0-9])|(14[579])|(166)|(17[0135678])|(19[89]))\d{8}$');
    return regex.hasMatch(phone);
  }

  ///
  ///纯数字判断
  static bool number(String source) {
    RegExp regex = RegExp(r'\d{1,}');
    return regex.hasMatch(source);
  }

  ///
  /// 密码校验
  static bool password(String password) {
    RegExp regex = RegExp(r'(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$');
    return regex.hasMatch(password);
  }

  ///
  /// 设置手机号掩码
  static String encodeTel(String phone) {
    return phone.replaceRange(3, 7, '****');
  }

  ///
  /// 随机数字
  static int randLimit(int value, int limit) {
    if (value > limit) {
      return value;
    }
    return value + Random().nextInt(limit - value);
  }

  ///
  /// 字符串阶段替换
  static String limitName(String name, int limit) {
    if (name.length > limit) {
      return name.substring(0, limit) + '...';
    }
    return name;
  }

  ///
  /// 字符串截断
  static String limitText(String name, int limit) {
    if (name.length > limit) {
      return name.substring(0, limit);
    }
    return name;
  }
}
