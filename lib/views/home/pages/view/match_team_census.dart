import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';
import 'package:iwacai_lottery_app/views/base/model/team_census.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match/team_census_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_index_model.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/widgets/rate_line_chart.dart';
import 'package:iwacai_lottery_app/views/home/widgets/vs_feature_widget.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';
import 'package:iwacai_lottery_app/widgets/dash_line.dart';

class MatchTeamCensusView extends StatefulWidget {
  const MatchTeamCensusView({
    super.key,
    required this.match,
  });

  final SportMatch match;

  @override
  MatchTeamCensusState createState() => MatchTeamCensusState();
}

class MatchTeamCensusState extends State<MatchTeamCensusView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: RequestWidget<MatchTeamCensusController>(
        init: MatchTeamCensusController(widget.match.matchId),
        global: false,
        emptyText: '暂无技术统计',
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildGoalPanel(controller.goalIndex),
                Container(height: 8.w, color: const Color(0xFFF6F7FB)),
                _buildAttackDefendView(
                    controller.homeCensus, controller.awayCensus),
                Container(height: 8.w, color: const Color(0xFFF6F7FB)),
                _buildAttackFeature(
                  controller.homeCensus?.allData ?? TeamStatVal.empty(),
                  controller.awayCensus?.allData ?? TeamStatVal.empty(),
                ),
                Container(height: 8.w, color: const Color(0xFFF6F7FB)),
                _buildWolIndexView(
                    controller.wolIndex.home, controller.wolIndex.away),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalPanel(PointGoalIndex index) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.w, bottom: 8.w),
            child: Text(
              '主客进球分布',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildGoalIndex(
            title: Tools.limitText(widget.match.awayName, 6),
            color: const Color(0xff2866d5),
            goalStats: index.away,
          ),
          _buildGoalIndex(
            title: Tools.limitText(widget.match.homeName, 6),
            color: const Color(0xfff24040),
            goalStats: index.home,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalIndex({
    required String title,
    required Color color,
    required StatsInfo<PointGoalStats>? goalStats,
  }) {
    PointGoalStats stats = goalStats?.stats ?? PointGoalStats.empty();
    int total = goalStats?.played ?? 1;
    return Padding(
      padding: EdgeInsets.only(top: 12.w, left: 20.w, right: 20.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CommonWidgets.dotted(
                  size: 8.w,
                  color: color,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RateLineChart(
                  title: '0球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point0 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '1球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point1 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '2球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point2 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '3球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point3 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '4球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point4 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '5球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point5 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '6球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point6 / total,
                  color: color,
                ),
                RateLineChart(
                  title: '7+球',
                  width: 18.w,
                  height: 32.w,
                  duration: 500,
                  ratio: stats.point7 / total,
                  color: color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttackDefendView(TeamCensus? home, TeamCensus? away) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w, bottom: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
            child: Text(
              '主客进失球',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildAttackItem(
                    title: Tools.limitText(widget.match.awayName, 7),
                    color: const Color(0xff2866d5),
                    stats: away?.allData ?? TeamStatVal.empty(),
                    left: true,
                  ),
                ),
                SizedBox(
                  height: 80.w,
                  child: VerticalDashLine(
                    width: 1.0.w,
                    color: const Color(0x1F000000),
                    size: 5.w,
                  ),
                ),
                Expanded(
                  child: _buildAttackItem(
                    title: Tools.limitText(widget.match.homeName, 7),
                    color: const Color(0xfff24040),
                    stats: home?.allData ?? TeamStatVal.empty(),
                    left: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttackItem({
    required String title,
    required Color color,
    required TeamStatVal stats,
    bool left = true,
  }) {
    return Column(
      crossAxisAlignment:
          left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment:
              left ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (left)
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CommonWidgets.dotted(
                  size: 8.w,
                  color: color,
                ),
              ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
              ),
            ),
            if (!left)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: CommonWidgets.dotted(
                  size: 8.w,
                  color: color,
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 16.w,
            left: left ? 14.w : 0,
            right: !left ? 14.w : 0.w,
          ),
          child: Column(
            crossAxisAlignment:
                left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    left ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(
                    '${stats.averageScore}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      fontFamily: 'bebas',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Text(
                      '球',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '场均进球',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 16.w,
            left: left ? 14.w : 0,
            right: !left ? 14.w : 0.w,
          ),
          child: Column(
            crossAxisAlignment:
                left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    left ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(
                    '${stats.averageLost}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.sp,
                      fontFamily: 'bebas',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.w),
                    child: Text(
                      '球',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                '场均失球',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttackFeature(TeamStatVal home, TeamStatVal away) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.w, top: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
            child: Text(
              '主客攻防特征',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          VsFeatureWidget(
            title: '控球率',
            width: 166.w,
            max: 100,
            home: home.controlTime,
            homeName: '${home.controlTime.toStringAsFixed(1)}%',
            away: away.controlTime,
            awayName: '${away.controlTime.toStringAsFixed(1)}%',
          ),
          VsFeatureWidget(
            title: '进球率',
            width: 166.w,
            max: 100,
            home: home.attackToScoreRate,
            homeName: '${home.attackToScoreRate.toStringAsFixed(1)}%',
            away: away.attackToScoreRate,
            awayName: '${away.attackToScoreRate.toStringAsFixed(1)}%',
          ),
          VsFeatureWidget(
            title: '失球率',
            width: 166.w,
            max: 100,
            home: home.lostScoreRate,
            homeName: '${home.lostScoreRate.toStringAsFixed(1)}%',
            away: away.lostScoreRate,
            awayName: '${away.lostScoreRate.toStringAsFixed(1)}%',
          ),
          VsFeatureWidget(
            title: '射门次数',
            width: 166.w,
            max: 20,
            home: home.shoot,
            homeName: home.shoot.toStringAsFixed(1),
            away: away.shoot,
            awayName: away.shoot.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '被射门次数',
            width: 166.w,
            max: 20,
            home: home.beShooted,
            homeName: home.beShooted.toStringAsFixed(1),
            away: away.beShooted,
            awayName: away.beShooted.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '射正次数',
            width: 166.w,
            max: 10,
            home: home.shootOn,
            homeName: home.shootOn.toStringAsFixed(1),
            away: away.shootOn,
            awayName: away.shootOn.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '被射正次数',
            width: 166.w,
            max: 10,
            home: home.beShootOn,
            homeName: home.beShootOn.toStringAsFixed(1),
            away: away.beShootOn,
            awayName: away.beShootOn.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '威胁球个数',
            width: 166.w,
            max: 100,
            home: home.dangerousAttack,
            homeName: home.dangerousAttack.toStringAsFixed(1),
            away: away.dangerousAttack,
            awayName: away.dangerousAttack.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '角球个数',
            width: 166.w,
            max: 10,
            home: home.cornerKick,
            homeName: home.cornerKick.toStringAsFixed(1),
            away: away.cornerKick,
            awayName: away.cornerKick.toStringAsFixed(1),
          ),
          VsFeatureWidget(
            title: '罚角球个数',
            width: 166.w,
            max: 10,
            home: home.beCornerKick,
            homeName: home.beCornerKick.toStringAsFixed(1),
            away: away.beCornerKick,
            awayName: away.beCornerKick.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }

  Widget _buildWolIndexView(
      StatsInfo<WinLossStats>? home, StatsInfo<WinLossStats>? away) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w, top: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
            child: Text(
              '净胜平负场次',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          VsFeatureWidget(
            title: '平局',
            width: 166.w,
            max: 10,
            home: (home?.stats.draw ?? 0).toDouble(),
            homeName: '${home?.stats.draw ?? 0}',
            away: (away?.stats.draw ?? 0).toDouble(),
            awayName: '${away?.stats.draw ?? 0}',
          ),
          VsFeatureWidget(
            title: '净胜1球',
            width: 166.w,
            max: 10,
            home: (home?.stats.win1 ?? 0).toDouble(),
            homeName: '${home?.stats.win1 ?? 0}',
            away: (away?.stats.win1 ?? 0).toDouble(),
            awayName: '${away?.stats.win1 ?? 0}',
          ),
          VsFeatureWidget(
            title: '净胜2球',
            width: 166.w,
            max: 10,
            home: (home?.stats.win2 ?? 0).toDouble(),
            homeName: '${home?.stats.win2 ?? 0}',
            away: (away?.stats.win2 ?? 0).toDouble(),
            awayName: '${away?.stats.win2 ?? 0}',
          ),
          VsFeatureWidget(
            title: '净胜3球',
            width: 166.w,
            max: 10,
            home: (home?.stats.win3 ?? 0).toDouble(),
            homeName: '${home?.stats.win3 ?? 0}',
            away: (away?.stats.win3 ?? 0).toDouble(),
            awayName: '${away?.stats.win3 ?? 0}',
          ),
          VsFeatureWidget(
            title: '净负1球',
            width: 166.w,
            max: 10,
            home: (home?.stats.lose1 ?? 0).toDouble(),
            homeName: '${home?.stats.lose1 ?? 0}',
            away: (away?.stats.lose1 ?? 0).toDouble(),
            awayName: '${away?.stats.lose1 ?? 0}',
          ),
          VsFeatureWidget(
            title: '净负2球',
            width: 166.w,
            max: 10,
            home: (home?.stats.lose2 ?? 0).toDouble(),
            homeName: '${home?.stats.lose2 ?? 0}',
            away: (away?.stats.lose2 ?? 0).toDouble(),
            awayName: '${away?.stats.lose2 ?? 0}',
          ),
          VsFeatureWidget(
            title: '净负3球',
            width: 166.w,
            max: 10,
            home: (home?.stats.lose3 ?? 0).toDouble(),
            homeName: '${home?.stats.lose3 ?? 0}',
            away: (away?.stats.lose3 ?? 0).toDouble(),
            awayName: '${away?.stats.lose3 ?? 0}',
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
