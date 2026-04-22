import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/model/league_info.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/country_league_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class CountryLeagueView extends StatefulWidget {
  ///
  const CountryLeagueView({Key? key}) : super(key: key);

  @override
  CountryLeagueViewState createState() => CountryLeagueViewState();
}

class CountryLeagueViewState extends State<CountryLeagueView> {
  ///
  late CountryInfo country;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: Tools.limitText(country.name, 7) + '赛事',
      content: RequestWidget<CountryLeagueController>(
        builder: (controller) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 5,
                mainAxisSpacing: 16.w,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.75,
                padding: EdgeInsets.all(16.w),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.leagues
                    .map(
                      (e) => _leagueItemView(e),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _leagueItemView(LeagueInfo league) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/league/${league.id}');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 32.w,
        padding: EdgeInsets.only(top: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            width: 0.8.w,
            color: const Color(0xFFF6F7F9),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 6.w),
                child: CachedAvatar(
                  width: 32.w,
                  height: 32.w,
                  url: league.logo,
                  fit: BoxFit.fitWidth,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 4.w, bottom: 4.w),
              color: const Color(0xFFF6F7F9),
              child: Text(
                Tools.limitText(league.name, 4),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 11.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    country = Get.arguments;
  }
}
