import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/home/controller/home_center_controller.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_result_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class MatchFilterView extends StatefulWidget {
  ///
  ///
  const MatchFilterView({Key? key}) : super(key: key);

  @override
  MatchFilterViewState createState() => MatchFilterViewState();
}

class MatchFilterViewState extends State<MatchFilterView> {
  ///
  late int _type;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '赛事筛选',
      content: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: _buildFilterView(),
        ),
      ),
    );
  }

  Widget _buildFilterView() {
    switch (_type) {
      case 0:
        return _buildResultView();
      case 1:
        return _buildScheduleView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildScheduleView() {
    return GetBuilder<HomeCenterController>(
      builder: (controller) {
        return Column(
          children: [
            _leagueDateView(
              leagueId: controller.query.leagueId,
              dateLeague: controller.dateLeague,
              leagues: controller.leagues,
              callback: (league) {
                controller.setDateFilter(league);
              },
            ),
            _mainLeagueView(
              leagueId: controller.query.leagueId,
              dateLeague: controller.dateLeague,
              leagues: controller.mainLeagues,
              callback: (league) {
                controller.setMainFilter(league);
              },
            ),
            _mainCountryView(
              countryId: controller.query.countryId,
              leagues: controller.mainCountries,
              callback: (country) {
                controller.setCountryFilter(country);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultView() {
    return GetBuilder<MatchResultController>(
      builder: (controller) {
        return Column(
          children: [
            _leagueDateView(
              leagueId: controller.query.leagueId,
              dateLeague: controller.dateLeague,
              leagues: controller.leagues,
              callback: (league) {
                controller.setDateFilter(league);
              },
            ),
            _mainLeagueView(
              leagueId: controller.query.leagueId,
              dateLeague: controller.dateLeague,
              leagues: controller.mainLeagues,
              callback: (league) {
                controller.setMainFilter(league);
              },
            ),
            _mainCountryView(
              countryId: controller.query.countryId,
              leagues: controller.mainCountries,
              callback: (country) {
                controller.setCountryFilter(country);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _leagueDateView({
    int? leagueId,
    bool? dateLeague,
    required List<LeagueDate> leagues,
    required Function(int) callback,
  }) {
    if (leagues.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              '今日赛事',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 12.w,
            childAspectRatio: 2.5,
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: leagues
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      callback(e.leagueId);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.only(right: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.w),
                        color: (dateLeague ?? false) && leagueId == e.leagueId
                            ? Colors.purple.withOpacity(0.08)
                            : const Color(0xFFF6F7F9),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: CachedAvatar(
                              width: 30.w,
                              height: 30.w,
                              radius: 2.w,
                              url: e.logo,
                              fit: BoxFit.fitWidth,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Tools.limitText(e.name, 4),
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: (dateLeague ?? false) &&
                                            leagueId == e.leagueId
                                        ? Colors.purple
                                        : Colors.black87,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: '今日',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black54,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${e.matches}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color(0xFFFF0045),
                                        ),
                                      ),
                                      const TextSpan(text: '场'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _mainLeagueView({
    int? leagueId,
    bool? dateLeague,
    required List<MatchFilter> leagues,
    required Function(int) callback,
  }) {
    if (leagues.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              '主流联赛',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 5,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.75,
            padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: leagues
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      callback(e.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.only(top: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        border: Border.all(
                          width: 0.8.w,
                          color: (dateLeague == null || !dateLeague) &&
                                  leagueId == e.id
                              ? Colors.purple
                              : const Color(0xFFF6F7F9),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: CachedAvatar(
                              width: 32.w,
                              height: 32.w,
                              url: e.logo,
                              color: Colors.white,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            child: Text(
                              Tools.limitText(e.name, 4),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: (dateLeague == null || !dateLeague) &&
                                        leagueId == e.id
                                    ? Colors.purple
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F7F9),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.w),
                                bottomRight: Radius.circular(4.w),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: '今日',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black54,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${e.amount}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFFFF0045),
                                    ),
                                  ),
                                  const TextSpan(text: '场'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _mainCountryView({
    int? countryId,
    required List<MatchFilter> leagues,
    required Function(int) callback,
  }) {
    if (leagues.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.w),
            child: Text(
              '主流国家',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 5,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            childAspectRatio: 1.1,
            padding: EdgeInsets.only(top: 8.w, bottom: 24.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: leagues
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      callback(e.id);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: EdgeInsets.only(top: 4.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        border: Border.all(
                          width: 0.8.w,
                          color: countryId == e.id
                              ? Colors.purple
                              : const Color(0xFFF6F7F9),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                Tools.limitText(e.name, 4),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: countryId == e.id
                                      ? Colors.purple
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF6F7F9),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4.w),
                                bottomRight: Radius.circular(4.w),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: '今日',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black54,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${e.amount}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFFFF0045),
                                    ),
                                  ),
                                  const TextSpan(text: '场'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _type = int.parse(Get.parameters['type']!);
  }
}
