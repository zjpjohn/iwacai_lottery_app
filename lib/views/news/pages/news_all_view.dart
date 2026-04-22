import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/news/controller/channel_top_news.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_all_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/channel_news.dart';
import 'package:iwacai_lottery_app/views/news/widgets/sport_date_match.dart';
import 'package:iwacai_lottery_app/views/news/widgets/sport_news_widget.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class NewsAllView extends StatefulWidget {
  ///
  const NewsAllView({Key? key}) : super(key: key);

  @override
  NewsAllViewState createState() => NewsAllViewState();
}

class NewsAllViewState extends State<NewsAllView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///
  int _currentIndex = 0;

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF6F7F9),
      child: RefreshWidget<NewsAllController>(
        init: NewsAllController(),
        scrollController: scrollController,
        topConfig: const ScrollTopConfig(align: TopAlign.right),
        builder: (controller) {
          return Column(
            children: [
              Column(
                children: [
                  _buildTopNews(),
                  _buildBannerNews(),
                  SportDateMatch(
                    matches: controller.matches,
                  ),
                ],
              ),
              _buildAllNews(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopNews() {
    return GetBuilder<ChannelTopNews>(
      builder: (controller) {
        ChannelNews? news = controller.news;
        if (news == null || news.topNews.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Column(
            children: news.topNews
                .sublist(0, min(3, news.topNews.length))
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Get.toNamed('/news/${e.newsId}');
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.w,
                        horizontal: 12.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.w),
                            child: Text(
                              e.title.trim(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Text(
                                  '置顶',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFFFF0045),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Text(
                                  '${e.views}浏览',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                              Text(
                                '${e.delta.time}${e.delta.text}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildBannerNews() {
    return GetBuilder<ChannelTopNews>(
      builder: (controller) {
        ChannelNews? news = controller.news;
        if (news == null || news.banners.isEmpty) {
          return const SizedBox.shrink();
        }
        return Stack(
          children: [
            CarouselSlider.builder(
              itemCount: news.banners.length,
              options: CarouselOptions(
                height: 168.w,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                autoPlay: news.banners.length > 1,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIdx) {
                return _bannerNewsItem(news.banners[index]);
              },
            ),
            Positioned(
              bottom: 8.w,
              right: 20.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  news.banners.length,
                  (index) => index,
                ).map((index) {
                  return Container(
                    width: 8.w,
                    height: 2.w,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2.w),
                      color: _currentIndex == index
                          ? const Color(0xFFE9E9E9)
                          : const Color(0x80F2F2F2),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _bannerNewsItem(TopNews news) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/news/${news.newsId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Stack(
          children: [
            CachedAvatar(
              width: double.infinity,
              height: 168.w,
              radius: 6.w,
              url: news.cover,
            ),
            Positioned(
              left: 0,
              bottom: -1,
              child: Container(
                height: 40.w,
                width: Get.width - 24.w,
                padding: EdgeInsets.only(top: 6.w, left: 10.w, right: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.w),
                    bottomRight: Radius.circular(6.w),
                  ),
                ),
                child: Text(
                  news.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllNews(NewsAllController controller) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12.w),
      child: Column(
        children: controller.allNews
            .map(
              (e) => SportNewsWidget(news: e),
            )
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
