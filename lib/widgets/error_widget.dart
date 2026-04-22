import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

typedef ErrorCallback = void Function();

class ErrorView extends StatelessWidget {
  const ErrorView({
    Key? key,
    this.width,
    this.height,
    this.message,
    this.color = Colors.black26,
    this.callback,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? message;
  final Color color;
  final ErrorCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback!();
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 4.w),
              child: Image.asset(
                R.error,
                fit: BoxFit.contain,
                width: width ?? 144.w,
                height: height ?? 144.w,
              ),
            ),
            if (message != null)
              Text(
                '$message',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: color,
                ),
              )
          ],
        ),
      ),
    );
  }
}
