///
///
class AppChannel {
  ///渠道变量
  static const String channelKey = 'APP_CHANNEL';

  ///当前渠道值
  static const String channel =
      String.fromEnvironment(channelKey, defaultValue: "main");

}
