import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/subscribe/views/focus_league_view.dart';
import 'package:iwacai_lottery_app/views/subscribe/views/focus_match_view.dart';
import 'package:iwacai_lottery_app/views/subscribe/views/focus_team_view.dart';
import 'package:iwacai_lottery_app/views/subscribe/widgets/focus_tabbar_widget.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class FocusCenterView extends StatefulWidget {
  ///
  ///
  const FocusCenterView({Key? key}) : super(key: key);

  @override
  FocusCenterViewState createState() => FocusCenterViewState();
}

class FocusCenterViewState extends State<FocusCenterView>
    with TickerProviderStateMixin {
  ///
  ///
  late TabController tabController;

  ///
  List<String> tabs = ['赛事', '联赛', '球队'];

  ///
  List<Widget> views = [
    const FocusMatchView(),
    const FocusLeagueView(),
    const FocusTeamView()
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '我的关注',
      content: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.w),
              child: FocusTabBar(
                tabs: tabs,
                controller: tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: views,
                controller: tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
