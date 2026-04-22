import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VsFeatureWidget extends StatefulWidget {
  const VsFeatureWidget({
    super.key,
    required this.title,
    required this.width,
    required this.max,
    required this.home,
    required this.homeName,
    required this.away,
    required this.awayName,
  });

  final double width;
  final double max;
  final double home;
  final String homeName;
  final double away;
  final String awayName;
  final String title;

  @override
  State<VsFeatureWidget> createState() => _VsFeatureWidgetState();
}

class _VsFeatureWidgetState extends State<VsFeatureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w),
      width: widget.width * 2 + 8.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    widget.awayName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'bebas',
                      color: const Color(0xFF2866D5),
                    ),
                  ),
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: Text(
                    widget.homeName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'bebas',
                      color: const Color(0xFFF24040),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: widget.width,
                height: 4.w,
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Container(
                  height: 4.w,
                  width: widget.width * (widget.away / widget.max).clamp(0, 1),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2866D5),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: widget.width,
                height: 4.w,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Container(
                  height: 4.w,
                  width: widget.width * widget.home / widget.max,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF24040),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
