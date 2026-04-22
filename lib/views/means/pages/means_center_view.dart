import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/league_center_controller.dart';
import 'package:iwacai_lottery_app/views/means/model/area_info.dart';
import 'package:iwacai_lottery_app/views/means/widgets/search_header.dart';
import 'package:iwacai_lottery_app/widgets/bottom_drag_widget.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/error_widget.dart';

class MeansCenterView extends StatefulWidget {
  const MeansCenterView({Key? key}) : super(key: key);

  @override
  MeansCenterViewState createState() => MeansCenterViewState();
}

class MeansCenterViewState extends State<MeansCenterView>
    with AutomaticKeepAliveClientMixin {
  ///
  /// 滑动控制器
  late ScrollController _scrollController;

  ///
  /// 赛事区域滚动
  late ScrollController _areaController;

  ///滑动偏移量
  double _offset = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double statusBar = MediaQuery.of(context).padding.top;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SizedBox(
              width: Get.width,
              height: statusBar + 90.w,
              child: ClipRect(
                child: Transform.scale(
                  scale: (statusBar + 90.w + _offset) / (statusBar + 90.w),
                  child: Image.asset(
                    R.leagueCenterHeader,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: statusBar),
              child: Stack(
                children: [
                  ScrollConfiguration(
                    behavior: CustomScrollBehavior(),
                    child: ExtendedNestedScrollView(
                      onlyOneScrollInBody: true,
                      controller: _scrollController,
                      pinnedHeaderSliverHeightBuilder: () => 50.w,
                      headerSliverBuilder: (context, scrolled) {
                        return [
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: SearchHeader(
                              expanded: 90.w,
                              collapse: 50.w,
                              title: '哇彩赛事',
                              leagues: 100,
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        color: const Color(0xFFF6F7F9),
                        child: RefreshWidget<LeagueCenterController>(
                          enableLoad: false,
                          showLoading: false,
                          bottomBouncing: false,
                          builder: (controller) {
                            return Container(
                              padding: EdgeInsets.only(top: 12.w, bottom: 16.w),
                              child: Column(
                                children: [
                                  _buildHotLeague(controller),
                                  _buildDateLeague(controller),
                                  Container(height: Get.height * 0.2),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DragContainer(
                      height: 366.w,
                      defaultShowHeight: Get.height * 0.20,
                      drawer: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          border: Border.all(
                            color: const Color(0xfff1f1f1),
                            width: 0.2.w,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xfff1f1f1),
                              offset: Offset(0.0, -1.0),
                              blurRadius: 8.0,
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 3.0.w,
                              width: 36.w,
                              margin: EdgeInsets.only(top: 12.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3E3E3),
                                borderRadius: BorderRadius.circular(4.w),
                              ),
                            ),
                            _buildAreaLayout(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaLayout() {
    return Expanded(
      child: GetBuilder<LeagueCenterController>(builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 12.w, right: 12.w),
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 36.w,
                alignment: Alignment.centerLeft,
                child: Text(
                  '区域赛事',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildArea(controller),
                  _buildAreaContent(controller),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildArea(LeagueCenterController controller) {
    List<Widget> items = [];
    for (int i = 0; i < controller.areas.length; i++) {
      AreaInfo area = controller.areas[i];
      items.add(
        GestureDetector(
          onTap: () {
            if (controller.area != area.code) {
              _areaController.animateTo(
                0,
                curve: Curves.bounceInOut,
                duration: const Duration(milliseconds: 250),
              );
            }
            controller.area = area.code;
          },
          child: Container(
            margin: EdgeInsets.only(right: 8.w),
            child: Stack(
              children: [
                Container(
                  width: area.name.length >= 3 ? 54.w : 44.w,
                  height: 22.w,
                  transform: Matrix4.skewX(-.2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    color: const Color(0xFFF6F7F9),
                  ),
                ),
                Container(
                  width: area.name.length >= 3 ? 54.w : 44.w,
                  height: 22.w,
                  padding: EdgeInsets.only(left: 7.w, top: 3.w),
                  child: Text(
                    area.name,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: controller.area == area.code
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: controller.area == area.code
                          ? const Color(0xFFFF0045)
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 8.w,left: 6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildAreaContent(LeagueCenterController controller) {
    return SizedBox(
      height: 280.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: _buildAreaCountries(controller),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                controller: _areaController,
                child: _buildAreaLeagues(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaCountries(LeagueCenterController controller) {
    List<Widget> views = [];
    if (controller.area != 4) {
      views.add(
        GestureDetector(
          onTap: () {
            controller.index = 0;
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 62.w,
            height: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: controller.index == 0
                  ? Colors.white
                  : const Color(0xFFF6F7F9),
              borderRadius: BorderRadius.only(
                  bottomRight: controller.index == 1
                      ? Radius.circular(6.w)
                      : Radius.zero),
            ),
            child: Text(
              '主流',
              style: TextStyle(
                fontSize: 13.sp,
                color: controller.index == 0
                    ? const Color(0xFFFF0045)
                    : Colors.black87,
              ),
            ),
          ),
        ),
      );

      List<CountryInfo> countries = controller.areaCountry();
      for (int i = 1; i <= countries.length; i++) {
        CountryInfo country = countries[i - 1];
        views.add(
          GestureDetector(
            onTap: () {
              controller.index = i;
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 62.w,
              height: 28.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.index == i
                    ? Colors.white
                    : const Color(0xFFF6F7F9),
                borderRadius: BorderRadius.only(
                  bottomRight: controller.index == i + 1
                      ? Radius.circular(6.w)
                      : Radius.zero,
                  topRight: controller.index == i - 1
                      ? Radius.circular(6.w)
                      : Radius.zero,
                ),
              ),
              child: Text(
                Tools.limitText(country.name, 3),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: controller.index == i
                      ? const Color(0xFFFF0045)
                      : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }
      views.add(
        GestureDetector(
          onTap: () {
            controller.toMore();
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: EdgeInsets.only(bottom: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7F9),
              borderRadius: BorderRadius.only(
                topRight: controller.index == countries.length
                    ? Radius.circular(6.w)
                    : Radius.zero,
              ),
            ),
            child: Container(
              width: 62.w,
              height: 28.w,
              alignment: Alignment.center,
              child: Text(
                '更多',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      List<CountryInfo> countries = controller.areaCountry();
      for (int i = 0; i < countries.length; i++) {
        CountryInfo country = countries[i];
        views.add(
          GestureDetector(
            onTap: () {
              controller.index = i;
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 62.w,
              height: 32.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: controller.index == i
                    ? Colors.white
                    : const Color(0xFFF6F7F9),
                borderRadius: BorderRadius.only(
                  bottomRight: controller.index == i + 1
                      ? Radius.circular(6.w)
                      : Radius.zero,
                  topRight: controller.index == i - 1
                      ? Radius.circular(6.w)
                      : Radius.zero,
                ),
              ),
              child: Text(
                Tools.limitText(country.name, 3),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: controller.index == i
                      ? const Color(0xFFFF0045)
                      : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 4.w),
      child: Column(
        children: views,
      ),
    );
  }

  Widget _buildAreaLeagues(LeagueCenterController controller) {
    if (controller.areaLoad) {
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8.w,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.8,
        padding: EdgeInsets.only(left: 10.w, top: 4.w, bottom: 10.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          16,
          (index) => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(4.w),
              border: Border.all(
                width: 1.w,
                color: const Color(0xFFFAFAFA),
              ),
            ),
          ),
        ),
      );
    }
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8.w,
      crossAxisSpacing: 8.w,
      childAspectRatio: 0.8,
      padding: EdgeInsets.only(left: 10.w, top: 4.w, bottom: 10.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: controller
          .areaLeague()
          .map(
            (e) => GestureDetector(
              onTap: () {
                Get.toNamed('/league/${e.id}');
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.only(top: 6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.w),
                  border: Border.all(
                    width: 1.w,
                    color: const Color(0xFFF6F7F9),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 6.w),
                        child: CachedAvatar(
                          width: 24.w,
                          height: 24.w,
                          url: e.logo,
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
                        Tools.limitText(e.name, 4),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 11.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildHotLeague(LeagueCenterController controller) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 12.w),
            child: Text(
              '热门联赛',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _hotLeague(controller),
        ],
      ),
    );
  }

  Widget _hotLeague(LeagueCenterController controller) {
    if (controller.state == RequestState.loading) {
      return GridView.count(
        crossAxisCount: 5,
        mainAxisSpacing: 16.w,
        crossAxisSpacing: 16.w,
        childAspectRatio: 0.8,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          10,
          (index) => Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 6.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(4.w),
            ),
          ),
        ),
      );
    }
    if (controller.state == RequestState.success) {
      if (controller.leagues.isNotEmpty) {
        return GridView.count(
          crossAxisCount: 5,
          mainAxisSpacing: 16.w,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.8,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.leagues
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    Get.toNamed('/league/${e.id}');
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.only(top: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      border: Border.all(
                        width: 1.w,
                        color: const Color(0xFFF6F7F9),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 6.w),
                            child: CachedAvatar(
                              width: 28.w,
                              height: 28.w,
                              url: e.logo,
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
                            e.name,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
        child: EmptyView(
          size: 80.w,
          message: '暂无热门赛事',
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
      child: ErrorView(
        width: 80.w,
        height: 80.w,
        message: '加载错误',
        callback: () {
          controller.onInitial();
        },
      ),
    );
  }

  Widget _buildDateLeague(LeagueCenterController controller) {
    return Container(
      margin: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 12.w),
            child: Text(
              '今日赛事',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _dateLeague(controller),
          if (controller.showMore)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 16.w),
              child: GestureDetector(
                onTap: () {
                  controller.showMore = false;
                },
                child: Text(
                  '显示全部',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _dateLeague(LeagueCenterController controller) {
    if (controller.state == RequestState.loading) {
      return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.w,
        crossAxisSpacing: 8.w,
        childAspectRatio: 2.2,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          9,
          (index) => Container(
            padding: EdgeInsets.only(right: 4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(6.w),
            ),
          ),
        ).toList(),
      );
    }
    if (controller.state == RequestState.success) {
      if (controller.leagueDate.isNotEmpty) {
        return GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          childAspectRatio: 2.2,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.leagueDate
              .sublist(
                  0, controller.showMore ? 12 : controller.leagueDate.length)
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (e.matches > 0) {
                      Get.toNamed('/league/schedule/${e.leagueId}');
                      return;
                    }
                    Get.toNamed('/league/${e.leagueId}');
                  },
                  behavior: HitTestBehavior.opaque,
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
                            url: e.logo,
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
                                Tools.limitText(e.name, 4),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13.sp,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '今日',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.black54,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${e.matches}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFFFF0045),
                                      ),
                                    ),
                                    const TextSpan(text: '场'),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
        child: EmptyView(
          size: 80.w,
          message: '今日暂无赛事',
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
      child: ErrorView(
        width: 80.w,
        height: 80.w,
        message: '加载错误',
        callback: () {
          controller.onInitial();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.put(LeagueCenterController());
    _scrollController = ScrollController();
    _areaController = ScrollController();
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _offset = _scrollController.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
