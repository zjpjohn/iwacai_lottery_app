import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';

///
///
class SearchHeader extends SliverPersistentHeaderDelegate {
  ///
  double expanded;

  ///
  double collapse;

  ///
  /// 标题
  String title;

  ///
  /// 搜索数量
  int leagues;

  ///
  /// 垂直偏移量
  double vOffset = 10.w;

  ///
  /// 文字颜色偏移量
  double fOffset = 20.w;

  SearchHeader({
    required this.expanded,
    required this.collapse,
    required this.title,
    required this.leagues,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double positionR = 0.0, xOffset = 82.w;
    positionR =
        shrinkOffset <= vOffset ? xOffset * shrinkOffset / vOffset : xOffset;
    return SizedBox(
      height: expanded,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: _buildTopView(shrinkOffset),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: positionR,
            child: _buildSearchView(),
          ),
        ],
      ),
    );
  }

  Color logoColor(double shrinkOffset) {
    if (shrinkOffset == 0) {
      return Colors.white;
    }
    if (shrinkOffset <= fOffset) {
      int alpha = (shrinkOffset / fOffset * 255).clamp(0, 255).toInt();
      return Color.fromARGB(1 - alpha, 255, 255, 255);
    }
    return Colors.transparent;
  }

  Widget _buildTopView(double shrinkOffset) {
    return Container(
      width: Get.width,
      height: collapse,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: logoColor(shrinkOffset),
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'shuhei',
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.browseRecord);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        const IconData(0xe642, fontFamily: 'iconfont'),
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        '足  迹',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.focus);
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        const IconData(0xe618, fontFamily: 'iconfont'),
                        size: 20.sp,
                        color: Colors.white,
                      ),
                      Text(
                        '收  藏',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchView() {
    return Container(
      height: 50.w,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Container(
        padding: EdgeInsets.only(left: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: Colors.white, width: 1.0.w),
        ),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.search);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                const IconData(0xe62f, fontFamily: 'iconfont'),
                size: 14.sp,
                color: Colors.white,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  "超过$leagues+联赛提供搜索",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ),
              Container(
                height: 30.w,
                margin: EdgeInsets.only(right: 1.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                alignment: Alignment.center,
                child: Text(
                  '搜索',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
