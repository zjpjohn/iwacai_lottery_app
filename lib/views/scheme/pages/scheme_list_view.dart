import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/scheme/controller/scheme_list_controller.dart';
import 'package:iwacai_lottery_app/views/scheme/widgets/scheme_item_widget.dart';

class SchemeListView extends StatefulWidget {
  ///
  ///
  const SchemeListView({Key? key}) : super(key: key);

  @override
  SchemeListViewState createState() => SchemeListViewState();
}

class SchemeListViewState extends State<SchemeListView>
    with AutomaticKeepAliveClientMixin {
  ///
  ///
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: const Color(0xFFF6F7F9),
      child: RefreshWidget<SchemeListController>(
        init: SchemeListController(),
        scrollController: scrollController,
        topConfig: const ScrollTopConfig(align: TopAlign.right),
        builder: (controller) => ListView.builder(
          itemCount: controller.datas.length,
          itemBuilder: (context, index) => SchemeItemWidget(
            scheme: controller.datas[index],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
