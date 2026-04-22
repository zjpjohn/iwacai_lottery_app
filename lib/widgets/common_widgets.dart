import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonWidgets {
  static InputDecoration filledDecoration(
      {required String hintText, String? helperText}) {
    return InputDecoration(
      hintText: hintText,
      helperText: helperText ?? '',
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      fillColor: const Color(0xFFF6F7FB),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      helperStyle: TextStyle(fontSize: 11.sp),
      errorStyle: TextStyle(fontSize: 11.sp),
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16.sp,
      ),
    );
  }

  static InputDecoration inputDecoration(
      {required String hintText, String? helperText}) {
    return InputDecoration(
      hintText: hintText,
      helperText: helperText ?? '',
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blueAccent,
          width: 0.25.w,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black45,
          width: 0.25.w,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 0.25.w,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 0.25.w,
        ),
      ),
      helperStyle: TextStyle(fontSize: 11.sp),
      errorStyle: TextStyle(fontSize: 11.sp),
      hintStyle: TextStyle(
        color: Colors.black54,
        fontSize: 16.sp,
      ),
    );
  }

  static Widget dotted({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
