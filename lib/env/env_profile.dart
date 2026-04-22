///
/// 环境属性配置
class Props {
  final String env;
  final String appNo;
  final String baseUri;

  Props({
    required this.env,
    required this.appNo,
    required this.baseUri,
  });

  Map<String, String> toJson() {
    return {
      'env': env,
      'appNo': appNo,
      'baseUri': baseUri,
    };
  }
}

///
/// 环境profile
class Profile {
  ///
  ///当前环境
  static const String envProfile = String.fromEnvironment(
    EnvName.envKey,
    defaultValue: "dev",
  );

  ///debug开发环境
  static final Props _dev = Props(
    env: EnvName.dev,
    appNo: 'h6hBvBeA3hK',
    baseUri: 'https://beta.api.icaiwa.com',
  );

  ///beta测试环境
  static final Props _beta = Props(
    env: EnvName.beta,
    appNo: 'h6hBvBeA3hK',
    baseUri: 'https://beta.api.icaiwa.com',
  );

  ///正式环境
  static final Props _release = Props(
    env: EnvName.release,
    appNo: 'x7CWUHM3DTk',
    baseUri: 'https://api.icaiwa.com',
  );

  ///获取环境配置信息
  static Props get props => _getEnvProps();

  /// 不同环境对应的配置
  static Props _getEnvProps() {
    switch (envProfile) {
      case EnvName.dev:
        return _dev;
      case EnvName.beta:
        return _beta;
      case EnvName.release:
        return _release;
      default:
        return _dev;
    }
  }
}

///
/// 环境常量名称
class EnvName {
  ///
  ///环境变量key
  static const String envKey = 'APP_PROFILE';

  ///debug环境
  static const String dev = 'dev';

  ///测试环境
  static const String beta = 'beta';

  ///正式环境
  static const String release = 'release';
}
