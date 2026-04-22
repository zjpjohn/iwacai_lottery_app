import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/controller.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_center_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/user_balance.dart';
import 'package:iwacai_lottery_app/views/user/widgets/ucenter_header.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';

class UserCenterView extends StatefulWidget {
  ///
  ///
  const UserCenterView({Key? key}) : super(key: key);

  @override
  UserCenterViewState createState() => UserCenterViewState();
}

class UserCenterViewState extends State<UserCenterView>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6FB),
        body: SafeArea(
          top: false,
          child: RefreshWidget<UserCenterController>(
            init: UserCenterController(),
            showLoading: false,
            enableLoad: false,
            bottomBouncing: false,
            builder: (controller) {
              return CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: UCenterHeader(MediaQuery.of(context).padding.top),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.only(top: 8.w),
                      color: const Color(0xFFF6F6FB),
                      child: Column(
                        children: [
                          _userBrowserView(),
                          _accountBalanceView(),
                          _functionPanelView(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.w,
                        left: 12.w,
                        right: 12.w,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Column(
                        children: [
                          functionItemView(
                            title: '帮助中心',
                            handle: () {
                              Get.toNamed(AppRoutes.help);
                            },
                          ),
                          functionItemView(
                            title: '建议反馈',
                            handle: () {
                              Get.toNamed(AppRoutes.feedback);
                            },
                          ),
                          GetBuilder<AppController>(
                            builder: (controller) {
                              return _dottedFunctionItem(
                                title: '关于应用',
                                content: controller.appVersion,
                                dotted: !controller.latestVersion,
                                handle: () {
                                  Get.toNamed(AppRoutes.about);
                                },
                              );
                            },
                          ),
                          GetBuilder<AppController>(
                            builder: (controller) {
                              return _dottedFunctionItem(
                                title: '检测更新',
                                bordered: false,
                                content:
                                    !controller.latestVersion ? '有新版本' : '最新版本',
                                dotted: !controller.latestVersion,
                                handle: () {
                                  if (controller.latestVersion) {
                                    EasyLoading.showToast('最新版本');
                                    return;
                                  }
                                  controller.upgrade();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10.w,
                        left: 12.w,
                        right: 12.w,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.w),
                      ),
                      child: Column(
                        children: [
                          functionItemView(
                            title: '隐私政策',
                            handle: () {
                              Get.toNamed(AppRoutes.privacy);
                            },
                          ),
                          functionItemView(
                            title: '使用协议',
                            border: 0,
                            handle: () {
                              Get.toNamed(AppRoutes.usage);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 24.w),
                      child: Text(
                        '哇彩赛事为您提供优质服务',
                        style: TextStyle(
                          color: Colors.brown.shade100,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 52.w,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _userBrowserView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.focus);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                size: 24,
                title: '收藏',
                bottom: 2,
                icon: R.subscribeIcon,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.browseRecord);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                size: 24,
                bottom: 2,
                title: '浏览',
                icon: R.footprintIcon,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.message);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                size: 24,
                bottom: 2,
                title: '消息',
                icon: R.messageIcon,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.kefuContact);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                size: 24,
                bottom: 2,
                title: '客服',
                icon: R.kefuIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _accountBalanceView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: GetBuilder<BalanceInstance>(
        builder: (store) {
          UserBalance? balance = store.balance;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/balance/0');
                },
                child: Column(
                  children: [
                    Container(
                      height: 26.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.balance : 0}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Text(
                      '奖励金',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '金额提现',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed('/balance/1');
                },
                child: Column(
                  children: [
                    Container(
                      height: 26.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.surplus : 0}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Text(
                      '金 币',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '查看抵扣',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed(AppRoutes.userSign);
                },
                child: Column(
                  children: [
                    Container(
                      height: 26.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.coupon : 0}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Text(
                      '积 分',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '兑换金币',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed(AppRoutes.voucher);
                },
                child: Column(
                  children: [
                    Container(
                      height: 26.w,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 2.w),
                      child: Text(
                        '${balance != null ? balance.voucher : 0}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black,
                          fontFamily: 'bebas',
                        ),
                      ),
                    ),
                    Text(
                      '代金券',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '定期赠送',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.toNamed(AppRoutes.account);
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 2.w),
                      child: Image.asset(
                        R.acctBalance,
                        height: 26.w,
                        width: 30.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      '我的账户',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _functionPanelView() {
    return Container(
      margin: EdgeInsets.only(top: 10.w, left: 12.w, right: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.invite);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                icon: R.inviteIcon,
                title: '邀请好友',
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.userSign);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                icon: R.signIcon,
                title: '积分签到',
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.userRights);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                icon: R.rightsIcon,
                title: '权益中心',
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.matchSetting);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                icon: R.assistIcon,
                title: '管理助手',
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.settings);
              },
              behavior: HitTestBehavior.opaque,
              child: _cellWidget(
                icon: R.acctSetting,
                title: '账户设置',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cellWidget({
    required String icon,
    required String title,
    double size = 28,
    double bottom = 6,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: bottom.w),
          child: Image.asset(
            icon,
            width: size.w,
            height: size.w,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget functionItemView({
    required String title,
    int border = 1,
    double margin = 0,
    required Function handle,
  }) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: margin == 1 ? EdgeInsets.only(bottom: 10.w) : null,
      child: GestureDetector(
        onTap: () {
          handle();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 52.w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: border == 1
                ? Border(
                    bottom: BorderSide(
                        color: const Color(0xFFECECEC), width: 0.4.w),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    const IconData(0xe8b3, fontFamily: 'iconfont'),
                    color: Colors.black26,
                    size: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _dottedFunctionItem({
    required String title,
    String content = '',
    bool bordered = true,
    bool dotted = false,
    Function? handle,
  }) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () {
          if (handle != null) {
            handle();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 52.w,
          decoration: BoxDecoration(
            color: Colors.white,
            border: bordered
                ? Border(
                    bottom: BorderSide(
                        color: const Color(0xFFECECEC), width: 0.4.w),
                  )
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  if (dotted)
                    CommonWidgets.dotted(
                      size: 6.w,
                      color: const Color(0xFFFF0033),
                    ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      const IconData(0xe8b3, fontFamily: 'iconfont'),
                      size: 12.w,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
