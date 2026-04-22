import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/subscribe/controller/focus_league_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class FocusLeagueView extends StatefulWidget {
  const FocusLeagueView({Key? key}) : super(key: key);

  @override
  FocusLeagueViewState createState() => FocusLeagueViewState();
}

class FocusLeagueViewState extends State<FocusLeagueView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<FocusLeagueController>(
      init: FocusLeagueController(),
      emptyText: '暂无收藏联赛',
      builder: (controller) {
        return ListView.builder(
            itemCount: controller.datas.length,
            itemBuilder: (context, index) {
              return _buildLeagueItem(
                controller.datas[index],
              );
            });
      },
    );
  }

  Widget _buildLeagueItem(FocusLeague league) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/league/${league.leagueId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.w),
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
                    url: league.logo,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        league.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black87,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: league.subscribeTime,
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.w),
                    child: RichText(
                      text: TextSpan(
                        text: '最近赛程',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 11.sp,
                        ),
                        children: [
                          TextSpan(
                            text: league.vsDate,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              Tools.limitText(league.awayName, 7),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2.w),
                              child: CachedAvatar(
                                width: 18.w,
                                height: 18.w,
                                radius: 18.w,
                                fit: BoxFit.contain,
                                url: league.awayLogo,
                                errorImage: R.football,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 50.w,
                        alignment: Alignment.center,
                        child: Text(
                          stateStr(league),
                          style: TextStyle(
                            color: league.state.value == 0
                                ? Colors.black38
                                : Colors.redAccent,
                            fontSize: 15.sp,
                            fontFamily: "bebas",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 2.w),
                              child: CachedAvatar(
                                width: 18.w,
                                height: 18.w,
                                radius: 18.w,
                                fit: BoxFit.contain,
                                url: league.homeLogo,
                                errorImage: R.football,
                              ),
                            ),
                            Text(
                              Tools.limitText(league.homeName, 7),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String stateStr(FocusLeague league) {
    if (league.state.value == 0 ||
        league.state.value == 6 ||
        league.state.value == 5 ||
        league.state.value == 8) {
      return 'VS';
    }
    if (league.state.value == 11 ||
        league.state.value == 12 ||
        league.state.value == 14 ||
        league.state.value == 2) {
      return '${league.home.score}-${league.away.score}';
    }
    return '';
  }

  @override
  bool get wantKeepAlive => true;
}
