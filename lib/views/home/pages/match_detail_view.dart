import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_detail_controller.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_team_census.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_team_trend.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_team_witting.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/sport_match_cast.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_header.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_tab_indicator.dart';

class MatchDetailView extends StatefulWidget {
  ///
  const MatchDetailView({Key? key}) : super(key: key);

  @override
  MatchDetailViewState createState() => MatchDetailViewState();
}

class MatchDetailViewState extends State<MatchDetailView>
    with TickerProviderStateMixin {
  ///
  List<Widget> tabs = [
    Container(
      height: 28.h,
      child: const Text('赛况'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('数据'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('特征'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('动态'),
      alignment: Alignment.center,
    ),
  ];

  ///
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: 240.w,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(R.sportMatchBg),
                ),
              ),
            ),
            RequestWidget<MatchDetailController>(
              init: MatchDetailController(),
              global: false,
              builder: (controller) {
                List<Widget> views = [
                  SportMatchCastView(match: controller.match),
                  MatchTeamTrendView(match: controller.match),
                  MatchTeamCensusView(match: controller.match),
                  MatchTeamWittingView(match: controller.match),
                ];
                return ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ExtendedNestedScrollView(
                    onlyOneScrollInBody: true,
                    pinnedHeaderSliverHeightBuilder: () =>
                        MediaQuery.of(context).padding.top + 46,
                    headerSliverBuilder: (context, scrolled) {
                      return [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: SportMatchHeader(
                            focused: controller.match.focused,
                            focusHandle: () {
                              controller.focusMatch();
                            },
                            expanded: 240.w,
                            collapsed: MediaQuery.of(context).padding.top + 46,
                            content: _buildMatchContent(controller),
                            header: _buildMatchHeader(controller),
                          ),
                        ),
                      ];
                    },
                    body: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 0.15.w,
                                ),
                              ),
                            ),
                            child: _buildTabBar(),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: views,
                              controller: _tabController,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchHeader(MatchDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Tools.limitName(controller.match.awayName, 4),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 6.w),
                child: CachedAvatar(
                  width: 18.w,
                  height: 18.w,
                  radius: 18.w,
                  color: Colors.transparent,
                  fit: BoxFit.contain,
                  url: controller.match.awayLogo,
                  errorImage: R.football,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 50.w,
          alignment: Alignment.center,
          child: Text(
            controller.matchState(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontFamily: "bebas",
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 6.w),
                child: CachedAvatar(
                  width: 18.w,
                  height: 18.w,
                  radius: 18.w,
                  color: Colors.transparent,
                  fit: BoxFit.contain,
                  url: controller.match.homeLogo,
                  errorImage: R.football,
                ),
              ),
              Text(
                Tools.limitName(controller.match.homeName, 4),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchContent(MatchDetailController controller) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      child: AnimatedOpacity(
        opacity: controller.opacity,
        duration: const Duration(milliseconds: 1500),
        child: Container(
          width: Get.width - 80.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 32.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        '/team/${controller.match.leagueId}/${controller.match.awayId}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedAvatar(
                        width: 36.w,
                        height: 36.w,
                        radius: 36.w,
                        color: Colors.transparent,
                        url: controller.match.awayLogo,
                        errorImage: R.football,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          Tools.limitText(controller.match.awayName, 6),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateUtil.formatDate(
                        DateUtil.parse(
                          controller.match.vsDate,
                          pattern: "yyyy/MM/dd HH:mm:ss",
                        ),
                        format: "MM-dd HH:mm",
                      ),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      controller.match.state.description,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.w),
                      child: Text(
                        controller.matchState(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: "bebas",
                        ),
                      ),
                    ),
                    Text(
                      controller.match.league,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                        '/team/${controller.match.leagueId}/${controller.match.homeId}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedAvatar(
                        width: 36.w,
                        height: 36.w,
                        radius: 36.w,
                        color: Colors.transparent,
                        url: controller.match.homeLogo,
                        errorImage: R.football,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4.w),
                        child: Text(
                          Tools.limitText(controller.match.homeName, 6),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
      width: double.infinity,
      child: TabBar(
        tabs: tabs,
        controller: _tabController,
        labelPadding: EdgeInsets.only(left: 2.w, right: 2.w),
        isScrollable: false,
        labelColor: const Color(0xFF2866D5),
        unselectedLabelColor: Colors.black87,
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        indicator: CustomTabIndicator(
          ratio: 0.12,
          borderSide: BorderSide(color: const Color(0xFF2866D5), width: 1.75.w),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
