import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/controller/home_center_controller.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/views/home/model/sport_match_info.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/calendar_widget.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/error_widget.dart';
import 'package:iwacai_lottery_app/widgets/indicator_banner.dart';
import 'package:iwacai_lottery_app/widgets/loading_widget.dart';
import 'package:iwacai_lottery_app/widgets/top_widget.dart';

final double shrinkThrottle = 100.w;

class HomeCenterView extends StatefulWidget {
  const HomeCenterView({super.key});

  @override
  State<HomeCenterView> createState() => _HomeCenterViewState();
}

class _HomeCenterViewState extends State<HomeCenterView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  ScrollController scrollController = ScrollController();

  ///
  /// 初始下标
  int _currentIndex = 0;

  ///header背景色
  Color _color = const Color(0x00FFFFFF);

  ///背景图集合
  List<String> images = [
    R.homeHeader1,
    R.homeHeader2,
    R.homeHeader3,
    R.homeHeader4,
    R.homeHeader5,
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: const Color(0xFFF6F6FB),
          body: Stack(
            children: [
              Image.asset(
                images[_currentIndex],
                width: Get.width,
                height: 200.w,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  HomeTopHeader(color: _color),
                  _buildContentView(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return Expanded(
      child: HomeRefreshWidget<HomeCenterController>(
        init: HomeCenterController(),
        header: MaterialHeader(),
        scrollController: scrollController,
        topConfig: const ScrollTopConfig(align: TopAlign.right),
        builder: (controller) {
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: _buildHotMatch(controller),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: DateFilterHeader(
                  height: 128.w,
                  child: Column(
                    children: [
                      _buildCenterLeague(controller),
                      _buildDateFilter(controller),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 8.w),
              ),
              _buildMatchList(controller),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMatchList(HomeCenterController controller) {
    if (controller.pageState == HomePageState.loading) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 72.w),
          child: const LoadingView(),
        ),
      );
    }
    if (controller.pageState == HomePageState.error) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 72.w),
          child: ErrorView(
            width: 90.w,
            height: 90.w,
            message: '加载赛事失败',
            callback: () {
              controller.onInitial();
            },
          ),
        ),
      );
    }
    if (controller.matches.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(top: 72.w),
          child: EmptyView(
            size: 90.w,
            message: '今日暂无赛事',
            callback: () {
              controller.onInitial();
            },
          ),
        ),
      );
    }
    return SliverList.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
          child: SportMatchView(
            match: controller.matches[index],
          ),
        );
      },
      itemCount: controller.matches.length,
    );
  }

  Widget _buildCenterLeague(HomeCenterController controller) {
    if (controller.pageState == HomePageState.loading ||
        controller.pageState == HomePageState.error) {
      return Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.w),
          child: const CenterLeagueShimmer(
            count: 3,
            leagues: [],
          ),
        ),
      );
    }
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16.w),
      child: CenterLeagueShimmer(
        count: 3,
        leagues: controller.centerLeagues,
      ),
    );
  }

  Widget _buildHotMatch(HomeCenterController controller) {
    if (controller.pageState == HomePageState.loading ||
        controller.pageState == HomePageState.error) {
      return const HotMatchShimmer(matches: []);
    }
    return HotMatchShimmer(
        matches: controller.hotMatches,
        indexChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        });
  }

  Widget _buildDateFilter(HomeCenterController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF6F6FB),
            offset: const Offset(0, 2),
            blurRadius: 2.w,
            spreadRadius: 2.w,
          ),
        ],
      ),
      child: Container(
        height: 52.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12.w),
            bottomRight: Radius.circular(12.w),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 8.w),
            DayWeekCalendar(
              range: 12,
              width: Get.width - 44.w,
              time: controller.current,
              color: const Color(0x77000000),
              activeColor: const Color(0xFFFF0033),
              callback: (datetime, index) {
                if (!controller.requesting) {
                  controller.date = datetime;
                }
              },
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/filter/1');
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 36.w,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      R.filterIcon,
                      width: 20.w,
                      height: 20.w,
                    ),
                    Text(
                      '筛选',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
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
    scrollController.addListener(() {
      double offset = scrollController.offset;
      if (offset <= 0) {
        setState(() {
          _color = const Color(0x00FFFFFF);
        });
        return;
      }
      if (offset < shrinkThrottle && offset > 0) {
        int alpha = (offset / shrinkThrottle * 255).clamp(0, 255).toInt();
        setState(() {
          _color = Color.fromARGB(alpha, 255, 255, 255);
        });
        return;
      }
      if (offset >= shrinkThrottle) {
        setState(() {
          _color = const Color(0xFFFFFFFF);
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class DateFilterHeader extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  DateFilterHeader({
    required this.height,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class CenterLeagueShimmer extends StatelessWidget {
  const CenterLeagueShimmer({
    super.key,
    this.count = 3,
    required this.leagues,
  });

  final List<LeagueDate> leagues;
  final int count;

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    if (leagues.isEmpty) {
      items = List.generate(
        3,
        (index) => Expanded(
          child: Container(
            height: 42.w,
            margin: EdgeInsets.only(right: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(6.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 6.w, bottom: 6.w, right: 6.w),
                    color: Colors.white,
                    child: const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).toList();
    } else {
      items = leagues
          .sublist(0, 3)
          .map(
            (e) => Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/league/schedule/${e.leagueId}');
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 42.w,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.w),
                    border: Border.all(
                      color: const Color(0xFFF6F6F6),
                      width: 0.8.w,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: CachedAvatar(
                          width: 28.w,
                          height: 28.w,
                          radius: 2.w,
                          url: e.logo,
                          fit: BoxFit.fill,
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
                                text: '近期',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.black54,
                                ),
                                children: [
                                  TextSpan(
                                    text: '${e.matches}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFFF24040),
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
            ),
          )
          .toList();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShaderMask(
          shaderCallback: (bounds) {
            return linearGradient(
              Alignment.bottomRight,
              ['#f24040 50%', '#2866d5 50% 100%'],
            ).createShader(bounds);
          },
          child: Container(
            width: 30.w,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                Text(
                  '焦点',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontFamily: 'shuhei',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.w),
                  child: Text(
                    '联赛',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontFamily: 'shuhei',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

class HotMatchShimmer extends StatelessWidget {
  const HotMatchShimmer({
    super.key,
    required this.matches,
    this.indexChange,
  });

  final List<SportMatch> matches;
  final Function(int)? indexChange;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (matches.isEmpty) {
      content = Column(
        children: [
          Container(
            height: 68.w,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA).withOpacity(0.25),
              borderRadius: BorderRadius.circular(4.w),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.w),
            child: Container(
              width: 40.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
          ),
        ],
      );
    } else {
      content = IndicatorBanner(
        height: 68.w,
        inner: 4.w,
        outer: 6.w,
        autoPlay: true,
        onChange: (index) {
          if (indexChange != null) {
            indexChange!(index);
          }
        },
        children: matches
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Get.toNamed('/match/${e.matchId}');
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return linearGradient(
                                        -15,
                                        ['#f24040 50%', '#2866d5 50% 100%'],
                                      ).createShader(bounds);
                                    },
                                    child: Text(
                                      Tools.limitText(e.homeName, 6),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontFamily: 'shuhei',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: CachedAvatar(
                                      width: 20.w,
                                      height: 20.w,
                                      url: e.homeLogo,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 46.w,
                              alignment: Alignment.center,
                              child: Text(
                                stateStr(e),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14.sp,
                                  fontFamily: "bebas",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: CachedAvatar(
                                      width: 20.w,
                                      height: 20.w,
                                      url: e.awayLogo,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return linearGradient(
                                        15,
                                        ['#f24040 50%', '#2866d5 50% 100%'],
                                      ).createShader(bounds);
                                    },
                                    child: Text(
                                      Tools.limitText(e.awayName, 6),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontFamily: 'shuhei',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        top: 4.w,
                        child: Row(
                          children: [
                            Text(
                              e.league,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              DateUtil.formatDate(
                                e.vsDateTime,
                                format: 'MM/dd HH:mm',
                              ),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      );
    }
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: content,
      ),
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

class HomeTopHeader extends StatelessWidget {
  const HomeTopHeader({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    return PreferredSize(
      preferredSize: Size(Get.width, 56.w + statusBar),
      child: Container(
        height: 56.w + statusBar,
        color: color,
        child: Padding(
          padding: EdgeInsets.only(top: statusBar),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.matchResult);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 66.w,
                  height: 32.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(30.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.5.w, right: 2.w),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return linearGradient(
                              Alignment.bottomRight,
                              ['#f24040 50%', '#2866d5 50% 100%'],
                            ).createShader(bounds);
                          },
                          child: Icon(
                            const IconData(0xe631, fontFamily: 'iconfont'),
                            color: Colors.white,
                            size: 14.sp,
                          ),
                        ),
                      ),
                      Text(
                        '赛果',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.search);
                  },
                  child: Container(
                    height: 32.w,
                    padding: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          const IconData(0xe62f, fontFamily: 'iconfont'),
                          size: 14.w,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            '更多联赛比赛搜索',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.matchFocus);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 38.w,
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          R.subscribeIcon,
                          width: 25.w,
                          height: 25.w,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.matchSetting);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 38.w,
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          R.settingIcon,
                          width: 25.w,
                          height: 25.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeRefreshWidget<Controller extends BasePageQueryController>
    extends StatelessWidget {
  const HomeRefreshWidget({
    Key? key,
    this.init,
    this.global = true,
    this.tag,
    this.header,
    this.footer,
    this.topConfig,
    this.scrollController,
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    required this.builder,
    this.headBuilder,
  }) : super(key: key);

  ///
  ///
  final Controller? init;

  ///
  /// 是否为全局controller:配合init一起使用
  final bool global;

  ///
  ///
  final String? tag;

  ///
  /// 上拉刷新header
  final Header? header;

  ///
  /// 下拉加载footer
  final Footer? footer;

  ///
  /// 是否开启加载更多
  final bool enableLoad;

  ///
  /// 是否允许刷新
  final bool enableRefresh;

  ///
  /// 顶部是否有弹性
  final bool topBouncing;

  ///
  /// 底部是否有弹性
  final bool bottomBouncing;

  ///
  ///
  final ScrollTopConfig? topConfig;

  ///
  /// 滚动控制器
  final ScrollController? scrollController;

  ///
  /// 分页业务数据Widget,必须为ListView
  final PageRequestBuilder<Controller> builder;

  ///
  /// 非分页数据头部widget
  final WidgetRequestBuilder<Controller>? headBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        init: init,
        tag: tag,
        global: global,
        builder: (controller) {
          if (topConfig != null && scrollController != null) {
            controller.scrollListener(
              scrollController!,
              topConfig!.throttle,
              topConfig!.vertical,
            );
          }
          if (headBuilder != null) {
            return Column(
              children: [
                headBuilder!(controller),
                Expanded(
                  child: refreshView(controller),
                ),
              ],
            );
          }
          return refreshView(controller);
        });
  }

  Widget refreshView(Controller controller) {
    if (controller.state == RequestState.loading) {
      return EasyRefresh(
        topBouncing: false,
        bottomBouncing: false,
        header: null,
        footer: null,
        onRefresh: null,
        onLoad: null,
        scrollController: scrollController,
        child: builder(controller),
      );
    }
    return Stack(
      children: [
        EasyRefresh(
          ///
          controller: controller.refreshController,

          /// 顶部回弹
          topBouncing: topBouncing,

          /// 底部回弹
          bottomBouncing: bottomBouncing,

          ///滚动控制器
          scrollController: scrollController,

          ///默认开启刷新
          header: enableRefresh ? (header ?? DeliveryHeader()) : null,

          ///上拉加载需开启才会起作用(默认开启)
          footer: enableLoad && !controller.loadedAll()
              ? (footer ?? PhoenixFooter())
              : null,

          ///下拉刷新回调
          onRefresh: enableRefresh ? controller.refreshing : null,

          ///上拉加载数据(上拉加载需开启)
          onLoad: enableLoad && !controller.loadedAll()
              ? controller.loadMore
              : null,

          ///业务数据组件
          child: builder(controller),
        ),
        if (topConfig != null && controller.showTop)
          AnimatedPositioned(
            bottom: controller.topOffset,
            left: topConfig!.align == TopAlign.left
                ? topConfig!.horizontal
                : null,
            right: topConfig!.align == TopAlign.right
                ? topConfig!.horizontal
                : null,
            duration: Duration(milliseconds: topConfig!.duration),
            onEnd: () {
              if (controller.topOffset == 0) {
                controller.showTop = false;
              }
            },
            child: GestureDetector(
              onTap: () {
                scrollController!.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: const TopWidget(),
            ),
          )
      ],
    );
  }
}
