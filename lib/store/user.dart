import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/names.dart';
import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/utils/storage.dart';
import 'package:iwacai_lottery_app/views/user/model/user_auth.dart';
import 'package:iwacai_lottery_app/views/user/model/user_balance.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';

import 'config.dart';

class UserStore extends GetxController {
  ///
  ///user store instance
  static UserStore? _instance;

  factory UserStore() {
    UserStore._instance ??= Get.put<UserStore>(UserStore._initialize());
    return UserStore._instance!;
  }

  UserStore._initialize() {
    authSuccess = authToken.isNotEmpty;
  }

  ///
  /// 账户信息
  AuthUser? _authUser;

  ///
  /// 是否已授权成功
  bool _authSuccess = false;

  ///
  /// 授权token
  String _token = '';

  bool get authSuccess => _authSuccess;

  set authSuccess(bool value) {
    _authSuccess = value;
    update();
  }

  String get authToken {
    if (_token.isNotEmpty) {
      authSuccess = true;
      return _token;
    }
    _token = Storage().getString('authentication') ?? '';
    authSuccess = _token.isNotEmpty;
    return _token;
  }

  set authToken(String authToken) {
    Storage().putString('authentication', authToken);
    _token = authToken;
    authSuccess = authToken.isNotEmpty;
  }

  AuthUser? get authUser {
    if (_authUser != null) {
      return _authUser;
    }
    Map? user = Storage().getObject('auth_user');
    if (user != null) {
      _authUser = AuthUser.fromJson(user);
      return _authUser;
    }
    return null;
  }

  set authUser(AuthUser? authUser) {
    _authUser = authUser;
    update();
    if (authUser == null) {
      Storage().remove('auth_user');
      return;
    }
    Storage().putObject('auth_user', authUser);
  }

  ///
  /// 清除本地登录信息
  ///
  void removeLocalAuth({Function? callback}) {
    if (ConfigStore().unAuthedRoute == null) {
      ///暂存当前未授权的页面
      Routing currentRoute = Get.routing;
      ConfigStore().unAuthedRoute = currentRoute;

      authToken = '';
      authUser = null;

      /// 首页接口出现未授权情况
      if (currentRoute.current == AppRoutes.main) {
        Get.toNamed(AppRoutes.login);
        return;
      }

      /// 分首页接口出现未授权登陆情况
      Get.offNamed(AppRoutes.login);
    }
  }

  ///
  /// 退出登录，退出成功后清除本地登录信息
  ///
  void loginOut() {
    EasyLoading.show(status: '正在退出');
    UserInfoRepository.loginOut().then((_) => Get.back()).whenComplete(() {
      EasyLoading.dismiss();
      authToken = '';
      authUser = null;
      BalanceInstance().balance = UserBalance.fromJson({});
    });
  }
}
