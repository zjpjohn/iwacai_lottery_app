import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/invite_history_controller.dart';
import 'package:iwacai_lottery_app/views/user/model/user_info.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class InviteHistoryView extends StatelessWidget {
  ///
  ///
  const InviteHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '邀请历史',
      content: RefreshWidget<InviteHistoryController>(
        bottomBouncing: false,
        emptyText: '暂无邀请记录',
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.histories.length,
            itemBuilder: (context, index) {
              return _buildHistoryItem(
                controller.histories[index],
                index < controller.histories.length - 1,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHistoryItem(UserInfo user, bool border) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: border
              ? BorderSide(color: const Color(0xFFF1F1F1), width: 0.3.w)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user.nickname,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Tools.encodeTel(user.phone),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateUtil.formatDate(
                      DateUtil.parse(
                        user.gmtCreate,
                        pattern: "yyyy/MM/dd HH:mm",
                      ),
                      format: "yyyy.MM.dd HH:mm",
                    ),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
