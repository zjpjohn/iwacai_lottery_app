import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';

class TopicSliverHeader extends SliverPersistentHeaderDelegate {
  ///
  /// 垂直偏移量
  final double verticalOffset = 100.w;

  /// 文字垂直最大偏移
  final double fontOffset = 70.w;

  ///
  final double collapse = 44.w;
  final double maxExtend = 250.w;

  ///
  final double top;
  final SportNewsTopic topic;

  TopicSliverHeader({
    required this.top,
    required this.topic,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExtendedNetworkImageProvider(
                      topic.background,
                      cache: true,
                      scale: 1.0,
                    ),
                  ),
                ),
                child: Visibility(
                  visible: shrinkOffset <= fontOffset,
                  maintainSize: false,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          topic.title,
                          style: TextStyle(
                            color: shrinkColor(shrinkOffset, Colors.white),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '热度',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: shrinkColor(shrinkOffset, Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.w),
                              child: Text(
                                '${topic.hotIdx}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      shrinkColor(shrinkOffset, Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              width: 12.w,
                              height: 12.w,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.w),
                                color: shrinkColor(
                                  shrinkOffset,
                                  Colors.redAccent,
                                ),
                              ),
                              child: Text(
                                '热',
                                style: TextStyle(
                                  fontSize: 8.sp,
                                  color:
                                      shrinkColor(shrinkOffset, Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 48.w,
              width: Get.width,
              color: Colors.white,
            ),
          ],
        ),
        Positioned(
          bottom: 12.w,
          left: 0,
          child: _topicContent(shrinkOffset),
        ),
        Positioned(
          top: 0,
          child: _topHeader(shrinkOffset),
        ),
      ],
    );
  }

  Widget _topicContent(double shrinkOffset) {
    return SizedBox(
      width: Get.width,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.w),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: const Color(0xFFF8F8F8),
              blurRadius: 1.w,
              spreadRadius: 1.w,
            ),
          ],
        ),
        child: Text(
          topic.subtitle,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black87,
          ),
        ),
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
                      shrinkOffset >= verticalOffset ? topic.title : '',
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
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
