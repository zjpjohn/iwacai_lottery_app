import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/scheme/controller/scheme_history_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class SchemeHistoryView extends StatelessWidget {
  ///
  ///
  const SchemeHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '历史情报',
      content: RefreshWidget<SchemeHistoryController>(
        init: SchemeHistoryController(),
        global: false,
        builder: (controller) => ListView.builder(
          itemCount: controller.datas.length,
          itemBuilder: (context, index) => _buildSchemeItem(controller, index),
        ),
      ),
    );
  }

  Widget _buildSchemeItem(SchemeHistoryController controller, int index) {
    ExpertScheme scheme = controller.datas[index];
    return GestureDetector(
      onTap: () {
        Get.toNamed('/scheme/${scheme.seqNo}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.w, horizontal: 16.w),
        decoration: BoxDecoration(
          border: index < controller.datas.length - 1
              ? Border(
                  bottom: BorderSide(
                  color: Colors.black12,
                  width: 0.25.w,
                ))
              : null,
        ),
        child: _buildSchemeView(scheme),
      ),
    );
  }

  Widget _buildSchemeView(ExpertScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.w),
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
                      text: scheme.formatTime,
                      children: [
                        TextSpan(
                          text: '发布',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 16.w),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black38,
                        ),
                        text: '${Tools.randLimit(scheme.browse, 100)}',
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
    );
  }
}
