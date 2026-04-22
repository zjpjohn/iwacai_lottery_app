import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';

///
/// 时间变化回调
typedef DayChangeCallback = Function(DateTime dateTime, int index);

Map<int, String> weeks = {
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '日',
};

class DayWeekCalendar extends StatefulWidget {
  const DayWeekCalendar({
    Key? key,
    this.range = 7,
    required this.width,
    required this.time,
    this.iconCode = 0xe656,
    this.color = Colors.black26,
    this.activeColor = Colors.black87,
    this.direction = CalendarDirection.future,
    required this.callback,
  }) : super(key: key);

  ///
  /// 计算方向
  final CalendarDirection direction;

  ///
  /// 起点时间
  final DateTime time;

  /// 日历总宽度
  final double width;

  ///
  /// 显示天数范围
  final int range;

  ///
  /// icon unicode
  final int iconCode;

  ///
  /// 文字颜色以及边框未选中
  final Color color;

  ///
  /// 选中颜色
  final Color activeColor;

  ///
  /// 日期回调
  final DayChangeCallback callback;

  @override
  _DayWeekCalendarState createState() => _DayWeekCalendarState();
}

class _DayWeekCalendarState extends State<DayWeekCalendar> {
  ///
  /// 当前日期时间
  final DateTime _current = DateTime.now();

  late int _index;
  late double _width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      color: Colors.white,
      padding: EdgeInsets.only(right: 12.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildCalendarTabs(),
        ),
      ),
    );
  }

  List<Widget> _buildCalendarTabs() {
    int currentDay = DateUtil.getDayOfYear(_current);
    return List.generate(widget.range, (index) {
      int delta = widget.direction == CalendarDirection.future
          ? index
          : (index + 1 - widget.range);
      DateTime dateTime = widget.time.add(Duration(days: delta));
      return GestureDetector(
        onTap: () {
          setState(() {
            _index = index;
          });
          widget.callback(dateTime, index);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: _width,
          height: 52.w,
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTextWeek(dateTime, currentDay),
              _buildTextNumber(dateTime, index, currentDay),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTextWeek(DateTime dateTime, int currentDay) {
    if (DateUtil.getDayOfYear(dateTime) - currentDay == 0) {
      return ShaderMask(
        shaderCallback: (bounds) {
          return linearGradient(
            Alignment.bottomRight,
            ['#f24040 50%', '#2866d5 50% 100%'],
          ).createShader(bounds);
        },
        child: Text(
          '今',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: 'shuhei',
            color: Colors.white,
          ),
        ),
      );
    }
    return Text(
      '${weeks[dateTime.weekday]}',
      style: TextStyle(
        fontSize: 15.sp,
        fontFamily: 'shuhei',
        color: Colors.black12,
      ),
    );
  }

  Widget _buildTextNumber(DateTime dateTime, int index, int currentDay) {
    if (_index != index && DateUtil.getDayOfYear(dateTime) - currentDay != 0) {
      return Text(
        '${dateTime.day < 10 ? '0' + dateTime.day.toString() : dateTime.day}',
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'shuhei',
          color: widget.color,
        ),
      );
    }
    if (DateUtil.getDayOfYear(dateTime) - currentDay == 0 && _index != index) {
      return ShaderMask(
        shaderCallback: (bounds) {
          return linearGradient(
            Alignment.topRight,
            ['#f24040 50%', '#2866d5 50% 100%'],
          ).createShader(bounds);
        },
        child: Text(
          '${dateTime.day < 10 ? '0' + dateTime.day.toString() : dateTime.day}',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'shuhei',
            color: Colors.white,
          ),
        ),
      );
    }
    return  ShaderMask(
        shaderCallback: (bounds) {
          return linearGradient(
            Alignment.bottomRight,
            ['#f24040 35%', '#00C853 35% 65%','#2866d5 65% 100%'],
          ).createShader(bounds);
        },
        child: Icon(
          const IconData(0xe636, fontFamily: 'iconfont'),
          size: 20.sp,
          color: Colors.white,
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    _width = (widget.width - 12.w) / widget.range;
    _index =
        widget.direction == CalendarDirection.future ? 0 : widget.range - 1;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum CalendarDirection {
  future,
  past,
}
