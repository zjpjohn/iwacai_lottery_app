import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/news/model/sport_news.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class SportNewsWidget extends StatefulWidget {
  ///
  ///
  const SportNewsWidget({Key? key, required this.news}) : super(key: key);

  final SportNews news;

  @override
  SportNewsWidgetState createState() => SportNewsWidgetState();
}

class SportNewsWidgetState extends State<SportNewsWidget> {
  ///
  ///浏览量
  late int _views;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.20.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/news/${widget.news.newsId}');
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(bottom: 6.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.news.title.trim(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4.w, top: 2.w),
                    child: CachedAvatar(
                      width: 135.w,
                      height: 66.w,
                      radius: 2.w,
                      url: widget.news.cover,
                      error: '哇彩',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.news.hotLabel > 0)
                Image.asset(R.hotSpark, height: 15.w),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black38,
                    ),
                    text: '$_views',
                    children: [
                      TextSpan(
                        text: '浏览',
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  '${widget.news.delta.time}${widget.news.delta.text}',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.black38,
                  ),
                ),
              ),
              if (widget.news.catalog.isNotEmpty)
                _buildNewsCatalog(widget.news.catalog),
              if (widget.news.topics.isNotEmpty)
                _buildNewsTopics(widget.news.topics),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCatalog(String catalog) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      child: Text(
        catalog,
        style: TextStyle(
          fontSize: 11.sp,
          color: Colors.black38,
        ),
      ),
    );
  }

  Widget _buildNewsTopics(List<Topic> topicList) {
    return Row(
      children: topicList
          .map(
            (e) => GestureDetector(
              onTap: () {
                Get.toNamed('/topic/${e.topicId}');
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                padding: EdgeInsets.symmetric(
                  vertical: 2.w,
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Text(
                            '#',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFFFF0045),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: e.topic,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    _views = Tools.randLimit(widget.news.views, 100);
  }
}
