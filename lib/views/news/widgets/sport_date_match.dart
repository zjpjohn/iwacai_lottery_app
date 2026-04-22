import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class SportDateMatch extends StatelessWidget {
  final List<SportMatch> matches;

  const SportDateMatch({
    Key? key,
    required this.matches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: EdgeInsets.only(left: 12.w),
      margin: EdgeInsets.only(top: 12.w),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          _hotMatchViews(matches),
          Positioned(
            left: 0,
            top: 0,
            child: _hotMatchCounter(matches.length),
          ),
        ],
      ),
    );
  }

  Widget _hotMatchCounter(int count) {
    return Container(
      height: 86.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF6F6F6),
            offset: const Offset(2, 2),
            blurRadius: 2.w,
            spreadRadius: 2.w,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '近期',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontFamily: 'jinbu',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '比赛',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
              fontFamily: 'jinbu',
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: Row(
              children: [
                Text(
                  '$count',
                  style: TextStyle(
                    color: const Color(0xFFFF3369),
                    fontSize: 13.sp,
                    fontFamily: 'bebas',
                  ),
                ),
                Text(
                  '场',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotMatchViews(List<SportMatch> matches) {
    List<Widget> views = [];
    for (int i = 0; i < matches.length; i++) {
      views.add(_matchView(matches[i], 12.w));
    }
    views.add(SizedBox(width: 12.w));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.only(left: 52.w),
        child: Row(
          children: views,
        ),
      ),
    );
  }

  Widget _matchView(SportMatch match, double left) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/match/${match.matchId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 86.w,
        margin: EdgeInsets.only(left: left),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: Text(
                      match.league,
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Text(
                    DateUtil.formatDate(
                      DateUtil.parse(
                        match.vsDate,
                        pattern: "yyyy/MM/dd HH:mm:ss",
                      ),
                      format: "MM/dd HH:mm",
                    ),
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 6.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.w),
                    child: CachedAvatar(
                      width: 18.w,
                      height: 18.w,
                      url: match.awayLogo,
                      fit: BoxFit.contain,
                      errorImage: R.football,
                    ),
                  ),
                  if (match.isDoingOrCompleted())
                    Row(children: [
                      Text(
                        '${match.away.score}',
                        style: TextStyle(
                          color: const Color(0xFFFF0045),
                          fontSize: 13.sp,
                          fontFamily: 'bebas',
                        ),
                      ),
                      const Text(
                        "-",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ]),
                  Text(
                    Tools.limitText(match.awayName, 6),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: CachedAvatar(
                    width: 18.w,
                    height: 18.w,
                    url: match.homeLogo,
                    fit: BoxFit.contain,
                    errorImage: R.football,
                  ),
                ),
                if (match.isDoingOrCompleted())
                  Row(children: [
                    Text(
                      '${match.home.score}',
                      style: TextStyle(
                        color: const Color(0xFFFF0045),
                        fontSize: 13.sp,
                        fontFamily: 'bebas',
                      ),
                    ),
                    const Text(
                      "-",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ]),
                Text(
                  Tools.limitText(match.homeName, 6),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
