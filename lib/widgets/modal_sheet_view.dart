import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/constants.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class ModalSheetView extends StatelessWidget {
  const ModalSheetView({
    Key? key,
    required this.title,
    required this.height,
    required this.child,
    this.onClose,
    this.borderRadius = 6,
  }) : super(key: key);

  final String title;
  final double height;
  final double borderRadius;
  final Widget child;
  final Function? onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius.w),
        topRight: Radius.circular(borderRadius.w),
      ),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 14.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  top: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      if (onClose != null) {
                        onClose!();
                      }
                      Get.back();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 50.w,
                      height: 32.w,
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        child: Icon(
                          const IconData(0xe606, fontFamily: 'iconfont'),
                          size: 12.sp,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Constants.line,
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
