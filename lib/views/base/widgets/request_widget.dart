import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/error_widget.dart';
import 'package:iwacai_lottery_app/widgets/loading_widget.dart';

typedef RequestControllerBuilder<T extends BaseRequestController> = Widget
    Function(T controller);

class RequestWidget<Controller extends BaseRequestController>
    extends StatelessWidget {
  const RequestWidget({
    Key? key,
    this.tag,
    this.init,
    this.duration = 250,
    this.emptyText,
    this.global = true,
    required this.builder,
  }) : super(key: key);

  final bool global;
  final String? tag;
  final int duration;
  final String? emptyText;
  final Controller? init;

  /// 业务数据子组件构造器
  final RequestControllerBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
        tag: tag,
        init: init,
        global: global,
        builder: (controller) {
          if (controller.state == RequestState.loading) {
            return const Align(
              alignment: Alignment.center,
              child: LoadingView(),
            );
          }
          if (controller.state == RequestState.error) {
            return AnimatedOpacity(
              opacity: controller.opacity,
              duration: Duration(milliseconds: duration),
              child: Align(
                alignment: Alignment.center,
                child: ErrorView(
                  message: controller.message,
                  callback: () {
                    controller.reloadData();
                  },
                ),
              ),
            );
          }
          if (controller.state == RequestState.empty) {
            return AnimatedOpacity(
              opacity: controller.opacity,
              duration: Duration(milliseconds: duration),
              child: Align(
                alignment: Alignment.center,
                child: EmptyView(
                  size: 168.w,
                  message: emptyText ?? '暂无数据哟',
                  callback: () {
                    controller.reload();
                  },
                ),
              ),
            );
          }
          return AnimatedOpacity(
            opacity: controller.opacity,
            duration: Duration(milliseconds: duration),
            child: builder(controller),
          );
        });
  }
}
