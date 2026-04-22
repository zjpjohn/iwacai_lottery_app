import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_schedule_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';

class TeamScheduleView extends StatefulWidget {
  const TeamScheduleView({Key? key}) : super(key: key);

  @override
  TeamScheduleViewState createState() => TeamScheduleViewState();
}

class TeamScheduleViewState extends State<TeamScheduleView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TeamScheduleController>(() => TeamScheduleController());
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 50.w),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: RefreshWidget<TeamScheduleController>(
                    emptyText: '暂无球队赛程',
                    builder: (controller) {
                      return ListView.builder(
                        itemCount: controller.matches.length,
                        itemBuilder: (context, index) => _buildMatchItem(
                          controller.matches[index],
                          index < controller.matches.length - 1,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: Get.width,
          child: GetBuilder<TeamScheduleController>(builder: (controller) {
            return _buildMatchType(controller);
          }),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFFF8F8F8),
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '日期',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '比赛对阵',
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

  Widget _buildMatchItem(SportMatch match, bool bordered) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/match/${match.matchId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: bordered
                ? BorderSide(color: Colors.black12, width: 0.2.w)
                : BorderSide.none,
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
                    DateUtil.parse(
                      match.vsDate,
                      pattern: "yyyy/MM/dd HH:mm:ss",
                    ),
                    format: "yy/MM/dd HH:mm",
                  ),
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

  Widget _buildStateItem(
      String title, int value, TeamScheduleController controller) {
    return GestureDetector(
      onTap: () {
        controller.matchState = value;
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(4.w),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            color: controller.matchState == value
                ? Colors.redAccent
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchType(TeamScheduleController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, -4.w),
            blurRadius: 4.w,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStateItem('未开赛', 0, controller),
                _buildStateItem('已完场', 2, controller),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _buildMatchTypeItem('全部', 0, controller),
                _buildMatchTypeItem('主场', 1, controller),
                _buildMatchTypeItem('客场', 2, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchTypeItem(
      String title, int value, TeamScheduleController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.type = value;
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: controller.type == value
                      ? Colors.blueAccent
                      : Colors.black87,
                ),
              ),
            ),
            controller.type == value
                ? CommonWidgets.dotted(
                    size: 4.5.w,
                    color: Colors.blueAccent,
                  )
                : SizedBox(height: 4.5.w, width: 4.5.w)
          ],
        ),
      ),
    );
  }

  void refresh() {
    TeamScheduleController controller = Get.find<TeamScheduleController>();
    controller.onInitial();
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

  @override
  void dispose() {
    super.dispose();
  }
}
