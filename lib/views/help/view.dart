import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/help/controller.dart';
import 'package:iwacai_lottery_app/views/help/model/app_assistant.dart';
import 'package:iwacai_lottery_app/widgets/common_widgets.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_phasics.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class AppHelpView extends StatelessWidget {
  ///
  ///
  const AppHelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '应用助手',
      content: Container(
        color: Colors.white,
        child: RequestWidget<AppAssistantController>(
          builder: (controller) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                physics: const EasyRefreshPhysics(
                  topBouncing: false,
                  bottomBouncing: false,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 4.w),
                    ..._buildAssistantContent(controller.assistants),
                    SizedBox(height: 24.w),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildAssistantContent(List<AppAssistant> assistants) {
    List<Widget> views = [];
    for (int i = 0; i < assistants.length; i++) {
      views.add(_buildAssistantItem(assistants[i], i < assistants.length - 1));
    }
    return views;
  }

  Widget _buildAssistantItem(AppAssistant assistant, bool border) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: border
              ? BorderSide(
                  width: 0.25.w,
                  color: Colors.grey.withOpacity(0.3),
                )
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4.w),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 6.w, top: 7.w),
                  child: CommonWidgets.dotted(
                    size: 6.w,
                    color: Colors.blueAccent,
                  ),
                ),
                Expanded(
                  child: Text(
                    assistant.title.trim(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              assistant.content.trim(),
              style: TextStyle(
                height: 1.25,
                fontSize: 13.sp,
                color: const Color(0x9A000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
