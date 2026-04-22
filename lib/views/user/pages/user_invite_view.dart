import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/names.dart';
import 'package:iwacai_lottery_app/store/user.dart';
import 'package:iwacai_lottery_app/utils/constants.dart';
import 'package:iwacai_lottery_app/utils/poster_util.dart';
import 'package:iwacai_lottery_app/views/base/share_request_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/user_invite_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/user_agent_rule.dart';
import 'package:iwacai_lottery_app/views/user/model/user_invite.dart';
import 'package:iwacai_lottery_app/views/user/widgets/invite_poster_widget.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_phasics.dart';

class UserInviteView extends StatelessWidget {
  ///
  ///
  const UserInviteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShareRequestWidget<UserInviteController>(
      title: '我的邀请',
      share: (controller) {
        _showAgentPoster(controller);
      },
      builder: (controller) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            physics: const EasyRefreshPhysics(bottomBouncing: false),
            child: Column(
              children: [
                _buildInviteInfo(controller.invite, controller.rule),
                _buildInviteRule(controller.rule),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInviteInfo(UserInvite invite, UserAgentRule rule) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
      child: Container(
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 32.w,
          bottom: 20.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${invite.invites}',
                                style: TextStyle(
                                  color: const Color(0xFFFd4A68),
                                  fontFamily: 'bebas',
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '人数',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${invite.rewards}',
                                style: TextStyle(
                                  color: const Color(0xFFFd4A68),
                                  fontFamily: 'bebas',
                                  fontSize: 20.sp,
                                ),
                              ),
                              Text(
                                '金币',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.inviteHistory);
                      },
                      child: Container(
                        width: 82.w,
                        height: 28.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFd4A68),
                          borderRadius: BorderRadius.circular(20.w),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFFFd4A68).withOpacity(0.4),
                                offset: const Offset(4, 4),
                                blurRadius: 8,
                                spreadRadius: 0.0)
                          ],
                        ),
                        child: Text(
                          '邀请历史',
                          style:
                          TextStyle(fontSize: 14.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 14.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w, top: 2.5.w),
                    child: Icon(
                      const IconData(0xe63d, fontFamily: 'iconfont'),
                      size: 12.sp,
                      color: const Color(0xFFD2B48C).withOpacity(0.5),
                    ),
                  ),
                  Text(
                    '邀请1人可获得${rule.reward}金币，金币可用于查看资讯动态',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteRule(UserAgentRule rule) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.w),
                child: Text(
                  '邀请流程',
                  style: TextStyle(
                    color: const Color(0xFFFF2933).withOpacity(0.90),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset(
                        R.shareScan,
                        width: 78.w,
                        height: 78.w,
                      ),
                      Text(
                        '1.邀请扫码',
                        style:
                        TextStyle(fontSize: 13.sp, color: Colors.black54),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          R.shareRegister,
                          width: 78.w,
                          height: 78.w,
                        ),
                        Text(
                          '2.下载注册',
                          style:
                          TextStyle(fontSize: 13.sp, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.w, top: 16.w),
                child: Text(
                  '邀请说明',
                  style: TextStyle(
                    color: const Color(0xFFFF2933).withOpacity(0.90),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                          text: rule.agent.value == 0
                              ? '1、每成功邀请一位有效好友，您将获得'
                              : '1、每成功邀请一位有效好友，您将享受该用户后续产生收益的'),
                      TextSpan(
                        text: rule.agent.value == 0
                            ? '${rule.reward}金币'
                            : '${(rule.ratio * 100).toInt()}%',
                        style: const TextStyle(color: Color(0xFFFF2933)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: Text(
                  rule.agent.value == 0
                      ? '2、邀请好友获得的奖励金币发放至我的余额账户中，您可以在查看付费数据时抵扣使用。'
                      : '2、系统会定期(默认每个月)计算您获得的收益，并会有专属客服提前联系您提现结算',
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: Text(
                  '3、点击二维码可以进入邀请海报页面，您可以保存海报至本地相册，便于后续分发宣传。',
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ),
              Text(
                '4、邀请奖励规则会根据系统运行实际情况进行一定的调整，调整解释权归系统本身所有。',
                style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showAgentPoster(UserInviteController controller) {
    Constants.shareBottomSheet(
      content: InvitePosterWidget(
        posterKey: controller.posterKey,
        userInfo: UserStore().authUser!,
        invite: controller.invite,
      ),
      save: () {
        PosterUtils.saveImage(controller.posterKey);
      },
      copyLink: () {
        Clipboard.setData(ClipboardData(text: controller.invite.invUri));
        EasyLoading.showToast('复制成功');
      },
    );
  }
}
