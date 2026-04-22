import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_setting_controller.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class MatchSettingView extends StatelessWidget {
  ///
  ///
  const MatchSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '提醒设置',
      content: GetBuilder<MatchSettingController>(
        init: MatchSettingController(),
        builder: (controller) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildGlobalSwitch(controller),
                  _buildHintRange(controller),
                  Container(
                    height: 12.w,
                    width: Get.width,
                    color: const Color(0xFFF6F6FB),
                  ),
                  _buildHintContent(controller),
                  Container(
                    height: 12.w,
                    width: Get.width,
                    color: const Color(0xFFF6F6FB),
                  ),
                  _buildHintEffects(controller),
                  Container(
                    height: 48.w,
                    width: Get.width,
                    color: const Color(0xFFF6F6FB),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlobalSwitch(MatchSettingController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '提醒开关',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '是否提醒',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.global == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.global = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintRange(MatchSettingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              '比赛范围',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              RadioButton(
                text: '全部比赛',
                value: 1,
                groupValue: controller.setting.range,
                changed: (value) {
                  controller.setRange(value);
                },
              ),
              SizedBox(width: 20.w),
              RadioButton(
                text: '主流联赛',
                value: 2,
                groupValue: controller.setting.range,
                changed: (value) {
                  controller.setRange(value);
                },
              ),
              SizedBox(width: 20.w),
              RadioButton(
                text: '关注比赛',
                value: 3,
                groupValue: controller.setting.range,
                changed: (value) {
                  controller.setRange(value);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHintContent(MatchSettingController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '提醒内容',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '球队进球',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.goal == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.goal = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '黄牌事件',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.yellow == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.yellow = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '红牌事件',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.red == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.red = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '比赛开始',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.start == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.start = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '比赛结束',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.end == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.end = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintEffects(MatchSettingController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.w,
        bottom: 6.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Text(
              '提醒效果',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '弹层提醒',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.overlay == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.overlay = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '震动效果',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.vibrate == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.vibrate = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5.w,
            color: const Color(0xFFF1F1F1),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '提示声音',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
                Transform.scale(
                  scale: 0.65,
                  child: CupertinoSwitch(
                    value: controller.setting.sound == 1,
                    trackColor: const Color(0xFFF6F6F6),
                    activeColor: const Color(0xFFFF0045),
                    onChanged: (value) {
                      controller.sound = value;
                    },
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

class RadioButton extends StatelessWidget {
  final String text;
  final int value;
  final int groupValue;
  final Function(int) changed;

  const RadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.changed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changed(value);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            width: 1.w,
            color: selected() ? const Color(0xFFFF0045) : Colors.black12,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.w,
                horizontal: 16.w,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: selected() ? const Color(0xFFFF0045) : Colors.black87,
                ),
              ),
            ),
            if (selected())
              Positioned(
                right: 1,
                bottom: 1,
                child: Icon(
                  const IconData(0xe658, fontFamily: 'iconfont'),
                  size: 18.sp,
                  color: const Color(0xFFFF0045),
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool selected() {
    return value == groupValue;
  }
}
