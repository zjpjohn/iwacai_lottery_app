import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

typedef EmptyCallback = void Function();

class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    this.size,
    this.message,
    this.subtitle,
    this.callback,
  }) : super(key: key);

  final double? size;
  final String? message;
  final String? subtitle;
  final EmptyCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        callback!();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Image.asset(
              R.empty,
              width: size ?? 144.w,
              height: size ?? 144.w,
            ),
          ),
          if (message != null)
            Text(
              message!,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black26,
              ),
            ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black26,
              ),
            )
        ],
      ),
    );
  }
}
