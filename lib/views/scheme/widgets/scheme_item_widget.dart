import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';

class SchemeItemWidget extends StatefulWidget {
  ///
  ///
  const SchemeItemWidget({Key? key, required this.scheme}) : super(key: key);

  final ExpertScheme scheme;

  @override
  SchemeItemWidgetState createState() => SchemeItemWidgetState();
}

class SchemeItemWidgetState extends State<SchemeItemWidget> {
  ///
  ///浏览量
  late int _browse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/scheme/${widget.scheme.seqNo}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 0.25.w,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpertView(widget.scheme),
            _buildSchemeView(widget.scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertView(ExpertScheme scheme) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          CachedAvatar(
            width: 36.w,
            height: 36.w,
            radius: 20.w,
            url: scheme.avatar,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheme.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  scheme.zhong,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemeView(ExpertScheme scheme) {
    return Padding(
      padding: EdgeInsets.only(top: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: Text(
              scheme.title,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: scheme.events
                      .map((e) => Container(
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 1.w,
                              horizontal: 6.w,
                            ),
                            child: Text(
                              e,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.sp),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black38,
                        ),
                        text: '${scheme.delta.time}${scheme.delta.text}',
                        children: [
                          TextSpan(
                            text: '发布',
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black38,
                          ),
                          text: '$_browse',
                          children: [
                            TextSpan(
                              text: '浏览',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _browse = Tools.randLimit(widget.scheme.browse, 100);
  }
}
