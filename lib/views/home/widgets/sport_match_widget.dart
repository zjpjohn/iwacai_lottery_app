import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/constants.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/odds_info.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

typedef MatchFocusHandle = Function(SportMatch match);

class SportMatchView extends StatelessWidget {
  const SportMatchView({
    Key? key,
    required this.match,
    this.focusHandle,
  }) : super(key: key);

  /// 比赛信息
  final SportMatch match;

  /// 关注操作
  final MatchFocusHandle? focusHandle;

  @override
  Widget build(BuildContext context) {
    Color color = Constants.hashColor(match.league);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.15.w,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/league/${match.leagueId}');
                          },
                          child: Container(
                            width: 40.w,
                            margin: EdgeInsets.only(left: 4.w),
                            child: Text(
                              Tools.limitText(match.league, 3),
                              style: TextStyle(
                                color: color,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            DateUtil.formatDate(
                              DateUtil.parse(
                                match.vsDate,
                                pattern: "yyyy/MM/dd HH:mm:ss",
                              ),
                              format: "MM/dd HH:mm",
                            ),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.w,
                    alignment: Alignment.center,
                    child: Text(
                      '半${match.home.halfScore}-${match.away.halfScore}',
                      style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: match.isDoing()
                              ? AnimatedTextKit(
                                  repeatForever: true,
                                  pause: const Duration(milliseconds: 0),
                                  animatedTexts: [
                                    FlickerAnimatedText(
                                      match.state.description,
                                      entryEnd: 0.1,
                                      speed: const Duration(milliseconds: 5000),
                                      textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF00DD00),
                                      ),
                                    )
                                  ],
                                )
                              : Text(
                                  match.state.description,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black38,
                                  ),
                                ),
                        ),
                        Text(
                          match.matchRound(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFD1D1D1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: match.isCompleted() ? 16.w : 22.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16.w),
                        child: focusHandle == null
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  focusHandle!(match);
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    const IconData(0xe7f7,
                                        fontFamily: 'iconfont'),
                                    size: 18.w,
                                    color: match.focused == 0
                                        ? Colors.black38
                                        : Colors.redAccent,
                                  ),
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/match/${match.matchId}');
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    if (match.awayRank != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 2.w, top: 1.5.w),
                                        child: Text(
                                          '${match.awayRank}',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: const Color(0xFFD1D1D1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    Text(
                                      Tools.limitText(match.awayName, 6),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xBB000000),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                if (match.awayWits != null)
                                  Container(
                                    padding: EdgeInsets.only(top: 2.w),
                                    child: RichText(
                                      text: TextSpan(
                                        text: '近期',
                                        style: TextStyle(
                                          color: Colors.black38,
                                          fontSize: 11.sp,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${match.awayWits!}',
                                            style: const TextStyle(
                                              color: Color(0xfff24040),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const TextSpan(text: '条动态'),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (match.awayWits == null &&
                                    match.homeWits != null)
                                  Container(
                                    padding: EdgeInsets.only(top: 2.w),
                                    child: Text(
                                      '客队暂无动态',
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ),
                                const SizedBox.shrink(),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 2.w, top: 2.w),
                              child: CachedAvatar(
                                width: 18.w,
                                height: 18.w,
                                radius: 18.w,
                                fit: BoxFit.contain,
                                url: match.awayLogo,
                                errorImage: R.football,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/match/${match.matchId}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 50.w,
                    alignment: Alignment.center,
                    child: Text(
                      stateStr(match),
                      style: TextStyle(
                        color: match.state.value == 0
                            ? Colors.black38
                            : const Color(0xFFFF0033),
                        fontSize: 15.sp,
                        fontFamily: "bebas",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/match/${match.matchId}');
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 2.w, top: 2.w),
                          child: CachedAvatar(
                            width: 18.w,
                            height: 18.w,
                            radius: 18.w,
                            fit: BoxFit.contain,
                            url: match.homeLogo,
                            errorImage: R.football,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  Tools.limitText(match.homeName, 6),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xBB000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (match.homeRank != null)
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 2.w,
                                      top: 1.5.w,
                                    ),
                                    child: Text(
                                      '${match.homeRank}',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: const Color(0xFFD1D1D1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (match.homeWits != null)
                              Container(
                                padding: EdgeInsets.only(top: 2.w),
                                child: RichText(
                                  text: TextSpan(
                                    text: '近期',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 11.sp,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${match.homeWits!}',
                                        style: const TextStyle(
                                          color: Color(0xfff24040),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const TextSpan(text: '条动态'),
                                    ],
                                  ),
                                ),
                              ),
                            if (match.homeWits == null &&
                                match.awayWits != null)
                              Container(
                                padding: EdgeInsets.only(top: 2.w),
                                child: Text(
                                  '主队暂无动态',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (match.isCompleted())
            Container(
              padding: EdgeInsets.only(bottom: 12.w),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    child: _buildResultBlock(match.home, true),
                  ),
                  Container(
                    width: 24.w,
                    height: 1.2.w,
                    color: const Color(0x13000000),
                  ),
                  Expanded(
                    child: _buildResultBlock(match.away, false),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEuroOdds(EuroOddsVal odds) {
    return Container(
      padding: EdgeInsets.only(top: 2.w),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black45,
            fontSize: 11.sp,
          ),
          children: [
            const TextSpan(text: '胜'),
            TextSpan(
              text: odds.win.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: '平局'),
            TextSpan(
              text: odds.draw.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(text: '负'),
            TextSpan(
              text: odds.lose.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBlock(MatchResultVal value, bool left) {
    if (left) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.w),
                  child: Icon(
                    const IconData(0xe62d, fontFamily: 'iconfont'),
                    size: 12.sp,
                    color: const Color(0xFFEEEEEE),
                  ),
                ),
                Text(
                  '${value.corner}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.w),
                  child: Icon(
                    const IconData(0xe62e, fontFamily: 'iconfont'),
                    size: 12.sp,
                    color: Colors.red.withOpacity(0.30),
                  ),
                ),
                Text(
                  '${value.redCard}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2.w),
                  child: Icon(
                    const IconData(0xe62e, fontFamily: 'iconfont'),
                    size: 12.sp,
                    color: Colors.yellow.withOpacity(0.30),
                  ),
                ),
                Text(
                  '${value.yellowCard}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.w),
                child: Icon(
                  const IconData(0xe62e, fontFamily: 'iconfont'),
                  size: 12.sp,
                  color: Colors.yellow.withOpacity(0.30),
                ),
              ),
              Text(
                '${value.yellowCard}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.w),
                child: Icon(
                  const IconData(0xe62e, fontFamily: 'iconfont'),
                  size: 12.sp,
                  color: Colors.red.withOpacity(0.30),
                ),
              ),
              Text(
                '${value.redCard}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 2.w),
                child: Icon(
                  const IconData(0xe677, fontFamily: 'iconfont'),
                  size: 12.sp,
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              Text(
                '${value.corner}',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ],
    );
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
