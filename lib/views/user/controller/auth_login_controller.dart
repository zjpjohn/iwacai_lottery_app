import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/store/store.dart';
import 'package:iwacai_lottery_app/utils/quick_phone_auth.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/user/model/auth_mobile.dart';
import 'package:iwacai_lottery_app/views/user/model/user_auth.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';
import 'package:iwacai_lottery_app/widgets/countdown_widget.dart';

class UserLoginController extends GetxController {
  ///
  /// 表单唯一Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
  ///
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();

  ///
  ///手机号输入控制器
  TextEditingController phoneController = TextEditingController();

  ///
  /// 验证码输入控制器
  TextEditingController codeController = TextEditingController();

  ///
  /// 登录密码输入控制器
  TextEditingController pwdController = TextEditingController();

  ///
  /// 登录方式:1-验证码登录,3-密码登录
  int _loginType = 1;

  ///
  /// 手机号
  late String phone;

  ///
  /// 验证码
  late String code;

  ///
  /// 登录密码
  late String password;

  ///
  /// 显示登录密码
  bool _showPassword = false;

  ///
  /// 是否同意登录
  bool _agree = false;

  set agree(bool value) {
    _agree = value;
    update();
  }

  bool get agree => _agree;

  set loginType(int value) {
    _loginType = value;
    update();
  }

  int get loginType => _loginType;

  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  bool get showPassword => _showPassword;

  @override
  void onInit() {
    super.onInit();
    triggerQuickAuth();
  }

  void triggerQuickAuth() {
    QuickPhoneAuth().authLogin((token) => quickAuth(token));
  }

  ///
  ///手机号快捷登录
  Future<void> quickAuth(String token) async {
    ///
    EasyLoading.show(status: '正在登陆');
    bool authSuccess = false;
    try {
      ///获取授权登录手机号
      AuthMobile authMobile = await UserInfoRepository.authMobile(token);

      ///授权手机号换取登录信息
      AuthInfo authInfo = await UserInfoRepository.quickAuth(
        phone: authMobile.phone,
        nonceStr: authMobile.nonceStr,
        signature: authMobile.signature,
        channel: ConfigStore().channel,
        invCode: ConfigStore().inviteCode,
      );

      ///保存登录信息
      UserStore().authToken = authInfo.token;
      UserStore().authUser = authInfo.user;
      authSuccess = true;
    } catch (e) {
      ///登陆失败错误处理
      EasyLoading.showToast('登陆失败');
    }
    Future.delayed(const Duration(microseconds: 200), () {
      EasyLoading.dismiss();
    });
    //登录页回退
    Get.back();
    if (authSuccess) {
      //登陆成功后处理
      authSuccessHandle();
    }
  }

  ///
  /// 登录操作
  Future<void> loginAction() async {
    FormState? state = formKey.currentState;
    if (state != null && state.validate()) {
      if (!agree) {
        EasyLoading.showToast('请同意使用协议');
        return;
      }
      state.save();
      bool authSuccess = false;
      try {
        late AuthInfo authResult;
        if (loginType == 1) {
          authResult = await UserInfoRepository.authLogin(
            phone: phone,
            code: code,
            channel: ConfigStore().channel,
            invCode: ConfigStore().inviteCode,
          );
        } else {
          authResult = await UserInfoRepository.pwdAuth(
            phone: phone,
            password: password,
            channel: ConfigStore().channel,
          );
        }
        UserStore().authToken = authResult.token;
        UserStore().authUser = authResult.user;
        authSuccess = true;
      } catch (error) {
        EasyLoading.showToast('登陆失败');
      }
      //登录页回退
      Get.back();
      if (authSuccess) {
        //登陆成功后处理
        authSuccessHandle();
      }
    }
  }

  ///
  /// 授权成功处理
  void authSuccessHandle() {
    ///授权成功后跳转上一次授权失败的页面
    Routing? jumpRout = ConfigStore().unAuthedRoute;

    if (jumpRout != null && jumpRout.current != AppRoutes.main) {
      Future.delayed(const Duration(milliseconds: 100), () {
        ///授权成功后跳转到上一次授权失败的页面
        Get.toNamed(jumpRout.current, arguments: jumpRout.args);
      });
    }

    ///清空上一次未授权路由
    ConfigStore().unAuthedRoute = null;

    ///刷新余额账户
    BalanceInstance().refreshBalance();
  }

  ///
  /// 发送短信验证码
  Future<SmsState> sendSms() async {
    FormFieldState? phoneState = phoneKey.currentState;
    if (phoneState != null && phoneState.validate()) {
      return await UserInfoRepository.sendSms(
              phone: phoneState.value, channel: 'login')
          .then((value) => SmsState.success)
          .catchError((error) => SmsState.error);
    }
    return SmsState.empty;
  }

  String? validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return '手机号不允许为空';
    }
    if (!Tools.phone(phone)) {
      return '手机号格式错误';
    }
    return null;
  }

  String? validateCode(String? code) {
    if (code == null || code.isEmpty) {
      return '验证码为空';
    }
    return null;
  }

  String? validatePwd(String? password) {
    if (password == null || password.isEmpty) {
      return '登录密码为空';
    }
    return null;
  }
}
