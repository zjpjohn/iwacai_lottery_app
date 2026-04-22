import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/widgets/authed_refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/match_focus_controller.dart';
import 'package:iwacai_lottery_app/views/home/widgets/match_league_widget.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class HomeFocusView extends StatefulWidget {
  const HomeFocusView({super.key});

  @override
  HomeFocusViewState createState() => HomeFocusViewState();
}

class HomeFocusViewState extends State<HomeFocusView> {
  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '赛事关注',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: AuthedRefreshWidget<MatchFocusController>(
          init: MatchFocusController(),
          tag: 'match_focus_tag',
          emptyText: '暂无关注赛事',
          widgetBuilder: (controller) {
            return MatchLeagueView(
              leagues: controller.leagues,
              onChange: (league) {
                controller.leagueId = league.leagueId;
              },
            );
          },
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.only(top: 8.w),
            itemCount: controller.matches.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
                child: SportMatchView(
                  match: controller.matches[index],
                  focusHandle: (match) {
                    controller.cancelFocus(match);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
