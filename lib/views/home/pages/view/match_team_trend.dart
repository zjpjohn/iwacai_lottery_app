import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match/match_trend_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/match_team_stats.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';

class MatchTeamTrendView extends StatefulWidget {
  const MatchTeamTrendView({
    super.key,
    required this.match,
  });

  final SportMatch match;

  @override
  State<MatchTeamTrendView> createState() => _MatchTeamTrendViewState();
}

class _MatchTeamTrendViewState extends State<MatchTeamTrendView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: RequestWidget<MatchTrendController>(
        init: MatchTrendController(widget.match.matchId),
        global: false,
        emptyText: '暂无对阵数据',
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildTeamScoreView(controller),
                Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                _buildBattleView(controller),
                Container(height: 8.w, color: const Color(0xFFF6F6FB)),
                _buildRecentMatch(controller),
                SizedBox(height: 24.w),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamScoreView(MatchTrendController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '积分排名',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildScoreHeader(),
          ..._buildScoreList(
            controller.homeStats,
            controller.awayStats,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildScoreList(MatchTeamStats home, MatchTeamStats away) {
    List<Widget> views = [];
    LeagueTeamScore? homeScore = home.teamScore;
    LeagueTeamScore? awayScore = away.teamScore;
    if (homeScore != null && awayScore != null) {
      if (homeScore.rank <= awayScore.rank) {
        views
          ..add(_buildScoreItem(name: home.name, score: homeScore))
          ..add(_buildScoreItem(
              name: away.name, score: awayScore, bordered: false));
      } else {
        views
          ..add(_buildScoreItem(name: away.name, score: awayScore))
          ..add(
            _buildScoreItem(name: home.name, score: homeScore, bordered: false),
          );
      }
      views.add(_buildAllScore());
    } else if (homeScore != null) {
      views
        ..add(
          _buildScoreItem(name: home.name, score: homeScore, bordered: false),
        )
        ..add(_buildAllScore());
    } else if (awayScore != null) {
      views
        ..add(
          _buildScoreItem(name: away.name, score: awayScore, bordered: false),
        )
        ..add(_buildAllScore());
    } else {
      views.add(
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
          child: Text(
            '暂无积分排名',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 13.sp,
            ),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildAllScore() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/league/${widget.match.leagueId}?index=2');
        },
        child: Container(
          width: 240.w,
          height: 34.w,
          margin: EdgeInsets.only(top: 6.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(30.w),
          ),
          child: Text(
            '完整积分榜单',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.indigoAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '球队',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '场次',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '胜/平/负',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '进/失',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '净',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '积分',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '排名',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem({
    required String name,
    required LeagueTeamScore score,
    bool bordered = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: bordered
              ? BorderSide(color: Colors.black12, width: 0.15.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              Tools.limitText(name, 4),
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.played}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.win}/${score.rankStats.draw}/${score.rankStats.lose}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.goalsFor}/${score.rankStats.goalsLoss}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.goalDif}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.point}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rank}',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleView(MatchTrendController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '历史交锋',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildBattlePanel(controller),
          _buildBattleHeader(),
          ..._sportMatchList(
            matches: controller.historyBattles,
            teamId: controller.homeStats.teamId,
            empty: '两队暂无交锋记录',
          ),
        ],
      ),
    );
  }

  List<Widget> _sportMatchList({
    required List<SportMatch> matches,
    required int teamId,
    String? empty,
  }) {
    List<Widget> views = [];
    for (int i = 0; i < matches.length; i++) {
      views.add(_buildBattleItem(
        match: matches[i],
        teamId: teamId,
        bordered: i < matches.length - 1,
      ));
    }
    if (views.isEmpty) {
      views.add(
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
          child: Text(
            empty ?? '暂无对战成绩',
            style: TextStyle(
              color: Colors.black26,
              fontSize: 12.sp,
            ),
          ),
        ),
      );
    }
    return views;
  }

  Widget _buildBattlePanel(MatchTrendController controller) {
    return Container(
      padding: EdgeInsets.only(top: 10.w),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(
                width: 0.5.w,
                color: Colors.deepOrange.withOpacity(0.1),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 2.w, bottom: 3.w),
                  child: Text(
                    '主队',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xfff24040),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.w),
                      bottomRight: Radius.circular(4.w),
                    ),
                  ),
                  child: Text(
                    '交锋${controller.historyBattles.length}次',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.w),
            child: Column(
              children: [
                Text(
                  '${controller.battleResult.goal - controller.battleResult.lose}'
                  '/${controller.battleResult.goal}/${controller.battleResult.lose}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xfff24040),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '净胜/进球/失球',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 24.w),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: '胜率',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black38,
                    ),
                    children: [
                      TextSpan(
                        text: controller.battleResult.winRate(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xfff24040),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${controller.battleResult.win}胜${controller.battleResult.draw}平${controller.battleResult.loss}负',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.15.w),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '赛程',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '主队',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '比分',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '客队',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '赛果',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleItem(
      {required SportMatch match, required int teamId, bool bordered = true}) {
    String result = match.matchResult(teamId);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: bordered
              ? BorderSide(color: Colors.black12, width: 0.15.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(
                    DateUtil.formatDate(
                      DateUtil.parse(
                        match.vsDate,
                        pattern: 'yyyy/MM/dd HH:mm:ss',
                      ),
                      format: 'yy/MM/dd',
                    ),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    Tools.limitText(match.league, 3),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                Tools.limitText(match.homeName, 5),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: teamNameColor(
                    match.homeId,
                    teamId,
                    result,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.6.w),
                            child: Text(
                              '全',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: '${match.home.score}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xfff24040),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ':',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '${match.away.score}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.6.w),
                            child: Text(
                              '半',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: '${match.home.score}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ':',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '${match.away.score}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Tools.limitText(match.awayName, 5),
                style: TextStyle(
                  color: teamNameColor(match.awayId, teamId, result),
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: result == '负'
                      ? const Color(0xFF32CD32)
                      : const Color(0xfff24040),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color teamNameColor(int targetId, int teamId, String result) {
    if (targetId != teamId) {
      return Colors.black87;
    }
    return result == '负' ? const Color(0xFF32CD32) : const Color(0xfff24040);
  }

  Widget _buildRecentMatch(MatchTrendController controller) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '近期战绩',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          _buildRecentPanel(controller.homeStats),
          _buildBattleHeader(),
          ..._sportMatchList(
            matches: controller.homeStats.recentMatches,
            teamId: controller.homeStats.teamId,
          ),
          _buildRecentPanel(controller.awayStats),
          _buildBattleHeader(),
          ..._sportMatchList(
            matches: controller.awayStats.recentMatches,
            teamId: controller.awayStats.teamId,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPanel(MatchTeamStats stats) {
    return Container(
      padding: EdgeInsets.only(top: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${stats.name}(${stats.recentMatches.length}场)',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    '${stats.battleResult.win}胜${stats.battleResult.draw}平${stats.battleResult.loss}负',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Text(
                    '进${stats.battleResult.goal}球/失${stats.battleResult.lose}球',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: RichText(
                    text: TextSpan(
                      text: '胜率',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 13.sp,
                      ),
                      children: [
                        TextSpan(
                          text: stats.battleResult.winRate(),
                          style: const TextStyle(
                            color: Color(0xfff24040),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (stats.bigSmall != null)
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: RichText(
                      text: TextSpan(
                        text: '大球比',
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 13.sp,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '${stats.bigSmall!.stats.bigRate.toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Color(0xfff24040),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

  @override
  bool get wantKeepAlive => true;
}
