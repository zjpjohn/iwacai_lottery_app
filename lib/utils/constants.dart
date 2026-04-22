import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';

class Constants {

  ///
  ///
  static shareBottomSheet({
    required Widget content,
    Function? save,
    Function? shareWechat,
    Function? shareMoments,
    Function? copyLink,
  }) {
    Get.bottomSheet(
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          content,
          Container(
            height: 166.w,
            margin: EdgeInsets.only(top: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.w),
                topRight: Radius.circular(8.w),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () {
                          if (save != null) {
                            save();
                          }
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.downloadIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '保存图片',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (shareWechat == null) {
                            EasyLoading.showToast('暂未开通，请耐心等待');
                            return;
                          }
                          shareWechat();
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.wechatIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '微  信',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (shareMoments == null) {
                            EasyLoading.showToast('暂未开通，请耐心等待');
                            return;
                          }
                          shareMoments();
                        },
                        child: SizedBox(
                          width: 66.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 6.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Image.asset(
                                  R.momentsIcon,
                                  height: 34.w,
                                ),
                              ),
                              Text(
                                '朋友圈',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (copyLink != null)
                        GestureDetector(
                          onTap: () {
                            copyLink();
                          },
                          child: SizedBox(
                            width: 66.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5.w),
                                  margin: EdgeInsets.only(bottom: 6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: Image.asset(
                                    R.linkIcon,
                                    height: 34.w,
                                  ),
                                ),
                                Text(
                                  '复制链接',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 52.w,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(
                      '取 消',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 350),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
    );
  }

  ///
  ///bottom sheet
  static bottomSheet(Widget child) {
    Get.bottomSheet(
      child,
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 350),
      exitBottomSheetDuration: const Duration(milliseconds: 400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.w),
          topRight: Radius.circular(10.w),
        ),
      ),
    );
  }


  ///
  /// 竖线
  static Widget verticalLine({
    required double width,
    required double height,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget line = SizedBox(
    height: 0.5.w,
    width: double.infinity,
    child: const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
      ),
    ),
  );

  ///
  /// 计算文字宽高
  ///
  static Size measureText({
    required String text,
    required TextStyle style,
    int maxLines = 2 ^ 31,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(Get.context!),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  ///
  /// 颜色集合
  static final List<Color> bgColors = <Color>[
    const Color(0xff5b8ff9),
    const Color(0xff5ad8a6),
    const Color(0xff5d7092),
    const Color(0xfff6bd16),
    const Color(0xff6f5ef9),
    const Color(0xff6dc8ec),
    const Color(0xff945fb9),
    const Color(0xffff9845),
    const Color(0xffff99c3),
  ];

  static final List<Color> areaColors = <Color>[
    const Color(0xff5b8ff9),
    const Color(0xff5ad8a6),
    const Color(0xff6f5ef9),
    const Color(0xff5d7092),
    const Color(0xff945fb9),
    const Color(0xffff9845),
  ];

  ///
  ///hash值对应的颜色值
  static Color hashColor(String seed) {
    return bgColors[seed.hashCode % bgColors.length];
  }
}
