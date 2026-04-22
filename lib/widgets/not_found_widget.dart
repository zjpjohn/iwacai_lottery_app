import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

class NotFoundView extends StatelessWidget {
  ///
  ///
  const NotFoundView({
    Key? key,
    this.message,
    this.size,
  }) : super(key: key);

  final String? message;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4.w),
          child: Image.asset(
            R.notFound,
            width: size ?? 144.w,
            height: size ?? 144.w,
          ),
        ),
        Text(
          message ?? '访问的页面不存在',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black26,
          ),
        )
      ],
    );
  }
}
