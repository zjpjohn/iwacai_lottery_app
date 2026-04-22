import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/controller.dart';
import 'package:iwacai_lottery_app/app/model/app_info.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/user/model/user_auth.dart';
import 'package:iwacai_lottery_app/views/user/model/user_invite.dart';
import 'package:iwacai_lottery_app/widgets/dash_line.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InvitePosterWidget extends StatelessWidget {
  ///
  ///
  const InvitePosterWidget({
    Key? key,
    required this.posterKey,
    required this.userInfo,
    required this.invite,
  }) : super(key: key);

  final GlobalKey posterKey;
  final AuthUser userInfo;
  final UserInvite invite;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: posterKey,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(R.sharePosterBackground),
          ),
        ),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, 3),
              child: Container(
                width: 280.w,
                color: Colors.white,
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                child: Column(
                  children: [
                    Text(
                      userInfo.nickname,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'shuhei',
                      ),
                    ),
                    Text(
                      '欢迎使用哇彩赛事',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontFamily: 'shuhei',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              shape: InviteShapeBorder(
                radius: 6.w,
                dashCount: 30,
                color: Colors.brown.shade200,
              ),
              color: Colors.white,
              child: Container(
                width: 280.w,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 280.w,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.w, top: 10.w),
                            child: Text(
                              '我的专属邀请码',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 112.w,
                            height: 112.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 6.w,
                                  left: 6.w,
                                  right: 6.w,
                                  bottom: 6.w,
                                  child: Container(
                                    width: 108.w,
                                    height: 108.w,
                                    alignment: Alignment.center,
                                    child: GetBuilder<AppController>(
                                      builder: (controller) {
                                        AppInfoVo? appInfo = controller.appInfo;
                                        String invUri = invite.invUri;
                                        if (appInfo != null) {
                                          invUri =
                                              '$invUri?appNo=${appInfo.appInfo.seqNo}';
                                        }
                                        return QrImageView(
                                          data: invUri,
                                          size: 105.w,
                                          errorCorrectionLevel:
                                              QrErrorCorrectLevel.H,
                                          padding: EdgeInsets.zero,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                        left: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        top: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                        right: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                        left: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                        right: BorderSide(
                                          color: Colors.brown.shade100,
                                          width: 1.5.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.w),
                            child: Text(
                              '哇彩赛事',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.w),
                            child: Text(
                              '为您的热爱而尖叫喝彩',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 13.sp,
                                fontFamily: 'shuhei',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildWaterMark(invite.code),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -3),
              child: Material(
                shape: const InviteBottomShapeBorder(count: 18),
                color: Colors.white,
                child: Container(
                  width: 280.w,
                  padding: EdgeInsets.only(
                    bottom: 20.w,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 12.w,
                    ),
                    child: Column(
                      children: [
                        Transform.rotate(
                          angle: -pi / 45,
                          child: Container(
                            height: 26.w,
                            margin: EdgeInsets.only(bottom: 8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe655,
                                        fontFamily: 'iconfont'),
                                    size: 13.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '手机扫一扫打开上述二维码链接',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(8, 0),
                          child: Container(
                            height: 26.w,
                            margin: EdgeInsets.only(bottom: 8.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe652,
                                        fontFamily: 'iconfont'),
                                    size: 12.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '下载哇彩应用后安装到使用手机',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: -pi / 75,
                          child: Container(
                            height: 26.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 26.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.w),
                                    ),
                                  ),
                                  child: Icon(
                                    const IconData(0xe6ba,
                                        fontFamily: 'iconfont'),
                                    size: 13.w,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Text(
                                  '打开应用成功登录进行浏览使用',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterMark(String code) {
    return Container(
      width: 280.w,
      height: 220.w,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: List.generate(
            3,
            (index) => Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => Transform.rotate(
                        angle: -0.45,
                        child: Text(
                          index % 2 == 0 ? code : '',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
