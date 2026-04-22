import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_team.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/subscribe/controller/focus_team_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class FocusTeamView extends StatefulWidget {
  ///
  const FocusTeamView({Key? key}) : super(key: key);

  @override
  FocusTeamViewState createState() => FocusTeamViewState();
}

class FocusTeamViewState extends State<FocusTeamView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<FocusTeamController>(
      init: FocusTeamController(),
      emptyText: '暂无收藏球队',
      builder: (controller) {
        return ListView.builder(
            itemCount: controller.datas.length,
            itemBuilder: (context, index) {
              return _buildTeamItem(
                controller.datas[index],
              );
            });
      },
    );
  }

  Widget _buildTeamItem(FocusTeam team) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/team/${team.leagueId}/${team.teamId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.15.w,
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: CachedAvatar(
                    width: 32.w,
                    height: 32.w,
                    url: team.logo,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        team.nameCn,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black87,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: team.subscribeTime,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(
                              text: '关注',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.5.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Text(
                      team.league,
                      style: TextStyle(
                        color: const Color(0xFFFF0045),
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '最近赛程',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: team.vsDate,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                        const TextSpan(
                          text: '对战',
                        ),
                        TextSpan(
                          text: team.awayName,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
