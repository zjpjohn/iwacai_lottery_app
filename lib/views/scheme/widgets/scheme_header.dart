import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/views/scheme/controller/scheme_detail_controller.dart';

class SchemeHeader extends SliverPersistentHeaderDelegate {
  final double expanded;
  final double collapse;
  final Widget child;
  final SchemeDetailController controller;

  SchemeHeader({
    required this.expanded,
    this.collapse = 46,
    required this.child,
    required this.controller,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: expanded,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: child,
          ),
          Positioned(
            top: 0,
            child: _buildHeader(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: collapse,
      decoration: BoxDecoration(
        color: makeStickyHeaderBgColor(shrinkOffset),
        border: Border(
          bottom: shrinkOffset >= maxExtent - minExtent
              ? BorderSide(color: const Color(0xFFF4F4F4), width: 0.5.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(left: 16.w),
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color:
                        shrinkBackColor(shrinkOffset, const Color(0xFFF1F1F1)),
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Icon(
                    const IconData(0xe669, fontFamily: 'iconfont'),
                    size: 17.w,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 28.w,
            padding: EdgeInsets.only(left: 3.w, right: 8.w),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.w),
              color: shrinkColor(
                shrinkOffset,
                controller.scheme.hasSubscribed == 0
                    ? const Color(0xFFFF0033).withOpacity(0.08)
                    : const Color(0xFFF4F4F4),
              ),
            ),
            child: shrinkOffset >= 50
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: makeImageOpacity(shrinkOffset),
                        child: Container(
                          height: 22.w,
                          width: 22.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.scheme.hasSubscribed == 0
                                ? const Color(0xFFFF0033).withOpacity(0.40)
                                : const Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.circular(22.w),
                          ),
                          child: CachedAvatar(
                            width: 19.w,
                            height: 19.w,
                            radius: 19.w,
                            url: controller.scheme.avatar,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: Text(
                          Tools.limitText(controller.scheme.name, 2),
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1.25,
                            fontWeight: FontWeight.w500,
                            color: shrinkColor(
                              shrinkOffset,
                              controller.scheme.hasSubscribed == 0
                                  ? const Color(0xFFFF0033)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(
                    '情报详情',
                    style: TextStyle(
                      color: shrinkBackColor(shrinkOffset, Colors.black),
                      fontSize: 17.sp,
                    ),
                  ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/scheme/history/${controller.scheme.expertNo}');
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(right: 16.w),
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 42.w,
                  height: 24.w,
                  child: Icon(
                    const IconData(0xe61d, fontFamily: 'iconfont'),
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha =
        (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color shrinkBackColor(double shrinkOffset, Color color) {
    if (shrinkOffset >= 50) {
      return Colors.transparent;
    }
    int oldAlpha = color.alpha;
    int alpha =
        ((50 - shrinkOffset) / 50 * oldAlpha).clamp(0, oldAlpha).toInt();
    return Color.fromARGB(alpha, color.red, color.green, color.blue);
  }

  Color shrinkColor(double shrinkOffset, Color color) {
    if (shrinkOffset <= 50) {
      return Colors.transparent;
    }
    int oldAlpha = color.alpha;
    int alpha = (shrinkOffset / (maxExtent - minExtent) * oldAlpha)
        .clamp(0, oldAlpha)
        .toInt();
    return Color.fromARGB(alpha, color.red, color.green, color.blue);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha =
          (shrinkOffset / (maxExtent - minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  double makeImageOpacity(double shrinkOffset) {
    if (shrinkOffset <= 50) {
      return 0;
    }
    double offset = maxExtent - minExtent;
    if (shrinkOffset <= offset) {
      return shrinkOffset / (maxExtent - minExtent);
    }
    return 1;
  }

  @override
  double get maxExtent => expanded;

  @override
  double get minExtent => collapse;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
