import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_detail_controller.dart';

class LeagueStatsView extends StatefulWidget {
  const LeagueStatsView({Key? key}) : super(key: key);

  @override
  LeagueStatsViewState createState() => LeagueStatsViewState();
}

class LeagueStatsViewState extends State<LeagueStatsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    LeagueDetailController controller = Get.find<LeagueDetailController>();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: _buildStatsCard(
                title: '半全场统计',
                subTitle: '半全场胜平负统计，走势清晰',
                bgColor: const Color(0xFFF57F17),
                icon: 0xe626,
                onTap: () {
                  LeagueSeason? season = controller.season;
                  if (season == null) {
                    EasyLoading.showToast('暂无赛季信息');
                    return;
                  }
                  Get.toNamed('/halfAll/${season.id}');
                },
              ),
            ),
            _buildStatsCard(
              title: '进球数统计',
              subTitle: '多维度球队进球统计，走势清晰',
              bgColor: Colors.green,
              icon: 0xe609,
              onTap: () {
                LeagueSeason? season = controller.season;
                if (season == null) {
                  EasyLoading.showToast('暂无赛季信息');
                  return;
                }
                Get.toNamed('/pointGoal/${season.id}');
              },
            ),
            _buildStatsCard(
              title: '净胜球统计',
              subTitle: '球队净胜净负球统计，走势清晰',
              bgColor: Colors.teal,
              icon: 0xe604,
              onTap: () {
                LeagueSeason? season = controller.season;
                if (season == null) {
                  EasyLoading.showToast('暂无赛季信息');
                  return;
                }
                Get.toNamed('/winLoss/${season.id}');
              },
            ),
            _buildStatsCard(
              title: '单双数统计',
              subTitle: '球队进球单双数统计，走势清晰',
              bgColor: Colors.indigoAccent,
              icon: 0xe612,
              onTap: () {
                LeagueSeason? season = controller.season;
                if (season == null) {
                  EasyLoading.showToast('暂无赛季信息');
                  return;
                }
                Get.toNamed('/oddsEven/${season.id}');
              },
            ),
            _buildStatsCard(
              title: '大小球统计',
              subTitle: '球队进球大小数统计，一目了然',
              bgColor: Colors.deepPurpleAccent,
              icon: 0xe610,
              onTap: () {
                LeagueSeason? season = controller.season;
                if (season == null) {
                  EasyLoading.showToast('暂无赛季信息');
                  return;
                }
                Get.toNamed('/bigAndSmall/${season.id}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard({
    required String title,
    required String subTitle,
    required Color bgColor,
    required int icon,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.w),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.w),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, .4, .65, .9, 1],
                colors: [
                  bgColor,
                  bgColor.withOpacity(0.85),
                  bgColor.withOpacity(0.75),
                  bgColor.withOpacity(0.65),
                  bgColor.withOpacity(0.55),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.w),
                  child: Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12.w,
            top: 12.w,
            child: Icon(
              IconData(icon, fontFamily: 'iconfont'),
              size: 60.sp,
              color: Colors.white30,
            ),
          )
        ],
      ),
    );
  }

  void refresh() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
