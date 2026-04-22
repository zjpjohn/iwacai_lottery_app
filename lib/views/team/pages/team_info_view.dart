import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/team/controller/team_center_controller.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';

class TeamInfoView extends StatefulWidget {
  const TeamInfoView({Key? key}) : super(key: key);

  @override
  TeamInfoViewState createState() => TeamInfoViewState();
}

class TeamInfoViewState extends State<TeamInfoView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<TeamCenterController>(
      builder: (controller) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader('基本资料'),
                _buildInfoItem(title: '球队名称', content: controller.team.nameCn),
                _buildInfoItem(title: '英文名', content: controller.team.nameEn),
                _buildInfoItem(title: '城市', content: controller.team.city),
                _buildInfoItem(title: '主场', content: controller.team.venue),
                _buildInfoItem(title: '成立时间', content: controller.team.setup),
                _buildInfoItem(
                  title: '官方网站',
                  content: controller.team.website,
                  bordered: false,
                ),
                Container(
                  height: 12.w,
                  color: const Color(0xFFF6F6F6),
                ),
                _buildHeader('球队介绍'),
                Container(
                  margin: EdgeInsets.only(top: 24.w),
                  child: EmptyView(
                    size: 90.w,
                    message: '暂无介绍信息',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black12, width: 0.25.w),
      )),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String content,
    bool bordered = true,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 14.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: bordered
              ? BorderSide(color: Colors.black12, width: 0.25.w)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
