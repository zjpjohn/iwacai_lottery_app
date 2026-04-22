import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_detail_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';
import 'package:iwacai_lottery_app/views/news/widgets/news_video_view.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class SportNewsView extends StatelessWidget {
  ///
  ///
  const SportNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '资讯详情',
      content: RequestWidget<NewsDetailController>(
        global: false,
        init: NewsDetailController(),
        builder: (controller) {
          return _buildNewsView(controller);
        },
      ),
    );
  }

  Widget _buildNewsView(NewsDetailController controller) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SingleChildScrollView(
        physics: const EasyRefreshPhysics(topBouncing: false),
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12.w),
                child: Text(
                  controller.news.title,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                children: [
                  if (controller.news.labelName.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        controller.news.labelName,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Text(
                      controller.news.realTime,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Text(
                    '${Tools.randLimit(controller.news.views, 50)}浏览',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
              _buildRelateList(controller.news.relates),
              controller.news.srcType == 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.w),
                      child: HtmlWidget(
                        controller.news.content,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                        ),
                        customStylesBuilder: (element) {
                          return null;
                        },
                      ),
                    )
                  : NewsVideoView(
                      video: controller.news.videoContent!.videoUrl,
                      width: controller.news.videoContent!.width,
                      height: controller.news.videoContent!.height,
                    ),
              _buildVoteView(controller),
              _buildRelateNews(controller.news.relates),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRelateList(List<Relate> relates) {
    if (relates.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(top: 8.w, right: 4.w),
      child: Row(
        children: [
          ...relates
              .where((e) => e.type.value == 4)
              .map((e) => _newsTopic(e))
              .toList(),
          ...relates
              .where((e) => e.type.value == 2 || e.type.value == 3)
              .map((e) => _newsRelate(e))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildVoteView(NewsDetailController controller) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 8.w),
      child: GestureDetector(
        onTap: () {
          controller.praiseNews();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 58.w,
          height: 58.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            border: Border.all(
              width: 1.2.w,
              color: controller.news.praised == 1
                  ? Colors.black12
                  : const Color(0xFFFF0045),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                const IconData(0xea21, fontFamily: 'iconfont'),
                size: 28.sp,
                color: controller.news.praised == 1
                    ? Colors.black12
                    : const Color(0xFFFF0045),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${controller.news.votes}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: controller.news.praised == 1
                            ? Colors.black26
                            : const Color(0xFFFF0045),
                      ),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.w),
                        child: Text(
                          '赞',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: controller.news.praised == 1
                                ? Colors.black26
                                : const Color(0xFFFF0045),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRelateNews(List<Relate> relates) {
    relates = relates.where((e) => e.type.value == 1).toList();
    if (relates.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.w),
          child: Text(
            '相关资讯',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...relates
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Get.toNamed('/news/${e.params['newsId']}');
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(bottom: 12.w),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.w,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    border: Border.all(color: Colors.black12, width: 0.2.w),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: Text(
                            e.params['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      CachedAvatar(
                        width: 72.w,
                        height: 40.w,
                        url: e.params['cover'],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  Widget _newsRelate(Relate relate) {
    ///联赛或球队
    return GestureDetector(
      onTap: () {
        if (relate.type.value == 2) {
          Get.toNamed('/league/${relate.params['leagueId']}');
          return;
        }
        if (relate.type.value == 3) {
          Get.toNamed(
              '/team/${relate.params['leagueId']}/${relate.params['teamId']}');
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (relate.params['logo'] != null && relate.params['logo'] != '')
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: CachedAvatar(
                  width: 12.w,
                  height: 12.w,
                  url: relate.params['logo'],
                ),
              ),
            Text(
              relate.params['name'],
              style: TextStyle(
                color: Colors.black87,
                fontSize: 11.sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _newsTopic(Relate relate) {
    ///联赛或球队
    return GestureDetector(
      onTap: () {
        Get.toNamed('/topic/${relate.params['topicId']}');
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: Text(
          relate.params['title'],
          style: TextStyle(
            color: Colors.black87,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
