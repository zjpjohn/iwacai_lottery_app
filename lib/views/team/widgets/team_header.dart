import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeamHeader extends SliverPersistentHeaderDelegate {
  double expanded;
  double collapse;
  Widget header;
  Widget content;
  Widget right;

  TeamHeader({
    required this.expanded,
    required this.collapse,
    required this.header,
    required this.content,
    required this.right,
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
      height: collapse,
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
            right,
          ],
        ),
      ),
    );
  }

  double _shrinkHeaderOpacity(double shrinkOffset) {
    if (shrinkOffset <= 40) {
      return 0;
    }
    return ((shrinkOffset - 40) / (maxExtent - minExtent - 40)).clamp(0, 1);
  }

  double _shrinkContentOpacity(double shrinkOffset) {
    if (shrinkOffset >= 42) {
      return 0;
    }
    return 1 - (shrinkOffset / 42).clamp(0, 1);
  }

  @override
  double get maxExtent => expanded;

  @override
  double get minExtent => collapse;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
