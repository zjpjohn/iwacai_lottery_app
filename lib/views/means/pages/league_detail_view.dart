import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/league_home_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/league_rank_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/league_schedule_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/league_stats_view.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/league_team_view.dart';
import 'package:iwacai_lottery_app/views/means/widgets/league_header.dart';
import 'package:iwacai_lottery_app/views/means/widgets/season_picker_view.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_tab_indicator.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/modal_sheet_view.dart';

class LeagueDetailView extends StatefulWidget {
  ///
  const LeagueDetailView({Key? key}) : super(key: key);

  @override
  LeagueDetailViewState createState() => LeagueDetailViewState();
}

class LeagueDetailViewState extends State<LeagueDetailView>
    with TickerProviderStateMixin {
  ///
  /// 滑动控制器
  late ScrollController _scrollController;

  ///滑动偏移量
  double _offset = 0;

  ///
  List<Widget> tabs = [
    Container(
      height: 28.h,
      child: const Text('首页'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('赛程'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('积分'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('统计'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('球队'),
      alignment: Alignment.center,
    ),
  ];

  ///
  final GlobalKey<LeagueHomeViewState> homeKey = GlobalKey();
  final GlobalKey<LeagueRankViewState> rankKey = GlobalKey();
  final GlobalKey<LeagueScheduleViewState> scheduleKey = GlobalKey();
  final GlobalKey<LeagueStatsViewState> statsKey = GlobalKey();
  final GlobalKey<LeagueTeamViewState> teamKey = GlobalKey();

  List<Widget> views = [];

  ///
  late TabController _tabController;

  ///
  void triggerTabRefresh() {
    int index = _tabController.index;
    switch (index) {
      case 0:
        homeKey.currentState?.refresh();
        break;
      case 1:
        scheduleKey.currentState?.refresh();
        break;
      case 2:
        rankKey.currentState?.refresh();
        break;
      case 3:
        statsKey.currentState?.refresh();
        break;
      case 4:
        teamKey.currentState?.refresh();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: Get.width,
              height: 150.w,
              child: ClipRect(
                child: Transform.scale(
                  scale: (150.w + _offset) / (150.w),
                  child: Image.asset(
                    R.leagueHeaderBg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            RequestWidget<LeagueDetailController>(
              builder: (controller) {
                return ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ExtendedNestedScrollView(
                    onlyOneScrollInBody: true,
                    controller: _scrollController,
                    pinnedHeaderSliverHeightBuilder: () =>
                        MediaQuery.of(context).padding.top + 46,
                    headerSliverBuilder: (context, scrolled) {
                      return [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: LeagueHeader(
                            expanded: 150.w,
                            collapse: MediaQuery.of(context).padding.top + 46,
                            ruleHandle: () {
                              showLeagueRule(controller.league);
                            },
                            header: _buildLeagueHeader(controller),
                            content: _buildLeagueContent(controller),
                            right: _buildRightHeader(controller),
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12, width: 0.25.w),
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
                          )
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

  void showSeasonModal(LeagueDetailController controller) {
    controller.showSeason = true;
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0.w),
            topRight: Radius.circular(6.0.w),
          ),
        ),
        builder: (BuildContext context) {
          return SeasonPickerView(
            picked: controller.season,
            seasons: controller.seasons,
            onSelected: (season) {
              controller.season = season;
              triggerTabRefresh();
            },
            onClosed: () {
              controller.showSeason = false;
            },
          );
        });
  }

  void showLeagueRule(LeagueInfo league) {
    MediaQueryData mediaData = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.0.w),
          topRight: Radius.circular(6.0.w),
        ),
      ),
      builder: (context) {
        return ModalSheetView(
          title: '赛制规则',
          height: mediaData.size.height - mediaData.padding.top - 46,
          child: Container(
            padding: EdgeInsets.only(
              top: 12.w,
              bottom: 20.w,
              left: 16.w,
              right: 16.w,
            ),
            child: league.rule.isNotEmpty
                ? Text(
                    league.rule,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 32.w),
                    child: EmptyView(
                      size: 112.w,
                      message: '暂无赛制规则',
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildLeagueHeader(LeagueDetailController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4.w, top: 2.w),
          child: CachedAvatar(
            width: 15.w,
            height: 15.w,
            url: controller.league.logo,
          ),
        ),
        GestureDetector(
          onTap: () {
            showSeasonModal(controller);
          },
          child: Row(
            children: [
              Text(
                controller.league.name +
                    (controller.league.cup == 1 ? '杯赛' : '联赛'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                controller.showSeason
                    ? Icons.arrow_drop_up_sharp
                    : Icons.arrow_drop_down_sharp,
                color: Colors.white,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeagueContent(LeagueDetailController controller) {
    return Container(
      width: Get.width,
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 16.w),
      padding: EdgeInsets.only(left: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 6.w, top: 4.w),
            child: CachedAvatar(
              width: 34.w,
              height: 34.w,
              url: controller.league.logo,
            ),
          ),
          GestureDetector(
            onTap: () {
              showSeasonModal(controller);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.league.name +
                          (controller.league.cup == 1 ? '杯赛' : '联赛'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      controller.showSeason
                          ? Icons.arrow_drop_up_sharp
                          : Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
                if (controller.season != null)
                  Row(
                    children: [
                      Text(
                        controller.season!.name + '赛季',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.sp,
                        ),
                      ),
                      if (controller.round != null)
                        Padding(
                          padding: EdgeInsets.only(left: 6.w),
                          child: Text(
                            controller.round!.round,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      if (controller.round != null &&
                          controller.round!.maxRound.isNotEmpty)
                        Text(
                          '/${controller.round!.maxRound}',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13.sp,
                          ),
                        )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightHeader(LeagueDetailController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w),
      child: GestureDetector(
        onTap: () {
          controller.focusAction();
        },
        child: SizedBox(
          width: 32.w,
          height: 32.w,
          child: Icon(
            const IconData(0xe7f7, fontFamily: 'iconfont'),
            size: 20.w,
            color: controller.league.focused == 0
                ? Colors.white
                : const Color(0xFF00DD00),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 24.w),
      width: double.infinity,
      child: TabBar(
        tabs: tabs,
        controller: _tabController,
        labelPadding: EdgeInsets.only(left: 2.w, right: 2.w),
        isScrollable: false,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.black87,
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        indicator: CustomTabIndicator(
          ratio: 0.15,
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    views = [
      LeagueHomeView(key: homeKey),
      LeagueScheduleView(key: scheduleKey),
      LeagueRankView(key: rankKey),
      LeagueStatsView(key: statsKey),
      LeagueTeamView(key: teamKey),
    ];
    _tabController = TabController(
      length: tabs.length,
      initialIndex: int.parse(Get.parameters['index'] ?? '0'),
      vsync: this,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _offset = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
