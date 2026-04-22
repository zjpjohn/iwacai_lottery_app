import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/home/model/match_focus_league.dart';
import 'package:iwacai_lottery_app/widgets/modal_sheet_view.dart';

typedef MatchLeagueChange = Function(MatchFocusLeague league);

class MatchLeagueView extends StatefulWidget {
  ///
  ///
  const MatchLeagueView({
    Key? key,
    required this.leagues,
    required this.onChange,
  }) : super(key: key);

  final List<MatchFocusLeague> leagues;
  final MatchLeagueChange onChange;

  @override
  MatchLeagueViewState createState() => MatchLeagueViewState();
}

class MatchLeagueViewState extends State<MatchLeagueView> {
  ///
  ///
  List<GlobalKey> keys = [];

  ///
  ///滑动控制器
  late ScrollController scrollController;

  ///
  ///
  late TabController tabController;

  ///
  /// 组件偏移量集合
  List<double> offsets = [];

  ///
  /// 选中的下标
  int? currentIndex;

  ///
  /// 已选中的数据
  MatchFocusLeague? _league;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFF6F6FB),
            width: 0.25.w,
          ),
        ),
      ),
      child: Row(
        children: [
          _scrollTabView(),
          if (widget.leagues.length >= 12) _buildMoreLeagues(),
        ],
      ),
    );
  }

  Widget _scrollTabView() {
    List<Widget> tabs = [
      SizedBox(width: 10.w),
    ];
    for (int i = 0; i < widget.leagues.length; i++) {
      tabs.add(_buildLeagueView(widget.leagues[i], keys[i], i));
    }
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs,
        ),
      ),
    );
  }

  Widget _buildLeagueView(MatchFocusLeague league, GlobalKey key, int index) {
    return GestureDetector(
      onTap: () {
        handleTabControllerClick(index);
      },
      child: Container(
        key: key,
        height: 36.w,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              league.league,
              style: TextStyle(
                fontSize: 14.sp,
                color: currentIndex == index
                    ? const Color(0xFFFF0033)
                    : Colors.black,
              ),
            ),
            Text(
              '${league.matches}',
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.2,
                color: const Color(0xFFFF0033),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoreLeagues() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0.w),
                topRight: Radius.circular(6.0.w),
              ),
            ),
            builder: (BuildContext context) {
              return _TabPanelView(
                initialIndex: currentIndex,
                leagues: widget.leagues,
                handle: handleTabControllerClick,
              );
            });
      },
      child: Container(
        height: 36.w,
        width: 42.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                offset: const Offset(-6, 0),
                blurRadius: 6,
                spreadRadius: 0.0)
          ],
        ),
        child: Icon(
          const IconData(0xe616, fontFamily: 'iconfont'),
          size: 18.w,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    keys = widget.leagues.map((e) => GlobalKey()).toList();

    ///绘制完成回调一次，只会回调一次
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      saveWidgetOffsets();
    });
  }

  @override
  void didUpdateWidget(MatchLeagueView oldWidget) {
    super.didUpdateWidget(oldWidget);

    ///数据变化
    if (keys.length != widget.leagues.length) {
      ///保存数据现场，重放老数据下标
      if (_league != null) {
        ///重置选中的下标
        currentIndex =
            widget.leagues.indexWhere((e) => e.leagueId == _league?.leagueId);
      }

      ///重新生成tab的GlobalKey
      keys = widget.leagues.map((e) => GlobalKey()).toList();

      ///更新重绘，监听绘制完成回调
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        saveWidgetOffsets();
        if (currentIndex != null) {
          scrollToCurrentIndex(currentIndex!);
        }
      });
    }
  }

  void saveWidgetOffsets() {
    for (int i = 0; i < widget.leagues.length; i++) {
      offsets.add(
          i == 0 ? 0 : offsets[i - 1] + keys[i].currentContext!.size!.width);
    }
  }

  double centerOf(int index) {
    if (widget.leagues.length < 2) {
      return 0;
    }
    int idx =
        index < widget.leagues.length - 2 ? index : widget.leagues.length - 2;
    return (offsets[idx] + offsets[idx + 1]) / 2.0;
  }

  double tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    return (centerOf(index) - viewportWidth / 2.0).clamp(minExtent, maxExtent);
  }

  void scrollToCurrentIndex(int index) {
    ScrollPosition position = scrollController.position;
    double offset = tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void handleTabControllerClick(int index) {
    if (currentIndex == index) {
      setState(() {
        currentIndex = null;
        _league = null;
      });
    } else {
      setState(() {
        currentIndex = index;
        _league = widget.leagues[index];
      });
      scrollToCurrentIndex(index);
    }
    widget.onChange(widget.leagues[index]);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

typedef SelectedHandle = Function(int index);

class _TabPanelView extends StatefulWidget {
  const _TabPanelView({
    Key? key,
    this.initialIndex = 0,
    required this.leagues,
    required this.handle,
  }) : super(key: key);

  ///
  ///
  final int? initialIndex;

  ///
  ///
  final List<MatchFocusLeague> leagues;

  ///
  ///
  final SelectedHandle handle;

  @override
  _TabPanelViewState createState() => _TabPanelViewState();
}

class _TabPanelViewState extends State<_TabPanelView> {
  ///
  ///
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '赛事联赛',
      height: MediaQuery.of(context).size.height * 0.4,
      child: Container(
        margin: EdgeInsets.only(top: 20.w, bottom: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Wrap(
          spacing: 16.w,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: _buildTabPanel(),
        ),
      ),
    );
  }

  List<Widget> _buildTabPanel() {
    List<Widget> items = [];
    for (int i = 0; i < widget.leagues.length; i++) {
      items.add(
        GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = currentIndex != i ? i : null;
            });
            widget.handle(i);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.w),
            padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(2.0.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.leagues[i].league,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: currentIndex == i
                        ? const Color(0xFFFF0033)
                        : Colors.black87,
                  ),
                ),
                Text(
                  '${widget.leagues[i].matches}',
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 14.sp,
                    color: const Color(0xFFFF0033),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }
}
