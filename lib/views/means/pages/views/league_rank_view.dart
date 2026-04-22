import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/league_team_score.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/league/league_rank_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';

const Map<int, String> types = {
  1: '全部',
  2: '主场',
  3: '客场',
  4: '近6场',
};

class LeagueRankView extends StatefulWidget {
  ///
  const LeagueRankView({Key? key}) : super(key: key);

  @override
  LeagueRankViewState createState() => LeagueRankViewState();
}

class LeagueRankViewState extends State<LeagueRankView> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LeagueRankController());
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: const Color(0xFFF6F6F6),
              padding: EdgeInsets.symmetric(vertical: 12.w),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '排名',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '球队',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '场次',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '胜/平/负',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '进/失',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '净',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '积分',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RequestWidget<LeagueRankController>(
                emptyText: '暂无联赛积分排名',
                builder: (controller) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 0.w, bottom: 50.w),
                    itemCount: controller.scores.length,
                    itemBuilder: (context, index) {
                      return _buildScoreItem(
                        controller.scores[index],
                        index < controller.scores.length - 1,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
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
            child: GetBuilder<LeagueRankController>(
              builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: types.entries
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
        ),
      ],
    );
  }

  Widget _buildScoreItem(LeagueTeamScore score, bool bordered) {
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
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rank}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: CachedAvatar(
                      width: 16.w,
                      height: 16.w,
                      url: score.logo,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      Tools.limitText(score.nameShort, 4),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.played}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.win}/${score.rankStats.draw}/${score.rankStats.lose}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.goalsFor}/${score.rankStats.goalsLoss}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.rankStats.goalDif}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${score.point}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    LeagueRankController rankController = Get.find<LeagueRankController>();
    rankController.onRefresh();
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
