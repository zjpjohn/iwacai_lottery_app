import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/team_census.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_census_controller.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class TeamCensusView extends StatefulWidget {
  ///
  const TeamCensusView({Key? key}) : super(key: key);

  @override
  TeamCensusViewState createState() => TeamCensusViewState();
}

class TeamCensusViewState extends State<TeamCensusView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TeamMetricController>(() => TeamMetricController());
    return RequestWidget<TeamMetricController>(
      emptyText: '暂无球队技术统计',
      builder: (controller) {
        return Stack(
          children: [
            ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 60.w),
                  child: Column(
                    children: [
                      _buildAttackAndDefense(controller.stats!),
                      _buildPassAndControl(controller.stats!),
                      _buildShootView(controller.stats!),
                      _buildCornerAndFree(controller.stats!),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              width: Get.width,
              child: _buildCensusType(controller),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAttackAndDefense(TeamStatVal val) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '攻防',
              style: TextStyle(
                color: const Color(0xFF2866D5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.averageScore}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '个',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '场均进球',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.averageLost}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '个',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '场均失球',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPassAndControl(TeamStatVal val) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '传控',
              style: TextStyle(
                color: const Color(0xFF2866D5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.controlTime}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '%',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '控球率',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.passRate}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '%',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '传球率',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.dangerousAttack}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '个',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '威胁球',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShootView(TeamStatVal val) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '射门',
              style: TextStyle(
                color: const Color(0xFF2866D5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.shoot}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '次',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '射门',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.shootOn}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '次',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '射正',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.attackToScoreRate}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '次/球',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '进球转化',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.beShooted}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '次',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '被射门',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.beShootOn}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '次',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '被射正',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.lostScoreRate}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '次/球',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '失球转化',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCornerAndFree(TeamStatVal val) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 24.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 0.25.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.w),
            child: Text(
              '角球和任意球',
              style: TextStyle(
                color: const Color(0xFF2866D5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.cornerKick}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '个',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '角球',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.beCornerKick}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '个',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '被罚角球',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${val.freeKick}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.w),
                            child: Text(
                              '个',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        '任意球',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.beFreeKick}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '个',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '被罚任意球',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${val.frontFreeKick}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            '个',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      '前场任意球',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCensusType(TeamMetricController controller) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 48.w),
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
          _buildMatchTypeItem('全部', 0, controller),
          _buildMatchTypeItem('主场', 1, controller),
          _buildMatchTypeItem('客场', 2, controller),
        ],
      ),
    );
  }

  Widget _buildMatchTypeItem(
      String title, int value, TeamMetricController controller) {
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

  Widget _buildHeader(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black12, width: 0.25.w),
      )),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void refresh() {
    TeamMetricController controller = Get.find<TeamMetricController>();
    controller.onRefresh();
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
