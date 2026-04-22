import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/feedback/controller.dart';
import 'package:iwacai_lottery_app/views/upload/upload_image_widget.dart';
import 'package:iwacai_lottery_app/widgets/action_state_button.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

const Map<int, String> types = {
  201: '注册登录',
  202: '赛事资讯',
  203: '赛事数据',
  204: '赛事分析',
  205: '赛事情报',
  206: '邀请分享',
  207: '积分签到',
  208: '领券奖励',
  209: '系统账户',
  210: '系统缺陷',
  211: '其他分类',
};

class AppFeedbackView extends StatelessWidget {
  ///
  ///
  const AppFeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '建议反馈',
      content: RequestWidget<AppFeedbackController>(
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTypeView(),
                  _buildContentView(),
                  _buildImageView(),
                  _buildSubmitBtn()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
      child: Text(
        '反馈分类',
        style: TextStyle(color: Colors.black87, fontSize: 16.sp),
      ),
    );
  }

  ///反馈问题类型
  Widget _buildTypeView() {
    return GetBuilder<AppFeedbackController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(top: 16.w),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 12.w,
          children: types.entries
              .map((item) => _buildTypeItem(controller, item.key, item.value))
              .toList(),
        ),
      );
    });
  }

  Widget _buildTypeItem(
      AppFeedbackController controller, int index, String name) {
    return GestureDetector(
      onTap: () {
        controller.type = index;
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 9.5.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffdcdcdc),
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 13.sp,
            color: controller.type == index ? Colors.redAccent : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return GetBuilder<AppFeedbackController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.w,
        ),
        child: TextField(
          controller: controller.controller,
          maxLines: 6,
          maxLength: 200,
          autofocus: false,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
          ),
          decoration: InputDecoration(
            hintText: '请输入您要反馈的问题内容（必填）',
            hintStyle: const TextStyle(color: Colors.black26),
            fillColor: const Color(0xFFF8F8F8),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6.w), //边角为5
              ),
              borderSide: const BorderSide(
                color: Colors.white, //边线颜色为白色
                width: 1, //边线宽度为2
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white, //边框颜色为白色
                width: 1, //宽度为5
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(6.w), //边角为30
              ),
            ),
          ),
          onChanged: (value) {
            controller.content = value;
          },
        ),
      );
    });
  }

  Widget _buildImageView() {
    return GetBuilder<AppFeedbackController>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(bottom: 16.w),
        child: UploadImage(
          key: controller.uploadKey,
          size: 90.w,
          maxSize: 3,
          prefix: '/feedback',
          success: (image) {
            controller.images.add(image);
          },
          remove: (image) {
            controller.images.remove(image);
          },
        ),
      );
    });
  }

  Widget _buildSubmitBtn() {
    return GetBuilder<AppFeedbackController>(builder: (controller) {
      return Container(
        height: 40.h,
        width: 220.w,
        margin: EdgeInsets.only(top: 24.w),
        child: ActionStateButton(
          active: '正在提交',
          unActive: '提交反馈',
          hintTxt: '提交中，请耐心等待',
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42.w),
              ),
            ),
          ),
          action: controller.submitFeedback,
        ),
      );
    });
  }
}
