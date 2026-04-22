import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/home/widgets/sport_match_widget.dart';
import 'package:iwacai_lottery_app/views/subscribe/controller/focus_match_controller.dart';

class FocusMatchView extends StatefulWidget {
  ///
  const FocusMatchView({Key? key}) : super(key: key);

  @override
  FocusMatchViewState createState() => FocusMatchViewState();
}

class FocusMatchViewState extends State<FocusMatchView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<FocusMatchController>(
      init: FocusMatchController(),
      emptyText: '暂无比赛收藏',
      builder: (controller) => ListView.builder(
        itemCount: controller.matches.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.15.w,
                  color: Colors.black12,
                ),
              ),
            ),
            child: SportMatchView(
              match: controller.matches[index],
              focusHandle: (match) {
                controller.cancelFocus(match);
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
