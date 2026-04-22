import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_schedule_controller.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/widgets/calendar_widget.dart';

class HomeScheduleView extends StatefulWidget {
  const HomeScheduleView({super.key});

  @override
  HomeScheduleViewState createState() => HomeScheduleViewState();
}

class HomeScheduleViewState extends State<HomeScheduleView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF6F6FB),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 52.w),
            child: RefreshWidget<MatchScheduleController>(
              emptyText: '今日暂无赛事',
              scrollController: scrollController,
              topConfig: const ScrollTopConfig(align: TopAlign.right),
              builder: (controller) => ListView.builder(
                padding: EdgeInsets.only(top: 8.w),
                itemCount: controller.matches.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
                    child: SportMatchView(
                      match: controller.matches[index],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF6F6FB),
                  offset: const Offset(0, 2),
                  blurRadius: 2.w,
                  spreadRadius: 2.w,
                ),
              ],
            ),
            child: GetBuilder<MatchScheduleController>(
              builder: (controller) {
                return Container(
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.w),
                      bottomRight: Radius.circular(12.w),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/filter/1');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 46.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(bottom: 8.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                R.filterIcon,
                                width: 20.w,
                                height: 20.w,
                              ),
                              Text(
                                '筛选',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DayWeekCalendar(
                        range: 10,
                        width: Get.width - 46.w,
                        time: controller.current,
                        color: const Color(0xAA000000),
                        activeColor: const Color(0xFFFF0033),
                        callback: (datetime, index) {
                          controller.date = datetime;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    Get.put(MatchScheduleController());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
