import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_topic_controller.dart';
import 'package:iwacai_lottery_app/views/news/model/news_topic.dart';
import 'package:iwacai_lottery_app/views/news/widgets/topic_sliver_header.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class NewsTopicView extends StatelessWidget {
  ///
  ///
  const NewsTopicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: false,
          child: RefreshWidget<NewsTopicController>(
            builder: (controller) {
              return CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: TopicSliverHeader(
                      topic: controller.topic,
                      top: MediaQuery.of(context).padding.top,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _topicNewsItem(controller.list[index]),
                      childCount: controller.list.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _topicNewsItem(TopicNewsItem item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/news/${item.id}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
        child: Row(
          children: [
            CachedAvatar(
              width: 44.w,
              height: 44.w,
              url: item.cover,
              radius: 2.w,
            ),
            Expanded(
              child: Container(
                height: 44.w,
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title.trim(),
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
                            text: '${item.delta.time}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                            children: [
                              TextSpan(
                                text: item.delta.text,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: RichText(
                            text: TextSpan(
                              text: '${item.views}',
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
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.w),
                            color: item.hotLabel == 2
                                ? Colors.red
                                : Colors.redAccent,
                          ),
                          child: Text(
                            item.hotLabel == 2 ? '爆' : '热',
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
}
