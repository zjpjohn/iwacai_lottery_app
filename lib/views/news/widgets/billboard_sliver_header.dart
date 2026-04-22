import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

class BillboardSliverHeader extends SliverPersistentHeaderDelegate {
  ///
  /// 垂直偏移量
  final double verticalOffset = 100.w;

  ///
  /// 文字垂直最大偏移
  final double fontOffset = 70.w;

  ///
  ///
  final double collapse = 44.w;
  final double maxExtend = 180.w;

  ///
  final double top;

  BillboardSliverHeader(this.top);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtend,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(R.topicHeader2),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: maxExtend,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: _headerContent(shrinkOffset),
          ),
          Positioned(
            top: 0,
            child: _topHeader(shrinkOffset),
          ),
        ],
      ),
    );
  }

  Widget _topHeader(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: top + collapse,
      color: shrinkWhite(shrinkOffset),
      child: Column(
        children: [
          SizedBox(
            height: top,
            width: Get.width,
          ),
          Container(
            width: Get.width,
            height: collapse,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.w),
                      child: shrinkOffset >= verticalOffset
                          ? Icon(
                              const IconData(0xe669, fontFamily: 'iconfont'),
                              size: 18.w,
                              color: Colors.black87,
                            )
                          : null,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      shrinkOffset >= verticalOffset ? '24h热榜' : '',
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerContent(double shrinkOffset) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: Text(
            '24h热榜',
            style: TextStyle(
              fontSize: 40.sp,
              fontFamily: 'shuhei',
              fontWeight: FontWeight.w600,
              color: shrinkColor(shrinkOffset, Colors.white),
            ),
          ),
        ),
        Text(
          '— 最新最热足坛大事件 —',
          style: TextStyle(
            fontSize: 17.sp,
            fontFamily: 'shuhei',
            color: shrinkColor(shrinkOffset, Colors.white),
          ),
        ),
      ],
    );
  }

  Color shrinkColor(double shrinkOffset, Color color) {
    if (shrinkOffset == 0) {
      return color;
    }
    if (shrinkOffset <= fontOffset) {
      int oldAlpha = color.alpha;
      int alpha =
          (shrinkOffset / fontOffset * oldAlpha).clamp(0, oldAlpha).toInt();
      return Color.fromARGB(
          oldAlpha - alpha, color.red, color.green, color.blue);
    }
    return Colors.transparent;
  }

  ///
  /// header头部白色透明渐变
  Color shrinkWhite(double shrinkOffset) {
    if (shrinkOffset <= fontOffset) {
      return Colors.transparent;
    }
    if (shrinkOffset <= verticalOffset) {
      int alpha =
          ((shrinkOffset - fontOffset) / (verticalOffset - fontOffset) * 255)
              .clamp(0, 255)
              .toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
    return Colors.white;
  }

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => top + collapse;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
