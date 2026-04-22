import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/names.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_rights_controller.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class UserRightsView extends StatelessWidget {
  ///
  ///
  const UserRightsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '权益中心',
      content: RequestWidget<UserRightsController>(
        emptyText: '暂无权益信息',
        builder: (controller) {
          return Container(
            color: const Color(0xFFF6F6FB),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildWelfare(),
                    _buildReward(),
                    _buildSurplus(),
                    _buildCoupon(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelfare() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              '专属福利',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _couponWelfare(),
          _voucherWelfare(),
        ],
      ),
    );
  }

  Widget _couponWelfare() {
    return Container(
      margin: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
      padding: EdgeInsets.only(left: 12.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '签到赚取奖励积分',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                '大额积分等着您',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.userSign);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(top: 6.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.w,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C2C2),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Text(
                    '赚取积分',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Image.asset(R.rightSign, height: 108.w),
        ],
      ),
    );
  }

  Widget _voucherWelfare() {
    return Container(
      height: 108.w,
      margin: EdgeInsets.only(top: 12.w, left: 12.w, right: 12.w),
      padding: EdgeInsets.only(left: 12.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '多重代金券持续放送',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                '惊喜不断等着您',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.voucherDraw);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(top: 6.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.w,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C2C2),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Text(
                    '前往领取',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Image.asset(R.rightVoucher, height: 80.w),
        ],
      ),
    );
  }

  Widget _buildReward() {
    return Container(
      width: Get.width,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              '奖励金',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: Get.width - 24.w,
            margin: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    '1.用户通过观看激励视频广告等方式获得奖励金',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  '2.奖励金按照1奖励金=0.01元兑换，奖励金可提现',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurplus() {
    return Container(
      width: Get.width,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              '金币奖励',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: Get.width - 24.w,
            margin: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    '1.用户通过领取优惠券等福利任务等方式获得金币',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  '2.金币与奖励金面额等值，但是账户金币不可提现',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoupon() {
    return Container(
      width: Get.width,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.symmetric(vertical: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              '积分奖励',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: Get.width - 24.w,
            margin: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: Text(
                    '1.用户通过签到等福利任务获取不定额度积分奖励',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  '2.积分可兑换为金币，积分兑换比例10积分=1金币',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
