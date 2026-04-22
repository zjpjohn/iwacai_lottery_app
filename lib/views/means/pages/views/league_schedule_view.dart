import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/means/controller/league/league_schedule_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/modal_sheet_view.dart';

class LeagueScheduleView extends StatefulWidget {
  const LeagueScheduleView({Key? key}) : super(key: key);

  @override
  LeagueScheduleViewState createState() => LeagueScheduleViewState();
}

class LeagueScheduleViewState extends State<LeagueScheduleView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeagueScheduleController());
    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RequestWidget<LeagueScheduleController>(
                emptyText: '暂无联赛赛程',
                builder: (controller) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 0, bottom: 96.w),
                    itemCount: controller.matches.length,
                    itemBuilder: (context, index) {
                      return _buildMatchItem(
                        controller.matches[index],
                        index < controller.matches.length - 1,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          bottom: 0,
          width: Get.width,
          child: GetBuilder<LeagueScheduleController>(
            builder: (controller) {
              return controller.seasonVo != null
                  ? _buildRoundView(controller)
                  : Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFFF6F6F6),
      padding: EdgeInsets.symmetric(vertical: 12.w),
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
                      DateUtil.parse(match.vsDate,
                          pattern: "yyyy/MM/dd HH:mm:ss"),
                      format: "yy/MM/dd HH:mm"),
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

  Widget _buildRoundView(LeagueScheduleController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 24.w),
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
      child: Column(
        children: [
          if (controller.seasonVo!.cup == 0 &&
              controller.seasonVo!.subRound != null &&
              controller.seasonVo!.subRound!.stages.length > 1)
            _buildStageView(controller),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.last();
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                  child: Text(
                    '上一轮',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showStageModal(controller);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.seasonVo?.cup == 0
                            ? '第' + controller.round + '轮'
                            : controller.round,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.5.sp,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_sharp,
                        size: 20.sp,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.next();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
                  child: Text(
                    '下一轮',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showStageModal(LeagueScheduleController controller) {
    MediaQueryData mediaData = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6.0.w),
          topRight: Radius.circular(6.0.w),
        ),
      ),
      builder: (context) {
        return ModalSheetView(
          title: '轮次选择',
          height: mediaData.size.height - mediaData.padding.top - 46,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16.w,
                crossAxisSpacing: 12.w,
                childAspectRatio: 3.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: _buildRoundItems(controller),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildRoundItems(LeagueScheduleController controller) {
    if (controller.seasonVo!.cup == 0) {
      return controller.seriesStage!.rounds!
          .map(
            (e) => GestureDetector(
              onTap: () {
                controller.seriesRound(e);
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Text(
                  e.length <= 3 ? '第$e轮' : e,
                  style: TextStyle(
                    color: controller.round == e
                        ? Colors.redAccent
                        : Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          )
          .toList();
    }
    return controller.seasonVo!.cupRound!.stages
        .map(
          (e) => GestureDetector(
            onTap: () {
              controller.cupRound(e.stageId, e.name);
              Get.back();
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(4.w),
              ),
              child: Text(
                e.name,
                style: TextStyle(
                  color: controller.stageId == e.stageId &&
                          controller.round == e.name
                      ? Colors.redAccent
                      : Colors.black87,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildStageView(LeagueScheduleController controller) {
    return Container(
      margin: EdgeInsets.only(top: 4.w, bottom: 6.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.seasonVo!.subRound!.stages
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    controller.seriesStageTap(e);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 12.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 3.w, horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(color: Colors.black12, width: 0.25.w),
                    ),
                    child: Text(
                      e.nameCn,
                      style: TextStyle(
                        color: e.stageId == controller.stageId
                            ? Colors.redAccent
                            : Colors.black54,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void refresh() {
    LeagueScheduleController controller = Get.find<LeagueScheduleController>();
    controller.request();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
}
