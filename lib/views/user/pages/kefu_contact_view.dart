import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/names.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/kefu_contact_controller.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class KefuContactView extends StatefulWidget {
  ///
  ///
  const KefuContactView({Key? key}) : super(key: key);

  @override
  KefuContactViewState createState() => KefuContactViewState();
}

class KefuContactViewState extends State<KefuContactView>
    with WidgetsBindingObserver {
  ///
  /// 键盘高度
  double keyboardHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '联系客服',
      content: RequestWidget<KefuContactController>(
        emptyText: '暂无客服通知',
        builder: (controller) {
          return Container(
            color: const Color(0xFFF6F6FB),
            child: Stack(
              children: [
                _buildKefuContent(controller),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _contactInput(controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildKefuContent(KefuContactController controller) {
    return SizedBox(
      width: Get.width,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 72.w),
            child: Column(
              children: [
                _contactHeaderView(),
                ..._kefuMessageList(controller.messages),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactHeaderView() {
    return Container(
      margin: EdgeInsets.only(top: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            R.kefuAvatar,
            width: 28.w,
            height: 28.w,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w),
            padding: EdgeInsets.all(10.w),
            constraints: BoxConstraints(
              maxWidth: Get.width - 80.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '尊敬的用户，人工客服工作时间为工作日的9:00-18:00,其他时段您可以在"',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.feedback);
                    },
                    child: Text(
                      '建议反馈',
                      style: TextStyle(
                        color: const Color(0xFF0066FF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: '"中留言，我们会在工作时间段尽快反馈回复。',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _kefuMessageList(List<KefuMessage> messages) {
    return messages.map((e) => _kefuMessageItem(e)).toList();
  }

  Widget _kefuMessageItem(KefuMessage message) {
    return Container(
      margin: EdgeInsets.only(top: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              '${message.messageTime.date}${message.messageTime.time}',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.black26,
              ),
            ),
          ),
          _messageContent(message),
        ],
      ),
    );
  }

  Widget _messageContent(KefuMessage message) {
    if (message.type == 'system') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            R.kefuAvatar,
            width: 28.w,
            height: 28.w,
          ),
          Container(
            margin: EdgeInsets.only(left: 10.w),
            padding: EdgeInsets.all(10.w),
            constraints: BoxConstraints(
              maxWidth: Get.width - 80.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: _message(
              message.messageType,
              message.message,
            ),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.w),
          padding: EdgeInsets.all(10.w),
          constraints: BoxConstraints(
            maxWidth: Get.width - 80.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: _message(
            message.messageType,
            message.message,
          ),
        ),
        Image.asset(
          R.avatar,
          width: 28.w,
          height: 28.w,
        ),
      ],
    );
  }

  Widget _message(MessageType type, String content) {
    if (type == MessageType.image) {
      return Image.file(File(content), width: 80.w);
    }
    return Text(
      content,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 14.sp,
      ),
    );
  }

  Widget _contactInput(KefuContactController controller) {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 60.w,
            child: Row(
              children: [
                SizedBox(width: 16.w),
                Expanded(
                  child: Container(
                    height: 38.w,
                    padding: EdgeInsets.only(left: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      border: Border.all(
                        width: 0.1.w,
                        color: const Color(0xFFF6F6F6),
                      ),
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: TextField(
                      maxLines: 1,
                      autofocus: true,
                      cursorWidth: 1.5.w,
                      focusNode: controller.focusNode,
                      textInputAction: TextInputAction.send,
                      controller: controller.textController,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        decoration: TextDecoration.none,
                      ),
                      decoration: const InputDecoration(
                        hintText: '请输入消息内容...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (text) {
                        controller.send();
                      },
                      onChanged: (text) {
                        controller.content = text;
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.showUpload = !controller.showUpload;
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    width: 26.w,
                    height: 26.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0066FF),
                      borderRadius: BorderRadius.circular(15.w),
                    ),
                    child: Icon(
                      const IconData(0xe602, fontFamily: 'iconfont'),
                      size: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.showUpload)
            Container(
              color: Colors.white,
              height: keyboardHeight,
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.sendImage(ImageSource.gallery);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 68.w,
                          height: 68.w,
                          margin: EdgeInsets.only(bottom: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.25.w,
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Icon(
                            const IconData(0xe630, fontFamily: 'iconfont'),
                            size: 30.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Text(
                        '相册',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20.w),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.sendImage(ImageSource.camera);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 68.w,
                          height: 68.w,
                          margin: EdgeInsets.only(bottom: 4.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.25.w,
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Icon(
                            const IconData(0xe653, fontFamily: 'iconfont'),
                            size: 32.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Text(
                        '拍照',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        double height = MediaQuery.of(context).viewInsets.bottom;
        if (height != 0) {
          keyboardHeight = height;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
