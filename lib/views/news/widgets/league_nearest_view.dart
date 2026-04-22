import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season_vo.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class LeagueNearestView extends StatelessWidget {
  ///
  ///
  const LeagueNearestView({
    Key? key,
    required this.league,
  }) : super(key: key);

  final LeagueNearestInfo league;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.w),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: CachedAvatar(
                        width: 42.w,
                        height: 42.w,
                        url: league.logo,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              league.name,
                              style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.black87,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Text(
                                '${league.season}赛季',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.w),
                          child: Text(
                            '第${league.current}轮/共${league.rounds}轮',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 12.w),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/league/${league.leagueId}?index=1');
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: Image.asset(
                                      R.leagueSchedule,
                                      height: 22.w,
                                    ),
                                  ),
                                  Text(
                                    '联赛赛程',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.brown,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: -4,
                              bottom: -4,
                              child: Image.asset(
                                R.football1,
                                height: 30.w,
                                opacity: const AlwaysStoppedAnimation(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/league/${league.leagueId}?index=2');
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: Image.asset(
                                      R.standPoint,
                                      height: 22.w,
                                    ),
                                  ),
                                  Text(
                                    '积分榜单',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.brown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: -4,
                              bottom: -4,
                              child: Image.asset(
                                R.football1,
                                height: 30.w,
                                opacity: const AlwaysStoppedAnimation(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 12.w,
            top: 12.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.w),
                border: Border.all(
                  width: 0.5.w,
                  color: Colors.deepOrange.withOpacity(0.1),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.w),
                    child: Text(
                      '比赛日',
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4.w),
                        bottomRight: Radius.circular(4.w),
                      ),
                    ),
                    child: Text(
                      DateUtil.formatDate(
                        DateUtil.parse(
                          league.nearDate,
                          pattern: "yyyy/MM/dd",
                        ),
                        format: "MM.dd",
                      ),
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15.sp,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
