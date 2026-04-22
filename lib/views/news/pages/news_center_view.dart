import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/views/news/controller/channel_top_news.dart';
import 'package:iwacai_lottery_app/views/news/model/channel_news.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_all_view.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_china_view.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_five_view.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_world_view.dart';
import 'package:iwacai_lottery_app/views/scheme/pages/scheme_list_view.dart';
import 'package:iwacai_lottery_app/widgets/custom_tab_indicator.dart';
import 'package:iwacai_lottery_app/widgets/vertical_marquee.dart';

class NewsCenterView extends StatefulWidget {
  ///
  const NewsCenterView({Key? key}) : super(key: key);

  @override
  NewsCenterViewState createState() => NewsCenterViewState();
}

class NewsCenterViewState extends State<NewsCenterView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ///
  ///
  List<Widget> tabs = [
    Container(
      height: 20.w,
      child: const Text('热门'),
      alignment: Alignment.center,
    ),
    Container(
      height: 20.w,
      child: const Text('五大联赛'),
      alignment: Alignment.center,
    ),
    Container(
      height: 20.w,
      child: const Text('国际足球'),
      alignment: Alignment.center,
    ),
    Container(
      height: 20.w,
      child: const Text('中国足球'),
      alignment: Alignment.center,
    ),
  ];

  ///
  ///
  List<Widget> views = [
    const NewsAllView(),
    const NewsFiveView(),
    const NewsWorldView(),
    const NewsChinaView(),
  ];

  ///
  ///
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: views,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _hotNewsSwiper(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 40.w,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: TabBar(
                tabs: tabs,
                controller: tabController,
                labelPadding: EdgeInsets.only(left: 6.w, right: 6.w),
                isScrollable: true,
                labelColor: const Color(0xFFFF0033),
                unselectedLabelColor: const Color(0xCC000000),
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w400),
                labelStyle: TextStyle(
                  fontSize: 16.5.sp,
                  fontWeight: FontWeight.w500,
                ),
                indicator: CustomTabIndicator(
                  ratio: 0.15,
                  insets: EdgeInsets.only(bottom: 4.w),
                  borderSide: BorderSide(
                    color: const Color(0xFFFF0033),
                    width: 2.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotNewsSwiper() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.newsBillboard);
      },
      child: Container(
        height: 28.w,
        margin: EdgeInsets.only(top: 4.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Icon(
                const IconData(0xe690, fontFamily: 'iconfont'),
                size: 14.sp,
                color: const Color(0xFFFF0033),
              ),
            ),
            Expanded(
              child: GetBuilder<ChannelTopNews>(
                builder: (controller) {
                  ChannelNews? news = controller.news;
                  if (news == null || news.hotNews.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return VerticalMarquee(
                    height: 28.w,
                    radius: BorderRadius.zero,
                    color: Colors.transparent,
                    items: news.hotNews
                        .map(
                          (e) => Text(
                            e.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xBA000000),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
