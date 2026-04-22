import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController controller;

  const FocusTabBar({
    Key? key,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  FocusTabBarState createState() => FocusTabBarState();
}

class FocusTabBarState extends State<FocusTabBar> {
  ///
  late int _index;
  late VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildTabList(),
      ),
    );
  }

  List<Widget> _buildTabList() {
    List<Widget> tabList = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      tabList.add(_buildTab(widget.tabs[i], i));
    }
    return tabList;
  }

  Widget _buildTab(String name, int index) {
    return GestureDetector(
      onTap: () {
        if (_index != index) {
          widget.controller.index = index;
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        child: Stack(
          children: [
            Container(
              width: 44.w,
              height: 22.w,
              transform: Matrix4.skewX(-.3),
              decoration: BoxDecoration(
                color: _index == index
                    ? Colors.redAccent.withOpacity(0.1)
                    : const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(4.w),
              ),
            ),
            Container(
              width: 44.w,
              height: 22.w,
              padding: EdgeInsets.only(left: 6.w, top: 2.w),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: _index == index ? Colors.redAccent : Colors.black,
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
    _index = widget.controller.index;
    listener = () {
      setState(() {
        _index = widget.controller.index;
      });
    };
    widget.controller.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listener);
  }
}
