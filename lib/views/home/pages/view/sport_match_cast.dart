import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/match_census.dart';
import 'package:iwacai_lottery_app/views/base/model/match_event.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match/match_cast_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';

class SportMatchCastView extends StatefulWidget {
  const SportMatchCastView({
    super.key,
    required this.match,
  });

  final SportMatch match;

  @override
  SportMatchCastState createState() => SportMatchCastState();
}

class SportMatchCastState extends State<SportMatchCastView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: RefreshWidget<MatchCastController>(
        init: MatchCastController(widget.match.matchId),
        global: false,
        enableLoad: false,
        bottomBouncing: false,
        builder: (controller) {
          return Column(
            children: [
              _buildMatchCensus(controller),
              _buildMatchEvent(controller),
              Container(height: 24.w, color: Colors.white),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMatchCensus(MatchCastController controller) {
    return Column(
      children: [
        _buildShootView(controller.census!),
        _buildCardView(widget.match),
        _buildMatchCensusAll(controller)
      ],
    );
  }

  Widget _buildShootView(MatchCensus census) {
    return Container(
      padding: EdgeInsets.only(
        left: 8.w,
        right: 8.w,
        top: 16.w,
        bottom: 16.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.25.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _shootPieChart(
              title: '射门数',
              home: census.home.shoot.toDouble(),
              away: census.away.shoot.toDouble(),
            ),
          ),
          Expanded(
            child: _shootPieChart(
              title: '正射门',
              home: census.home.shootOn.toDouble(),
              away: census.away.shootOn.toDouble(),
            ),
          ),
          Expanded(
            child: _shootPieChart(
              title: '控球率',
              home: double.parse(census.home.controlStr.replaceAll('%', '')),
              away: double.parse(census.away.controlStr.replaceAll('%', '')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shootPieChart({
    required String title,
    required double home,
    required double away,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black87,
          ),
        ),
        _buildPieChart(
          home: home == 0 && away == 0 ? 0.5 : home,
          realHome: home,
          away: home == 0 && away == 0 ? 0.5 : away,
          realAway: away,
        ),
      ],
    );
  }

  Widget _buildPieChart(
      {required double home,
      required double realHome,
      required double away,
      required double realAway}) {
    return Container(
      padding: EdgeInsets.only(top: 6.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 22.w,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 4.w),
            child: Text(
              realAway.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 46.w,
            height: 46.w,
            child: CircularProgressIndicator(
              value: home / (home + away),
              strokeWidth: 4.w,
              color: const Color(0xff2866d5),
              backgroundColor: const Color(0xfff24040),
            ),
          ),
          Container(
            width: 22.w,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 4.w),
            child: Text(
              realHome.toStringAsFixed(0),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardView(SportMatch match) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 0.25.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildTeamCard(match.home, true),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Text(
                            '射门被挡',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.sp,
                            ),
                          ),
                          Container(
                            height: 2.w,
                            color: Colors.black.withOpacity(0.04),
                            margin: EdgeInsets.only(top: 6.w),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildTeamCard(match.away, false),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamCard(MatchResultVal value, bool left) {
    if (left) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.w),
                  child: Image.asset(
                    R.cornerLeft,
                    height: 18.w,
                  ),
                ),
                Text(
                  '${value.corner}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.w),
                  child: Image.asset(
                    R.rcard,
                    height: 18.w,
                  ),
                ),
                Text(
                  '${value.redCard}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4.w),
                  child: Image.asset(
                    R.ycard,
                    height: 18.w,
                  ),
                ),
                Text(
                  '${value.yellowCard}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.w),
                child: Image.asset(
                  R.ycard,
                  height: 18.w,
                ),
              ),
              Text(
                '${value.yellowCard}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.w),
                child: Image.asset(
                  R.rcard,
                  height: 18.w,
                ),
              ),
              Text(
                '${value.redCard}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 4.w),
                child: Image.asset(
                  R.cornerRight,
                  height: 18.w,
                ),
              ),
              Text(
                '${value.corner}',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12.sp,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMatchCensusAll(MatchCastController controller) {
    if (!controller.expanded) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 14.w),
        child: Column(
          children: [
            _buildCensusItem(title: '任意球', home: '0', away: '0'),
            _buildCensusItem(title: '犯规', home: '0', away: '0'),
            _buildCensusItem(title: '越位', home: '0', away: '0'),
            _buildCensusItem(title: '传球', home: '0', away: '0'),
            GestureDetector(
              onTap: () {
                controller.expanded = true;
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 0.25.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '全部统计',
                      style: TextStyle(
                        color: const Color(0xff2866d5),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20.sp,
                      color: const Color(0xff2866d5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 14.w),
      child: Column(
        children: [
          _buildCensusItem(title: '任意球', home: '0', away: '0'),
          _buildCensusItem(title: '犯规', home: '0', away: '0'),
          _buildCensusItem(title: '越位', home: '0', away: '0'),
          _buildCensusItem(title: '传球', home: '0', away: '0'),
          _buildCensusItem(title: '换人数', home: '0', away: '0'),
          _buildCensusItem(title: '头球', home: '0', away: '0'),
          _buildCensusItem(title: '头球成功', home: '0', away: '0'),
          _buildCensusItem(title: '救球', home: '0', away: '0'),
          _buildCensusItem(title: '铲球', home: '0', away: '0'),
          _buildCensusItem(title: '界外球', home: '0', away: '0'),
          _buildCensusItem(title: '过人', home: '0', away: '0'),
          GestureDetector(
            onTap: () {
              controller.expanded = false;
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 0.25.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '收起',
                    style: TextStyle(
                      color: const Color(0xff2866d5),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_up_rounded,
                    size: 20.sp,
                    color: const Color(0xff2866d5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCensusItem({
    required String title,
    required String home,
    required String away,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                home,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 18,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                    ),
                  ),
                  Container(
                    height: 2.w,
                    color: Colors.black.withOpacity(0.04),
                    margin: EdgeInsets.only(top: 6.w),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              away,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMatchEvent(MatchCastController controller) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16.w, top: 12.w, bottom: 12.w),
          alignment: Alignment.centerLeft,
          child: Text(
            '比赛事件',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _buildEventList(controller.events),
        _buildEventHint(),
      ],
    );
  }

  Widget _buildEventList(List<MatchEvent> events) {
    if (events.isEmpty) {
      if (widget.match.isUnStart()) {
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.w),
          child: Column(
            children: [
              Text(
                '比赛尚未开始，请耐心等待',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.w),
                child: Text(
                  '${DateUtil.formatDate(
                    DateUtil.parse(
                      widget.match.vsDate,
                      pattern: 'yyyy/MM/dd HH:mm:ss',
                    ),
                    format: 'yyyy-MM-dd HH:mm',
                  )}开赛',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: EmptyView(
          size: 92.w,
          message: '暂无比赛事件',
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 25.w,
            left: (Get.width - 1.w) / 2,
            child: Container(
              width: 0.75.w,
              height: events.length * 50.w,
              color: Colors.black.withOpacity(0.06),
            ),
          ),
          Column(
            children: [
              ...events.map((e) => _buildEventItem(e)).toList(),
              _buildStartEvent(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStartEvent() {
    return SizedBox(
      height: 50.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.only(left: 14.w),
              child: Text(
                "0'",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Container(
            width: 26.w,
            height: 26.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(color: Colors.black26, width: 0.5.w),
            ),
            child: Image.asset(
              R.koushao,
              height: 14.w,
              width: 14.w,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(MatchEvent event) {
    return SizedBox(
      height: 50.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.only(left: 14.w),
              child: Text(
                event.home == 1 ? event.player : event.elapse + "'",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Container(
            width: 26.w,
            height: 26.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(color: Colors.black26, width: 0.5.w),
            ),
            child: Image.asset(
              typeResources[event.type.description]!,
              height: 18.w,
              width: 18.w,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.only(left: 8.w),
              padding: EdgeInsets.only(right: 14.w),
              child: Text(
                event.home == 0 ? event.player : event.elapse + "'",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventHint() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, top: 12.w, bottom: 12.w),
        child: Wrap(
          spacing: 12.w,
          runSpacing: 12.w,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: typeResources.entries
              .map(
                (e) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(e.value, height: 18.w),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        e.key,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13.sp,
                        ),
                      ),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
