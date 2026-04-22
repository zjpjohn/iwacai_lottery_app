import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/search_result.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_search_controller.dart';
import 'package:iwacai_lottery_app/views/means/widgets/search_input.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class LeagueSearchView extends StatelessWidget {
  const LeagueSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: true,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  GetBuilder<LeagueSearchController>(
                    builder: (controller) {
                      return SearchInput(
                        hintText: '请输入您要搜索的内容',
                        searchHeight: 48.h,
                        value: controller.search,
                        onSubmitted: (text) {
                          controller.searchAction();
                        },
                        onValueChanged: (text) {
                          controller.search = text;
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: SingleChildScrollView(
                        child: RequestWidget<LeagueSearchController>(
                          builder: (controller) {
                            return _buildSearchPanel(controller);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GetBuilder<LeagueSearchController>(
                builder: (controller) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: 52.w,
                    child: controller.showSearch
                        ? Container(
                            height: MediaQuery.of(context).size.height - 52.w,
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: _buildSearchResultView(controller),
                          )
                        : Container(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultView(LeagueSearchController controller) {
    if ((controller.results[0] != null && controller.results[0]!.isNotEmpty) ||
        (controller.results[1] != null && controller.results[1]!.isNotEmpty)) {
      return SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 48.w),
          child: Column(
            children: [
              if (controller.results[0]!.isNotEmpty)
                _buildSearchLeague(controller, controller.results[0]!),
              if (controller.results[1]!.isNotEmpty)
                _buildSearchTeam(controller, controller.results[1]!),
            ],
          ),
        ),
      );
    }
    if (controller.showSearch) {
      return Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 12.w),
        child: Text(
          '没有您要查找的内容',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
      );
    }
    return Container();
  }

  Widget _buildSearchLeague(
      LeagueSearchController controller, List<SearchResult> results) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '共查询到${results.length}项赛事',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...results
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    controller.gotoSearchDetail(e, history: true);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.5.sp,
                          ),
                        ),
                        Text(
                          e.relateName,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSearchTeam(
      LeagueSearchController controller, List<SearchResult> results) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '共查询到${results.length}只球队',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...results
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    controller.gotoSearchDetail(e, history: true);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.5.sp,
                          ),
                        ),
                        Text(
                          e.relateName,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildSearchPanel(LeagueSearchController controller) {
    return Column(
      children: [
        _buildHotLeagueView(controller),
        _buildMainLeagueView(controller),
        _buildSearchHistoryView(controller),
        SizedBox(height: 24.w),
      ],
    );
  }

  Widget _buildSearchHistoryView(LeagueSearchController controller) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜索历史',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.clearHistory();
                },
                child: SizedBox(
                  width: 36.w,
                  child: Icon(
                    Icons.delete_forever,
                    size: 20.sp,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12.w),
            child: Wrap(
              spacing: 14.w,
              runSpacing: 12.w,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: controller.histories
                  .map((e) => _buildHistoryItem(controller, e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
      LeagueSearchController controller, SearchResult result) {
    return GestureDetector(
      onTap: () {
        controller.gotoSearchDetail(result, history: false);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(3.5.w),
        ),
        child: Text(
          Tools.limitText(result.name, 10),
          style: TextStyle(
            color: result.type == 0
                ? const Color(0xFFF24040).withOpacity(0.75)
                : const Color(0xFF2866D5).withOpacity(0.75),
            fontSize: 12.5.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildHotLeagueView(LeagueSearchController controller) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '热门联赛',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            childAspectRatio: 2.5,
            padding: EdgeInsets.symmetric(vertical: 8.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.hotList.isNotEmpty
                ? controller.hotList.map((e) => _buildMatchFilter(e)).toList()
                : List.generate(9, (index) => _emptyShimmer()).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainLeagueView(LeagueSearchController controller) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '主流联赛',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            childAspectRatio: 2.5,
            padding: EdgeInsets.symmetric(vertical: 8.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.mainList.isNotEmpty
                ? controller.mainList.map((e) => _buildMatchFilter(e)).toList()
                : List.generate(12, (index) => _emptyShimmer()).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchFilter(MatchFilter league) {
    return GestureDetector(
      onTap: () {
        if (league.amount > 0) {
          Get.toNamed('/league/schedule/${league.id}');
          return;
        }
        Get.toNamed('/league/${league.id}');
      },
      child: Container(
        padding: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F7F9),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: CachedAvatar(
                width: 30.w,
                height: 30.w,
                radius: 2.w,
                url: league.logo,
                fit: BoxFit.fitWidth,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Tools.limitText(league.name, 4),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13.sp,
                    ),
                  ),
                  league.amount > 0
                      ? RichText(
                          text: TextSpan(
                            text: '近期',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: '${league.amount}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFFFF0045),
                                ),
                              ),
                              const TextSpan(text: '场'),
                            ],
                          ),
                        )
                      : Text(
                          '近期无比赛',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black54,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _emptyShimmer() {
    return Container(
      padding: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(6.w),
      ),
    );
  }
}
