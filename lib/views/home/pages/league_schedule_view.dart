import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/league_schedule_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/widgets/shrink_offset_appbar.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class LeagueScheduleView extends StatefulWidget {
  const LeagueScheduleView({super.key});

  @override
  State<LeagueScheduleView> createState() => _LeagueScheduleViewState();
}

class _LeagueScheduleViewState extends State<LeagueScheduleView> {
  ///
  ///
  final ScrollController _scrollController = ScrollController();

  ///
  final StreamController<double> _streamController =
      StreamController<double>.broadcast();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F6FB),
          body: Stack(
            children: [
              RefreshWidget<LeagueScheduleController>(
                global: false,
                init: LeagueScheduleController(),
                scrollController: _scrollController,
                enableLoad: false,
                bottomBouncing: false,
                header: MaterialHeader(),
                builder: (controller) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildLeagueHeader(
                          league: controller.schedule.league,
                          season: controller.schedule.season,
                          matches: controller.schedule.matches.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 8.w),
                      ),
                      _buildScheduleMatches(controller.schedule.matches),
                    ],
                  );
                },
              ),
              StreamBuilder<double>(
                stream: _streamController.stream,
                initialData: 0.0,
                builder: (context, snapshot) {
                  return ShrinkOffsetAppbar(
                    title: '近期赛程',
                    throttle: 80.w,
                    shrinkOffset: snapshot.data ?? 0.0,
                    rightText: '详情',
                    rightAction: () {
                      var leagueId = Get.parameters['leagueId']!;
                      Get.toNamed('/league/$leagueId');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeagueHeader({
    required LeagueInfo league,
    LeagueSeason? season,
    int matches = 0,
  }) {
    return Container(
      width: Get.width,
      height: 160.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: ExtendedAssetImageProvider(
            R.scheduleBackground,
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 24.w),
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/league/${league.id}');
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: CachedAvatar(
                  width: 44.w,
                  height: 44.w,
                  url: league.logo,
                  fit: BoxFit.cover,
                  color: Colors.white54,
                ),
              ),
              SizedBox(
                height: 48.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      league.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      season != null
                          ? '联赛${season.name}赛季近期有$matches场比赛'
                          : '联赛近期暂无赛事比赛',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
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

  Widget _buildScheduleMatches(List<SportMatch> matches) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
          child: SportMatchView(
            match: matches[index],
          ),
        );
      },
      itemCount: matches.length,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
