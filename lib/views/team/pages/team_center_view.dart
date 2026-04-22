import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/widgets/season_picker_view.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_center_controller.dart';
import 'package:iwacai_lottery_app/views/team/pages/team_census_view.dart';
import 'package:iwacai_lottery_app/views/team/pages/team_info_view.dart';
import 'package:iwacai_lottery_app/views/team/pages/team_schedule_view.dart';
import 'package:iwacai_lottery_app/views/team/pages/team_witting_view.dart';
import 'package:iwacai_lottery_app/views/team/widgets/team_header.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_tab_indicator.dart';

class TeamCenterView extends StatefulWidget {
  ///
  const TeamCenterView({Key? key}) : super(key: key);

  @override
  TeamCenterViewState createState() => TeamCenterViewState();
}

class TeamCenterViewState extends State<TeamCenterView>
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
      child: const Text('动态'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('赛程'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('技术'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('资料'),
      alignment: Alignment.center,
    ),
  ];

  ///
  final GlobalKey<TeamWittingViewState> wittingKey = GlobalKey();
  final GlobalKey<TeamScheduleViewState> scheduleKey = GlobalKey();
  final GlobalKey<TeamCensusViewState> censusKey = GlobalKey();
  final GlobalKey<TeamInfoViewState> teamKey = GlobalKey();

  ///
  late TabController _tabController;

  ///
  List<Widget> views = [];

  void triggerTabRefresh() {
    int index = _tabController.index;
    switch (index) {
      case 1:
        scheduleKey.currentState?.refresh();
        break;
      case 2:
        censusKey.currentState?.refresh();
        break;
      default:
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
                    R.teamHeaderBg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            RequestWidget<TeamCenterController>(
              builder: (controller) {
                return ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ExtendedNestedScrollView(
                    onlyOneScrollInBody: true,
                    controller: _scrollController,
                    pinnedHeaderSliverHeightBuilder: () =>
                        MediaQuery.of(context).padding.top + 46,
                    headerSliverBuilder: (context, scroller) {
                      return [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: TeamHeader(
                            expanded: 150.w,
                            collapse: MediaQuery.of(context).padding.top + 46,
                            header: _buildTeamHeader(controller),
                            content: _buildTeamContent(controller),
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
                                  color: Colors.black12,
                                  width: 0.25.w,
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

  Widget _buildTeamHeader(TeamCenterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4.w, top: 2.w),
          child: CachedAvatar(
            width: 15.w,
            height: 15.w,
            url: controller.team.logo,
          ),
        ),
        GestureDetector(
          onTap: () {
            showSeasonModal(controller);
          },
          child: Row(
            children: [
              Text(
                controller.team.nameCn,
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

  Widget _buildTeamContent(TeamCenterController controller) {
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
              url: controller.team.logo,
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
                      controller.team.nameCn,
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
                  Text(
                    controller.season!.name + '赛季',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightHeader(TeamCenterController controller) {
    return GestureDetector(
      onTap: () {
        controller.focusAction();
      },
      child: SizedBox(
        width: 36.w,
        height: 32.w,
        child: Icon(
          const IconData(0xe7f7, fontFamily: 'iconfont'),
          size: 20.w,
          color: controller.team.focused == 0
              ? Colors.white
              : const Color(0xFF00DD00),
        ),
      ),
    );
  }

  void showSeasonModal(TeamCenterController controller) {
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
      TeamWittingView(key: wittingKey),
      TeamScheduleView(key: scheduleKey),
      TeamCensusView(key: censusKey),
      TeamInfoView(key: teamKey),
    ];
    _tabController = TabController(length: tabs.length, vsync: this);
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
