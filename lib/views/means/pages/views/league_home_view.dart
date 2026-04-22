import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/constants.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/means/controller/league/league_home_controller.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';

class LeagueHomeView extends StatefulWidget {
  const LeagueHomeView({Key? key}) : super(key: key);

  @override
  LeagueHomeViewState createState() => LeagueHomeViewState();
}

class LeagueHomeViewState extends State<LeagueHomeView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeagueHomeController());
    return RequestWidget<LeagueHomeController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              _buildMatchCard(controller),
              _buildScoreCard(controller),
              _buildFeatureCard(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black12, width: 0.25.w),
      )),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMatchCard(LeagueHomeController controller) {
    return Column(
      children: [
        _buildHeader('热门赛事'),
        ..._buildHotMatches(controller),
        Container(color: const Color(0xFFF5F5F5), height: 12.w),
      ],
    );
  }

  List<Widget> _buildHotMatches(LeagueHomeController controller) {
    List<Widget> items = [];
    if (controller.matches.isNotEmpty) {
      items.addAll(controller.matches.map((e) => _buildMatchItem(e)));
    } else {
      items.add(
        Container(
          padding: EdgeInsets.only(top: 16.w, bottom: 20.w),
          child: EmptyView(
            message: '暂无热门赛事',
            size: 80.w,
          ),
        ),
      );
    }
    return items;
  }

  Widget _buildMatchItem(SportMatch match) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/match/${match.matchId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.2.w),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  DateUtil.formatDate(
                      DateUtil.parse(match.vsDate,
                          pattern: "yyyy/MM/dd HH:mm:ss"),
                      format: "MM-dd HH:mm"),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          Tools.limitText(match.homeName, 6),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: CachedAvatar(
                            width: 16.w,
                            height: 16.w,
                            url: match.homeLogo,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 46.w,
                    alignment: Alignment.center,
                    child: Text(
                      stateStr(match),
                      style: TextStyle(
                        color: match.state.value == 0
                            ? Colors.black38
                            : Colors.redAccent,
                        fontSize: 13.sp,
                        fontFamily: "bebas",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: CachedAvatar(
                            width: 16.w,
                            height: 16.w,
                            url: match.awayLogo,
                          ),
                        ),
                        Text(
                          Tools.limitText(match.awayName, 6),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(LeagueHomeController controller) {
    return Column(
      children: [
        _buildHeader('积分排名'),
        _buildScoreHeader(),
        ..._buildScoreViews(controller),
        Container(color: const Color(0xFFF5F5F5), height: 12.w),
      ],
    );
  }

  Widget _buildScoreHeader() {
    return Container(
      color: const Color(0xFFF6F6F6),
      padding: EdgeInsets.symmetric(vertical: 12.w),
      child: Row(
        children: [
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
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
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
        ],
      ),
    );
  }

  List<Widget> _buildScoreViews(LeagueHomeController controller) {
    List<Widget> items = [];
    if (controller.scores.isNotEmpty) {
      items.addAll(controller.scores.map((e) => _buildScoreItem(e)));
    } else {
      items.add(
        Container(
          padding: EdgeInsets.only(top: 16.w, bottom: 20.w),
          child: EmptyView(
            message: '暂无积分排名',
            size: 80.w,
          ),
        ),
      );
    }
    return items;
  }

  Widget _buildScoreItem(LeagueTeamScore score) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rank}',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: CachedAvatar(
                      width: 16.w,
                      height: 16.w,
                      url: score.logo,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      Tools.limitText(score.nameShort, 4),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.played}',
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
                '${score.rankStats.win}/${score.rankStats.draw}/${score.rankStats.lose}',
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
                '${score.rankStats.goalsFor}/${score.rankStats.goalsLoss}',
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
                '${score.rankStats.goalDif}',
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
                '${score.point}',
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

  Widget _buildFeatureCard(LeagueHomeController controller) {
    return Column(
      children: [
        _buildHeader('联赛特征'),
        _buildFeatureView(controller),
        _buildStatsView(),
      ],
    );
  }

  Widget _buildFeatureView(LeagueHomeController controller) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16.w, bottom: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: featureTypes.entries
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      controller.type = e.key;
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: controller.type == e.key
                              ? Colors.blueAccent
                              : Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWinLossView(controller),
            _buildBigSmallView(controller),
          ],
        ),
      ],
    );
  }

  Widget _buildWinLossView(LeagueHomeController controller) {
    return Visibility(
      visible: controller.type == 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pieChart(
                title: '胜场',
                value: controller.winLose?.win ?? 0,
                color: Colors.redAccent,
              ),
              _pieChart(
                title: '平局',
                value: controller.winLose?.draw ?? 0,
                color: Colors.blueAccent,
              ),
              _pieChart(
                title: '负场',
                value: controller.winLose?.lose ?? 0,
                color: Colors.green,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Text(
              '本赛季${controller.winLose?.played ?? 0}场比赛',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigSmallView(LeagueHomeController controller) {
    return Visibility(
      visible: controller.type == 2,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _pieChart(
                title: '大球',
                value: controller.bigSmall?.big ?? 0,
                color: Colors.redAccent,
              ),
              _pieChart(
                title: '走局',
                value: controller.bigSmall?.go ?? 0,
                color: Colors.blueAccent,
              ),
              _pieChart(
                title: '小球',
                value: controller.bigSmall?.small ?? 0,
                color: Colors.green,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.w),
            child: Text(
              '本赛季${controller.bigSmall?.played ?? 0}场比赛',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsView() {
    LeagueDetailController controller = Get.find<LeagueDetailController>();
    return Container(
      margin: EdgeInsets.only(bottom: 32.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16.w,
        crossAxisSpacing: 16.w,
        childAspectRatio: 3.20,
        padding: EdgeInsets.only(top: 16.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildStatsCard(
            title: '半全场统计',
            subTitle: '半全场胜平负特征统计',
            color: const Color(0xFFF57F17),
            onTap: () {
              LeagueSeason? season = controller.season;
              if (season == null) {
                EasyLoading.showToast('暂无赛季信息');
                return;
              }
              Get.toNamed('/halfAll/${season.id}');
            },
          ),
          _buildStatsCard(
            title: '进球数统计',
            subTitle: '全方位展示球队进球统计',
            color: Colors.green,
            onTap: () {
              LeagueSeason? season = controller.season;
              if (season == null) {
                EasyLoading.showToast('暂无赛季信息');
                return;
              }
              Get.toNamed('/pointGoal/${season.id}');
            },
          ),
          _buildStatsCard(
            title: '净胜球统计',
            subTitle: '球队净胜负统计，实力清晰',
            color: Colors.indigoAccent,
            onTap: () {
              LeagueSeason? season = controller.season;
              if (season == null) {
                EasyLoading.showToast('暂无赛季信息');
                return;
              }
              Get.toNamed('/winLoss/${season.id}');
            },
          ),
          _buildStatsCard(
            title: '大小球统计',
            subTitle: '球队进球大小数特征统计',
            color: Colors.deepPurpleAccent,
            onTap: () {
              LeagueSeason? season = controller.season;
              if (season == null) {
                EasyLoading.showToast('暂无赛季信息');
                return;
              }
              Get.toNamed('/bigAndSmall/${season.id}');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
      {required String title,
      required String subTitle,
      required Color color,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          gradient: LinearGradient(colors: [
            color,
            color.withOpacity(0.60),
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.w),
              child: Text(
                subTitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pieChart({
    required String title,
    required double value,
    required Color color,
  }) {
    Size size = Constants.measureText(
      text: '${value.toStringAsFixed(0)}%',
      style: TextStyle(
        color: Colors.black87,
        fontSize: 13.sp,
      ),
    );
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Stack(
            children: [
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(
                  value: value / 100,
                  strokeWidth: 3.w,
                  color: color,
                  backgroundColor: Colors.black12,
                ),
              ),
              Positioned(
                left: (40.w - size.width) / 2,
                top: (40.w - size.height) / 2,
                child: Text(
                  '${value.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }

  void refresh() {
    LeagueHomeController controller = Get.find<LeagueHomeController>();
    controller.request();
  }

  String stateStr(SportMatch match) {
    if (match.state.value == 0 ||
        match.state.value == 6 ||
        match.state.value == 5 ||
        match.state.value == 8) {
      return 'VS';
    }
    if (match.state.value == 11 ||
        match.state.value == 12 ||
        match.state.value == 14 ||
        match.state.value == 2) {
      return match.home.score.toString() + '-' + match.away.score.toString();
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
  }
}
