import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/league/league_team_controller.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class LeagueTeamView extends StatefulWidget {
  const LeagueTeamView({Key? key}) : super(key: key);

  @override
  LeagueTeamViewState createState() => LeagueTeamViewState();
}

class LeagueTeamViewState extends State<LeagueTeamView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeagueTeamController());
    return RequestWidget<LeagueTeamController>(
      emptyText: '暂无联赛球队',
      builder: (controller) {
        return GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 16.w,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.8,
          padding: EdgeInsets.all(16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.teams
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    LeagueDetailController league =
                        Get.find<LeagueDetailController>();
                    Get.toNamed('/team/${league.league.id}/${e.id}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.only(top: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(
                        width: 1.w,
                        color: const Color(0xFFF6F7F9),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 6.w),
                            child: CachedAvatar(
                              width: 38.w,
                              height: 38.w,
                              url: e.logo,
                              fit: BoxFit.fitWidth,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 5.w),
                          color: const Color(0xFFF6F7F9),
                          child: Text(
                            Tools.limitText(e.nameCn, 4),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  void refresh() {
    LeagueTeamController teamController = Get.find<LeagueTeamController>();
    teamController.onRefresh();
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
