import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/news/controller/news_five_controller.dart';
import 'package:iwacai_lottery_app/views/news/widgets/league_nearest_view.dart';
import 'package:iwacai_lottery_app/views/news/widgets/sport_date_match.dart';
import 'package:iwacai_lottery_app/views/news/widgets/sport_news_widget.dart';

class NewsFiveView extends StatefulWidget {
  ///
  ///
  const NewsFiveView({Key? key}) : super(key: key);

  @override
  NewsFiveViewState createState() => NewsFiveViewState();
}

class NewsFiveViewState extends State<NewsFiveView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF6F7F9),
      child: RefreshWidget<NewsFiveController>(
        init: NewsFiveController(),
        scrollController: scrollController,
        topConfig: const ScrollTopConfig(),
        builder: (controller) {
          return Column(
            children: [
              Column(
                children: [
                  LeagueNearestView(
                    league: controller.league,
                  ),
                  SportDateMatch(
                    matches: controller.matches,
                  ),
                ],
              ),
              _buildNewsList(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNewsList(NewsFiveController controller) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 12.w),
      child: Column(
        children: controller.newsList
            .map((e) => SportNewsWidget(
                  news: e,
                ))
            .toList(),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
