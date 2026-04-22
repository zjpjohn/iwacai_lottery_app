import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/scheme/controller/scheme_detail_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme_detail.dart';
import 'package:iwacai_lottery_app/views/scheme/widgets/scheme_header.dart';
import 'package:iwacai_lottery_app/views/user/widgets/lines.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class SchemeDetailView extends StatelessWidget {
  ///
  ///
  const SchemeDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: RequestWidget<SchemeDetailController>(
            global: false,
            init: SchemeDetailController(),
            builder: (controller) {
              return ExtendedNestedScrollView(
                headerSliverBuilder: (context, scrolled) {
                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SchemeHeader(
                        expanded: 156.w,
                        controller: controller,
                        child: _buildExpertView(controller),
                      ),
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildSchemeHeader(controller.scheme),
                            _buildSchemeItem(controller.scheme),
                            _buildSchemeContent(controller.scheme),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50.w,
                      right: 12.w,
                      child: _buildPraiseView(controller),
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

  Widget _buildExpertView(SchemeDetailController controller) {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, top: 10.w, bottom: 10.w),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 18.w),
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(25.w),
                  ),
                  child: CachedAvatar(
                    width: 42.w,
                    height: 42.w,
                    radius: 25.w,
                    url: controller.scheme.avatar,
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '浏览量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${controller.scheme.browses}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 28.w),
                      color: Colors.black54,
                      height: 20.w,
                      width: 0.25.w,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '关注量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${controller.scheme.subscribes}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 28.w),
                      color: Colors.black54,
                      height: 20.w,
                      width: 0.25.w,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.w),
                          child: Text(
                            '点赞量',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        Text(
                          '${controller.scheme.praises}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontFamily: 'bebas',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 6.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.5.w),
                        child: Text(
                          Tools.limitText(controller.scheme.name, 8),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        controller.scheme.zhong,
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.subscribeAction();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 5.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: controller.scheme.hasSubscribed == 0
                              ? const Color(0xFFFD4A68)
                              : const Color(0xFFF4F4F4),
                        ),
                        child: Text(
                          controller.scheme.hasSubscribed == 0 ? '关注他' : '已关注',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: controller.scheme.hasSubscribed == 0
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPraiseView(SchemeDetailController controller) {
    return GestureDetector(
      onTap: () {
        controller.praiseScheme();
      },
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: controller.scheme.hasPraised == 0
              ? const Color(0xFFFF0033)
              : const Color(0xFFECECEC).withOpacity(0.5),
          borderRadius: BorderRadius.circular(22.w),
        ),
        child: Icon(
          const IconData(0xea21, fontFamily: 'iconfont'),
          size: 22,
          color:
              controller.scheme.hasPraised == 0 ? Colors.white : Colors.black12,
        ),
      ),
    );
  }

  Widget _buildSchemeHeader(ExpSchemeDetail detail) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 30.w),
      child: Column(
        children: [
          Text(
            detail.title,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  detail.gmtCreate,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black26,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    '${detail.browse < 15 ? 15 : detail.browse}浏览',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black26),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Text(
                    '${detail.praise < 8 ? 8 : detail.praise}点赞',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black26),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSchemeItem(ExpSchemeDetail detail) {
    List<Widget> views = detail.items.map((e) {
      return Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 10.w),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xFFE9E9E9), width: 0.5.w),
                borderRadius: BorderRadius.circular(2.0.w),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.w),
                    child: Row(
                      children: [
                        Text(
                          e.event,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFFEF3454),
                          ),
                        ),
                        if (e.week.isNotEmpty)
                          VLine(
                            width: 1.w,
                            height: 12.w,
                            color: Colors.black38,
                            padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          ),
                        Text(
                          e.week,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        VLine(
                          width: 1.w,
                          height: 12.w,
                          color: Colors.black38,
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        ),
                        Text(
                          e.time.substring(0, e.time.length - 3),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        e.option,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFEF3454),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0.5.w,
              right: 0.5.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(2.w),
                    topRight: Radius.circular(2.w),
                  ),
                ),
                child: Text(
                  e.tag,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFFEF3454),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
    return Container(
      margin: EdgeInsets.only(top: 8.w, bottom: 8.w),
      child: Column(
        children: views,
      ),
    );
  }

  Widget _buildSchemeContent(ExpSchemeDetail detail) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: 16.w,
        bottom: 32.w,
      ),
      child: HtmlWidget(
        detail.content,
        textStyle: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
