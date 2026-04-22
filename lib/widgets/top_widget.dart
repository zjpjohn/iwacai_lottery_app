import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(
          color: const Color(0xFFEFEFEF),
          width: 1.2.w,
        ),
      ),
      child: Container(
        width: 36.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Icon(
          const IconData(0xe7aa, fontFamily: 'iconfont'),
          size: 17.w,
          color: Colors.black87,
        ),
      ),
    );
  }
}
