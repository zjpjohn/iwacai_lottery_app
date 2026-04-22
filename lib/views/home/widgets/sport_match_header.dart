import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

typedef FocusMatchHandle = Function();

class SportMatchHeader extends SliverPersistentHeaderDelegate {
  ///是否订阅
  int focused;

  ///订阅操作
  FocusMatchHandle focusHandle;

  ///展开高度
  double expanded;

  ///收起高度
  double collapsed;

  ///内容组件
  Widget content;

  ///header组件
  Widget header;

  SportMatchHeader({
    required this.focused,
    required this.focusHandle,
    required this.expanded,
    required this.collapsed,
    required this.content,
    required this.header,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Opacity(
              opacity: _shrinkContentOpacity(shrinkOffset),
              child: content,
            ),
          ),
          Positioned(
            top: 0,
            child: _buildHeaderView(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderView(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: collapsed,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 46,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SizedBox(
                width: 36.w,
                height: 32.w,
                child: Icon(
                  const IconData(0xe669, fontFamily: 'iconfont'),
                  size: 20.w,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: _shrinkHeaderOpacity(shrinkOffset),
                child: header,
              ),
            ),
            GestureDetector(
              onTap: () {
                focusHandle();
              },
              child: SizedBox(
                width: 36.w,
                height: 32.w,
                child: Icon(
                  const IconData(0xe7f7, fontFamily: 'iconfont'),
                  size: 20.w,
                  color: focused == 0 ? Colors.white : const Color(0xFF00DD00),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _shrinkHeaderOpacity(double shrinkOffset) {
    if (shrinkOffset <= 50) {
      return 0;
    }
    return ((shrinkOffset - 50) / (maxExtent - minExtent - 50)).clamp(0, 1);
  }

  double _shrinkContentOpacity(double shrinkOffset) {
    if (shrinkOffset >= 90) {
      return 0;
    }
    return 1 - (shrinkOffset / 90).clamp(0, 1);
  }

  @override
  double get maxExtent => expanded;

  @override
  double get minExtent => collapsed;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
