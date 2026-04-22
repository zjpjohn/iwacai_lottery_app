import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/store/user.dart';
import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/user/model/user_balance.dart';
import 'package:iwacai_lottery_app/views/user/repository/user_repository.dart';
import 'package:iwacai_lottery_app/widgets/countdown_widget.dart';

class ResetPasswordController extends GetxController {
  ///
  ///
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
  ///
  final GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();

  ///
  /// 验证码
  String? code;

  ///
  /// 新密码
  String? password;

  ///
  /// 确认密码
  String? confirm;

  ///
  /// 显示密码
  bool _showPassword = false;

  ///
  /// 显示确认密码
  bool _showConfirm = false;

  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  bool get showPassword => _showPassword;

  set showConfirm(bool value) {
    _showConfirm = value;
    update();
  }

  bool get showConfirm => _showConfirm;

  ///
  /// 前置校验
  bool beforeHandle() {
    FormState? state = formKey.currentState;
    if (state == null || !state.validate()) {
      return false;
    }
    state.save();
    return true;
  }

  ///
  /// 重置密码请求
  Future<void> resetAction() async {
    FormState? state = formKey.currentState;
    if (state != null && state.validate()) {
      state.save();
      try {
        await UserInfoRepository.resetPassword(
          code: code!,
          password: password!,
          confirm: confirm!,
        );
        //修改密码成功，退出登录
        await UserInfoRepository.loginOut().whenComplete(() {
          UserStore().authToken = '';
          UserStore().authUser = null;
          BalanceInstance().balance = UserBalance.fromJson({});
          Get.offNamed(AppRoutes.login);
        });
      } catch (error) {
        if (error is DioException) {
          ResponseError respError = error.error as ResponseError;
          EasyLoading.showToast(respError.message);
          return;
        }
        EasyLoading.showToast('重置密码失败');
      }
    }
  }

  ///
  /// 发送短信验证码
  Future<SmsState> sendSms() async {
    String? phone = UserStore().authUser?.phone;
    if (phone == null) {
      EasyLoading.showToast('账号未登录');
      return SmsState.empty;
    }
    return await UserInfoRepository.sendSms(phone: phone, channel: 'reset')
        .then((value) => SmsState.success)
        .catchError((error) => SmsState.error);
  }

  String? validateCode(String? code) {
    if (code == null || code.isEmpty) {
      return '验证码为空';
    }
    return null;
  }

  String? validatePwd(String? password) {
    if (password == null || password.isEmpty) {
      return '新密码为空';
    }
    if (!Tools.password(password)) {
      return '密码格式错误';
    }
    return null;
  }

  String? validateConfirm(String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return '确认密码为空';
    }
    if (!Tools.password(confirm)) {
      return '密码格式错误';
    }
    if (password == null || password!.isEmpty) {
      FormFieldState? passwordState = passwordKey.currentState;
      if (passwordState != null) {
        passwordState.validate();
      }
    }
    return null;
  }
}
