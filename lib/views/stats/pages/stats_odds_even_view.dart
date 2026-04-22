import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_stats.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/stats/controller/stats_odds_even_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class StatsOddsEvenView extends StatelessWidget {
  const StatsOddsEvenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '单双数统计',
      content: Stack(
        children: [
          Column(
            children: [
              Container(
                color: const Color(0xFFF6F6F6),
                padding: EdgeInsets.symmetric(vertical: 12.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '排名',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '球队',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '场次',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '全单',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '半单',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '全偶',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '半偶',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RequestWidget<StatsOddsEvenController>(
                    builder: (controller) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 0.w, bottom: 50.w),
                    itemCount: controller.stats.length,
                    itemBuilder: (context, index) {
                      return _buildStatsItem(controller.stats[index],
                          index < controller.stats.length - 1);
                    },
                  );
                }),
              ),
            ],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: Get.width,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 32.w),
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
              child: GetBuilder<StatsOddsEvenController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: statsTypes.entries
                        .map(
                          (e) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.type = e.key;
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.w),
                                    child: Text(
                                      e.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: controller.type == e.key
                                            ? Colors.blueAccent
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                  controller.type == e.key
                                      ? CommonWidgets.dotted(
                                          size: 4.5.w,
                                          color: Colors.blueAccent,
                                        )
                                      : SizedBox(height: 4.5.w, width: 4.5.w)
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatsItem(StatsInfo<OddEvenStats> stat, bool bordered) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: bordered
              ? BorderSide(color: Colors.black12, width: 0.25.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.rank}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: CachedAvatar(
                      width: 13.w,
                      height: 13.w,
                      url: stat.teamLogo,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      Tools.limitText(stat.team, 6),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.played}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.stats.odd}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.stats.halfOdd}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.stats.even}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${stat.stats.halfEven}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
