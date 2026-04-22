import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final double barHeight = 44.w;

class ShrinkOffsetAppbar extends StatelessWidget {
  const ShrinkOffsetAppbar({
    super.key,
    required this.title,
    required this.throttle,
    required this.shrinkOffset,
    this.rightAction,
    this.rightText,
    this.rightColor,
  });

  final String title;
  final double throttle;
  final double shrinkOffset;
  final String? rightText;
  final Color? rightColor;
  final Function()? rightAction;

  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    final int alpha = (shrinkOffset / throttle * 255).clamp(0, 255).toInt();
    Color color = Color.fromARGB(alpha, 255, 255, 255);
    Color textColor = Color.fromARGB(alpha, 0, 0, 0);
    return Container(
      color: color,
      height: 44.w + paddingTop,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: paddingTop),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 50.w,
                  height: 26.w,
                  padding: EdgeInsets.only(left: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    const IconData(0xe669, fontFamily: 'iconfont'),
                    size: 18.w,
                    color: textColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: textColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: rightText == null || rightText!.isEmpty
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        if (rightAction != null) {
                          rightAction!();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 20.w),
                        alignment: Alignment.centerRight,
                        child: Text(
                          rightText!,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: rightColor ?? textColor,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
