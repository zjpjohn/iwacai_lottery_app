import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/user/index.dart';
import 'package:iwacai_lottery_app/views/user/widgets/login_backgroud.dart';
import 'package:iwacai_lottery_app/views/user/widgets/password_eye_widget.dart';
import 'package:iwacai_lottery_app/widgets/action_state_button.dart';
import 'package:iwacai_lottery_app/widgets/agreement_widget.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';
import 'package:iwacai_lottery_app/widgets/countdown_widget.dart';

class UserLoginView extends StatelessWidget {
  const UserLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue.shade50,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const LoginBackground(title: '用户登录'),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.88,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: GetBuilder<UserLoginController>(
                          builder: (controller) => loginView(controller),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loginView(UserLoginController controller) {
    return Container(
      margin: EdgeInsets.only(top: 32.w),
      alignment: Alignment.center,
      child: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 8.w),
              child: TextFormField(
                key: controller.phoneKey,
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                decoration:
                    CommonWidgets.filledDecoration(hintText: '请输入登录手机号'),
                style: const TextStyle(letterSpacing: 1.2),
                cursorWidth: 1.2.w,
                onSaved: (value) {
                  controller.phone = value!;
                },
                validator: (phone) {
                  return controller.validatePhone(phone);
                },
              ),
            ),
            if (controller.loginType == 1)
              Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: CommonWidgets.filledDecoration(
                        hintText: '请输入验证码',
                        helperText: '未注册手机号验证后自动注册',
                      ),
                      style: const TextStyle(letterSpacing: 1.2),
                      cursorWidth: 1.2.w,
                      onSaved: (value) {
                        controller.code = value!;
                      },
                      validator: (code) {
                        return controller.validateCode(code);
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20.w, right: 16.w),
                          child: CountdownWidget(
                            handle: controller.sendSms,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            if (controller.loginType == 3)
              Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      obscureText: !controller.showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: CommonWidgets.filledDecoration(
                        hintText: '请输入登录密码',
                        helperText: '手机号已注册可使用密码登录',
                      ),
                      style: const TextStyle(letterSpacing: 0),
                      cursorWidth: 1.2.w,
                      onSaved: (value) {
                        controller.password = value!;
                      },
                      validator: (code) {
                        return controller.validatePwd(code);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.w, right: 16.w),
                      child: PasswordEyeView(
                        value: controller.showPassword,
                        tap: (value) {
                          controller.showPassword = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 28.w),
              child: AgreementView(
                value: controller.agree,
                onHandle: (value) {
                  controller.agree = value;
                },
              ),
            ),
            Container(
              height: 40.w,
              margin: EdgeInsets.only(top: 12.w, left: 24.w, right: 24.w),
              child: ActionStateButton(
                unActive: '登录/注册',
                active: '正在登录',
                hintTxt: '登录中，请耐心等待',
                action: controller.loginAction,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42.w),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16.w, bottom: 40.w),
              child: GestureDetector(
                onTap: () {
                  controller.loginType = controller.loginType == 1 ? 3 : 1;
                },
                child: Text(
                  controller.loginType == 1 ? '切换为密码登录' : '切换为验证码登录',
                  style: TextStyle(
                    color: const Color(0xFFFF0033),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
