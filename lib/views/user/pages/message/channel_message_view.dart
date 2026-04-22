import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_layout_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/channel_message_controller.dart';
import 'package:iwacai_lottery_app/views/user/widgets/message_widget.dart';

class ChannelMessageView extends StatelessWidget {
  ///
  ///
  const ChannelMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshLayoutWidget<ChannelMessageController>(
      empty: '暂无消息通知',
      titleBuilder: (controller) {
        return _buildTitleHeader(controller);
      },
      builder: (controller) {
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.messages.length,
          itemBuilder: (context, index) => MessageWidget.from(
            controller.messages[index],
          ),
        );
      },
    );
  }

  Widget _buildTitleHeader(ChannelMessageController controller) {
    return Text(
      controller.name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 17.sp,
      ),
    );
  }
}
