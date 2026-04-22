import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///
typedef TabSelectedHandle = Function(int index, TabEntry entry);

class TabFilterView extends StatefulWidget {
  TabFilterView({
    Key? key,
    this.initialIndex = 0,
    required this.child,
    required this.entries,
    required this.onSelected,
    required this.moreIcon,
  })  : assert(entries.isNotEmpty),
        assert(initialIndex >= 0),
        super(key: key);

  ///
  ///初始选项值
  final int initialIndex;

  ///
  ///
  final Widget child;

  ///
  /// tab选项卡集合
  final List<TabEntry> entries;

  ///
  /// 更多选项icon
  final IconData moreIcon;

  ///
  /// 选中回调操作
  final TabSelectedHandle onSelected;

  @override
  TabFilterViewState createState() => TabFilterViewState();
}

class TabFilterViewState extends State<TabFilterView>
    with SingleTickerProviderStateMixin {
  ///
  /// 是否展开
  bool _expanded = false;

  ///
  /// 背景层是否影藏
  bool _hide = true;

  ///
  /// 背景层透明度
  double _opacity = 0.0;

  ///
  /// 展开面板高度
  double _height = 0.0;

  ///
  /// 当前选中的tab标识
  late int _current;

  ///
  /// 组件偏移量集合
  final List<double> _offsets = [];

  ///
  /// tab选项卡key集合
  List<GlobalKey> _keys = [];

  ///
  /// tab面板key标识
  final GlobalKey _panelKey = GlobalKey();

  ///
  ///补间动画
  late Animation<double> _animation;

  ///
  /// 动画控制器
  late AnimationController _controller;

  ///
  /// 活动控制器
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 36.w,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 0.3.w),
              ),
            ),
            child: Stack(
              children: [
                _scrollTabView(),
                Positioned(
                  right: 36.w,
                  top: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 10.w,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFE9E9E9),
                            Color(0xFFF2F2F2),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: _buildMoreBtn(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                widget.child,
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _panelBackground(),
                    _panelContent(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// tab展开面板背景层
  Widget _panelBackground() {
    return Offstage(
      offstage: _hide,
      child: Opacity(
        opacity: _opacity,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _height = 0;
                _expanded = false;
                _controller.reverse();
              });
            },
            onVerticalDragStart: (drag) {
              setState(() {
                _height = 0;
                _expanded = false;
                _controller.reverse();
              });
            },
            child: Container(
              color: Colors.black12.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// tab展开面板内容层
  Widget _panelContent() {
    return AnimatedContainer(
      height: _height,
      width: double.infinity,
      color: Colors.white,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 250),
      constraints: const BoxConstraints(minWidth: 0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          key: _panelKey,
          alignment: Alignment.topCenter,
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 20.w, bottom: 4.w),
          child: Wrap(
            spacing: 10.w,
            alignment: WrapAlignment.start,
            children: _buildPanelTabs(),
          ),
        ),
      ),
    );
  }

  ///
  /// tab展开面板选项集合
  List<Widget> _buildPanelTabs() {
    List<Widget> items = [];
    for (int i = 0; i < widget.entries.length; i++) {
      items.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = false;
              _height = 0;
              _controller.reverse();
            });
            _handleTabControllerClick(i);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.w),
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(2.0.w),
            ),
            child: Text(
              widget.entries[i].value,
              style: TextStyle(
                fontSize: 13.sp,
                color: _current == i ? Colors.redAccent : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  ///
  /// 展开或收起面板按钮
  Widget _buildMoreBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          ///点击展开或收起
          _expanded = !_expanded;

          ///设置面板高度
          _height = _expanded ? _panelKey.currentContext!.size!.height : 0;

          ///展开或收起动画
          if (_expanded) {
            _controller.forward();
            return;
          }
          _controller.reverse();
        });
      },
      child: Container(
        height: 36.w,
        width: 36.w,
        alignment: Alignment.center,
        child: Icon(
          widget.moreIcon,
          size: 18.sp,
          color: Colors.black87.withOpacity(0.75),
        ),
      ),
    );
  }

  ///
  /// 滚动tab选项卡视图
  Widget _scrollTabView() {
    List<Widget> tabs = [SizedBox(width: 8.w)];
    for (int i = 0; i < widget.entries.length; i++) {
      tabs.add(_buildTabView(widget.entries[i], _keys[i], i));
    }
    return Container(
      margin: EdgeInsets.only(right: 36.w),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs,
        ),
      ),
    );
  }

  ///
  /// tab选项卡组件
  Widget _buildTabView(TabEntry entry, GlobalKey key, int index) {
    return GestureDetector(
      onTap: () {
        _handleTabControllerClick(index);
      },
      child: Container(
        key: key,
        height: 36.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Text(
          entry.value,
          style: TextStyle(
            fontSize: 15.sp,
            color: _current == index ? Colors.redAccent : Colors.black87,
          ),
        ),
      ),
    );
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _opacity = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (_expanded && status == AnimationStatus.forward) {
          setState(() {
            _hide = false;
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _hide = !_hide;
          });
        }
      });
  }

  ///
  /// 初始化
  void _initTabScroll() {
    ///设置各个tab选项卡key
    _keys = widget.entries.map((e) => GlobalKey()).toList();

    ///初始化scroll控制器
    _scrollController = ScrollController();

    ///组件渲染完成后计算各tab选项卡宽度
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _saveWidgetOffsets();
    });
  }

  ///
  /// 保存tab选项卡各个绝对偏移量
  void _saveWidgetOffsets() {
    for (int i = 0; i < widget.entries.length; i++) {
      _offsets.add(
          i == 0 ? 0 : _offsets[i - 1] + _keys[i].currentContext!.size!.width);
    }
  }

  ///
  /// 计算指定tab选项偏移坐标
  double centerOf(int index) {
    int idx =
        index < widget.entries.length - 2 ? index : widget.entries.length - 2;
    return (_offsets[idx] + _offsets[idx + 1]) / 2.0;
  }

  ///
  /// 计算tab选项滚动偏移量
  double tabScrollOffset(
      int index, double viewportWidth, double minExtent, double maxExtent) {
    return (centerOf(index) - viewportWidth / 2.0).clamp(minExtent, maxExtent);
  }

  ///
  /// 滚动到指定位置
  void _scrollToCurrentIndex(int index) {
    ScrollPosition position = _scrollController.position;
    double offset = tabScrollOffset(index, position.viewportDimension,
        position.minScrollExtent, position.maxScrollExtent);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  ///
  /// 处理点击tab选项
  void _handleTabControllerClick(int index) {
    if (_current != index) {
      setState(() {
        _current = index;
        widget.onSelected(index, widget.entries[index]);
      });
      _scrollToCurrentIndex(index);
    }
  }

  @override
  void initState() {
    super.initState();

    /// 当前选中下标初始化
    _current = widget.initialIndex;

    /// 初始化tab scroll
    _initTabScroll();

    /// 初始化动画
    _initAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class TabEntry {
  ///
  /// 选项标识
  String key;

  ///
  /// 选项值
  String value;

  TabEntry({
    required this.key,
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TabEntry &&
            runtimeType == other.runtimeType &&
            key == other.key);
  }

  @override
  int get hashCode => key.hashCode;
}
