import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_billboard_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/billboard_news.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';
import 'package:iwacai_lottery_app/views/news/widgets/billboard_sliver_header.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class NewsBillboardView extends StatelessWidget {
  ///
  ///
  const NewsBillboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: false,
          child: RequestWidget<NewsBillboardController>(
            builder: (controller) {
              return ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: BillboardSliverHeader(
                        MediaQuery.of(context).padding.top,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: controller.topicList
                              .map((e) => _topicItem(e))
                              .toList(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 8.w,
                        width: Get.width,
                        color: const Color(0xFFF6F6FB),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8.w),
                        child: Column(
                          children: _newsList(controller.newsList),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _topicItem(SportNewsTopic topic) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/topic/${topic.id}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.w),
                    child: Text(
                      '#',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFFFF0045),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    topic.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset(
                  R.hotFill,
                  width: 14.w,
                  height: 14.w,
                ),
                Text(
                  '${topic.hotIdx}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _newsList(List<BillboardNews> newsList) {
    List<Widget> views = [];
    for (int i = 0; i < newsList.length; i++) {
      int rank = i + 1;
      if (rank <= 3) {
        views.add(_newsTop(newsList[i], rank));
      } else {
        views.add(_newsCommon(newsList[i], rank));
      }
    }
    return views;
  }

  Widget _newsTop(BillboardNews news, int rank) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/news/${news.newsId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        child: Row(
          children: [
            SizedBox(
              width: 44.w,
              height: 44.w,
              child: Stack(
                children: [
                  CachedAvatar(
                    width: 44.w,
                    height: 44.w,
                    url: news.cover,
                    radius: 2.w,
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: ClipPath(
                      clipper: VoucherClipper(),
                      child: Container(
                        width: 16.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 2.w, bottom: 6.w),
                        decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                        ),
                        child: Text(
                          '$rank',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 44.w,
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black87,
                      ),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${news.views}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                            children: [
                              TextSpan(
                                text: '浏览',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: news.hotLabel == 2
                                ? Colors.red
                                : Colors.redAccent,
                          ),
                          child: Text(
                            news.hotLabel == 2 ? '爆' : '热',
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newsCommon(BillboardNews news, int rank) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/news/${news.newsId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24.w,
              alignment: Alignment.centerLeft,
              child: Text(
                '$rank',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
            ),
            Expanded(
              child: Text(
                news.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${news.views}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '浏览',
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.w),
                      color: news.hotLabel == 2 ? Colors.red : Colors.redAccent,
                    ),
                    child: Text(
                      news.hotLabel == 2 ? '爆' : '热',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.white,
                      ),
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
}

class VoucherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height - 4)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
