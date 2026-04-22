import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/team_witting.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match/match_witting_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';

class MatchTeamWittingView extends StatefulWidget {
  const MatchTeamWittingView({
    super.key,
    required this.match,
  });

  final SportMatch match;

  @override
  MatchTeamWittingState createState() => MatchTeamWittingState();
}

class MatchTeamWittingState extends State<MatchTeamWittingView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: RefreshWidget<MatchWittingController>(
        enableLoad: false,
        bottomBouncing: false,
        emptyText: '暂无球队动态',
        global: false,
        init: MatchWittingController(widget.match.matchId),
        builder: (controller) {
          return Column(
            children: [
              _buildHomeWitting(controller),
              Container(height: 8.w, color: const Color(0xFFF6F6FB)),
              _buildAwayWitting(controller),
              SizedBox(height: 24.w),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHomeWitting(MatchWittingController controller) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              top: 12.w,
            ),
            child: Text(
              widget.match.homeName,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildTimeLineContent(
            widget.match.leagueId,
            widget.match.homeId,
            const Color(0xfff24040),
            controller.groupWitting(controller.homeWitting),
            '主队暂无动态',
            '主队更多动态',
          )
        ],
      ),
    );
  }

  Widget _buildAwayWitting(MatchWittingController controller) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              top: 12.w,
            ),
            child: Text(
              widget.match.awayName,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildTimeLineContent(
              widget.match.leagueId,
              widget.match.awayId,
              const Color(0xFF0066FF),
              controller.groupWitting(controller.awayWitting),
              '客队暂无动态',
              '客队更多动态')
        ],
      ),
    );
  }

  Widget _buildTimeLineContent(
    int leagueId,
    int teamId,
    Color start,
    Map<String, List<TeamWitting>> map,
    String emptyText,
    String moreText,
  ) {
    if (map.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 20.w),
        child: EmptyView(
          size: 100.w,
          message: emptyText,
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.w, left: 4.w, right: 12.w),
      child: Column(
        children: [
          ..._buildAllWittingLines(map, start),
          GestureDetector(
            onTap: () {
              Get.toNamed('/team/$leagueId/$teamId');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    moreText,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 13.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.w),
                    child: Icon(
                      const IconData(0xe8b3, fontFamily: 'iconfont'),
                      size: 12.sp,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAllWittingLines(
      Map<String, List<TeamWitting>> map, Color start) {
    List<Widget> views = [];
    List<MapEntry<String, List<TeamWitting>>> entries = map.entries.toList();
    for (int i = 0; i < entries.length; i++) {
      MapEntry<String, List<TeamWitting>> entry = entries[i];
      views.addAll(
        _buildLineItem(
          key: entry.key,
          items: entry.value,
          start: start,
          top: 4.w,
          marginTop: i == 0 ? 4.w : 0.0,
        ),
      );
    }
    return views;
  }

  List<Widget> _buildLineItem({
    required String key,
    required List<TeamWitting> items,
    required Color start,
    required double top,
    required double marginTop,
  }) {
    return [
      TimeLineItem(
        size: 10.w,
        top: top,
        marginTop: marginTop,
        color: start,
        content: Padding(
          padding: EdgeInsets.only(bottom: 16.w),
          child: Text(
            key,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
      ..._buildContentLines(items),
    ];
  }

  List<Widget> _buildContentLines(List<TeamWitting> items) {
    List<Widget> views = [];
    for (int i = 0; i < items.length; i++) {
      views.add(TimeLineItem(
        size: 8.w,
        tail: i == items.length - 1,
        color: const Color(0xFFF1F1F1),
        content:
            _wittingContentItem(items[i], i < items.length - 1 ? 10.w : 16.w),
      ));
    }
    return views;
  }

  Widget _wittingContentItem(TeamWitting item, double bottom) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom),
      constraints: BoxConstraints(minHeight: 52.w),
      decoration: BoxDecoration(
        color: item.type == 1
            ? Colors.redAccent.withOpacity(0.04)
            : Colors.blueAccent.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 6.w,
            right: 8.w,
            child: Icon(
              IconData(
                item.type == 1 ? 0xe657 : 0xe61b,
                fontFamily: 'iconfont',
              ),
              size: 17.sp,
              color: item.type == 1
                  ? const Color(0xfff24040).withOpacity(0.20)
                  : const Color(0xff2866d5).withOpacity(0.20),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
            child: Text(
              item.content,
              style: TextStyle(
                color: item.type == 1
                    ? const Color(0xfff24040)
                    : const Color(0xff2866d5),
                fontSize: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TimeLineItem extends StatelessWidget {
  const TimeLineItem({
    super.key,
    required this.color,
    required this.content,
    this.size = 12.0,
    this.width = 1.0,
    this.top = 0.0,
    this.marginTop = 0.0,
    this.tail = false,
  });

  final Color color;
  final double size;
  final double width;
  final double top;
  final double marginTop;
  final Widget content;
  final bool tail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(
              width: 24.w,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    width: width,
                    color: tail ? Colors.white : const Color(0xFFF1F1F1),
                    margin: EdgeInsets.only(
                      top: marginTop,
                      left: 12.w - 0.5 * width,
                      right: 12.w - 0.5 * width,
                    ),
                  ),
                  Positioned(
                    top: top,
                    left: 12.w - size * 0.5,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(size),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
