import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateLineChart extends StatefulWidget {
  const RateLineChart({
    super.key,
    required this.title,
    required this.color,
    required this.width,
    required this.height,
    required this.ratio,
    this.duration = 500,
  });

  final String title;
  final Color color;
  final double width;
  final double height;
  final int duration;
  final double ratio;

  @override
  State<RateLineChart> createState() => _RateLineChartState();
}

class _RateLineChartState extends State<RateLineChart> {
  ///
  ///
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.w),
              topRight: Radius.circular(2.w),
            ),
          ),
          child: AnimatedContainer(
            alignment: Alignment.bottomCenter,
            width: widget.width,
            height: _height,
            duration: Duration(milliseconds: widget.duration),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.w),
                topRight: Radius.circular(2.w),
              ),
            ),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      _height = widget.ratio * widget.height;
      if (mounted) {
        setState(() {});
      }
    });
  }
}
