import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/home/model/league_date_info.dart';
import 'package:iwacai_lottery_app/widgets/modal_sheet_view.dart';

typedef TabChangedCallback = Function(LeagueDate league);

class LeagueTabView extends StatefulWidget {
  const LeagueTabView({
    Key? key,
    required this.leagues,
    required this.callback,
    required this.leagueDay,
  }) : super(key: key);

  ///
  ///
  final List<LeagueDate> leagues;

  ///
  ///
  final TabChangedCallback callback;

  ///
  final DateTime leagueDay;

  @override
  LeagueTabViewState createState() => LeagueTabViewState();
}

class LeagueTabViewState extends State<LeagueTabView> {
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
  /// 上一次滑动的位置
  late Offset last;

  ///
  /// 组件偏移量集合
  List<double> offsets = [];

  ///
  /// 选中的下标
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.w,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.15.w),
          ),
        ),
        child: Row(
          children: [
            _scrollTabView(),
            if (widget.leagues.length >= 12) _buildMoreLeagues(),
          ],
        ),
      ),
    );
  }

  Widget _scrollTabView() {
    List<Widget> tabs = [];
    for (int i = 0; i < widget.leagues.length; i++) {
      tabs.add(_buildLeagueView(widget.leagues[i], keys[i], i));
    }
    return Expanded(
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tabs,
        ),
      ),
    );
  }

  Widget _buildLeagueView(LeagueDate league, GlobalKey key, int index) {
    return GestureDetector(
      onTap: () {
        handleTabControllerClick(index);
        widget.callback(league);
      },
      child: Container(
        key: key,
        height: 35.w,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              league.name,
              style: TextStyle(
                fontSize: 14.sp,
                color: currentIndex == index ? Colors.redAccent : Colors.black,
              ),
            ),
            Text(
              '${league.matches}',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 14.sp,
                height: 1.2,
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
        height: 35.w,
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
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    keys = widget.leagues.map((e) => GlobalKey()).toList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      saveWidgetOffsets();
    });
  }

  @override
  void didUpdateWidget(LeagueTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    keys = widget.leagues.map((e) => GlobalKey()).toList();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      saveWidgetOffsets();
    });
    if (widget.leagueDay.day != oldWidget.leagueDay.day) {
      currentIndex = null;
      scrollController.jumpTo(0);
      scrollController = ScrollController();
    }
  }

  void saveWidgetOffsets() {
    offsets.clear();
    for (int i = 0; i < widget.leagues.length; i++) {
      offsets.add(
          i == 0 ? 0 : offsets[i - 1] + keys[i].currentContext!.size!.width);
    }
  }

  double centerOf(int index) {
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
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
      });
      scrollToCurrentIndex(index);
      widget.callback(widget.leagues[index]);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

typedef SelectedHandle = Function(int index);

class _TabPanelView extends StatefulWidget {
  const _TabPanelView(
      {Key? key,
      this.initialIndex = 0,
      required this.leagues,
      required this.handle})
      : super(key: key);

  ///
  ///
  final int? initialIndex;

  ///
  ///
  final List<LeagueDate> leagues;

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
      title: '今日赛事',
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        margin: EdgeInsets.only(top: 20.w, bottom: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
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
            if (currentIndex != i) {
              widget.handle(i);
              setState(() {
                currentIndex = i;
              });
            }
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
                  widget.leagues[i].name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        currentIndex == i ? Colors.redAccent : Colors.black87,
                  ),
                ),
                Text(
                  '${widget.leagues[i].matches}',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14.sp,
                    height: 1.2,
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
