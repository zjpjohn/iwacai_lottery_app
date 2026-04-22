import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_result_controller.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/widgets/calendar_widget.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class HomeResultView extends StatefulWidget {
  const HomeResultView({super.key});

  @override
  HomeResultViewState createState() => HomeResultViewState();
}

class HomeResultViewState extends State<HomeResultView> {
  ///
  ///
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '赛事结果',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 52.w),
              child: RefreshWidget<MatchResultController>(
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
              child: GetBuilder<MatchResultController>(
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
                        SizedBox(width: 8.w),
                        DayWeekCalendar(
                          range: 12,
                          width: Get.width - 44.w,
                          time: controller.current,
                          direction: CalendarDirection.past,
                          color: const Color(0x77000000),
                          activeColor: const Color(0xFFFF0033),
                          callback: (datetime, index) {
                            controller.date = datetime;
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/filter/0');
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 36.w,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.put(MatchResultController());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
