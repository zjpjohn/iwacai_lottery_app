import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/model/team_witting.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/pages/view/match_team_witting.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_witting_controller.dart';

class TeamWittingView extends StatefulWidget {
  const TeamWittingView({Key? key}) : super(key: key);

  @override
  TeamWittingViewState createState() => TeamWittingViewState();
}

class TeamWittingViewState extends State<TeamWittingView> {
  @override
  Widget build(BuildContext context) {
    return RefreshWidget<TeamWittingController>(
      global: false,
      emptyText: '暂无球队动态',
      init: TeamWittingController(),
      builder: (controller) {
        return Column(
          children: [
            SizedBox(height: 12.w),
            ..._buildAllWittingLines(controller.wittings),
            SizedBox(height: 12.w)
          ],
        );
      },
    );
  }

  List<Widget> _buildAllWittingLines(List<TeamMatchWitting> wittings) {
    List<Widget> views = [];
    for (int i = 0; i < wittings.length; i++) {
      TeamMatchWitting witting = wittings[i];
      views.addAll(
        _buildLineItem(
          witting: witting,
          top: 4.w,
          marginTop: i == 0 ? 4.w : 0.0,
          tail: i == wittings.length - 1,
        ),
      );
    }
    return views;
  }

  List<Widget> _buildLineItem({
    required TeamMatchWitting witting,
    required double top,
    required double marginTop,
    bool tail = false,
  }) {
    return [
      TimeLineItem(
        size: 10.w,
        top: top,
        marginTop: marginTop,
        color: const Color(0xFF00DD00),
        content: Padding(
          padding: EdgeInsets.only(bottom: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                witting.matchDate,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (witting.homeName != null && witting.awayName != null)
                Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: Text(
                    '${witting.awayName} VS ${witting.homeName}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      ..._buildContentLines(witting.items, tail),
    ];
  }

  List<Widget> _buildContentLines(List<MatchWittingItem> items, bool tail) {
    List<Widget> views = [];
    for (int i = 0; i < items.length; i++) {
      views.add(TimeLineItem(
        size: 8.w,
        tail: tail && (i == items.length - 1),
        color: const Color(0xFFF1F1F1),
        content: _wittingContentItem(
          items[i],
          i == items.length - 1 ? 16.w : 12.w,
        ),
      ));
    }
    return views;
  }

  Widget _wittingContentItem(MatchWittingItem item, double bottom) {
    return Container(
      margin: EdgeInsets.only(bottom: bottom, right: 12.w),
      constraints: BoxConstraints(minHeight: 52.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        color: item.type == 1
            ? Colors.redAccent.withOpacity(0.04)
            : Colors.blueAccent.withOpacity(0.04),
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
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
            child: Text(
              item.content,
              style: TextStyle(
                fontSize: 13.sp,
                color: item.type == 1
                    ? const Color(0xfff24040)
                    : const Color(0xff2866d5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
