import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/error_widget.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';
import 'package:iwacai_lottery_app/widgets/loading_widget.dart';

typedef RequestBuilder<T extends BaseRequestController> = Widget Function(
    T controller);
typedef ShareHandle<T extends BaseRequestController> = Function(T controller);

class ShareRequestWidget<Controller extends BaseRequestController>
    extends StatelessWidget {
  const ShareRequestWidget({
    Key? key,
    this.init,
    this.tag,
    this.share,
    this.emptyText,
    this.global = true,
    this.background = const Color(0xFFF6F6FB),
    required this.title,
    required this.builder,
  }) : super(key: key);
  final String? emptyText;
  final bool global;
  final String title;
  final String? tag;
  final Color background;
  final Controller? init;
  final ShareHandle<Controller>? share;
  final RequestBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Controller>(
      tag: tag,
      init: init,
      global: global,
      builder: (controller) {
        return LayoutContainer(
          title: title,
          right: controller.state == RequestState.success
              ? Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (share != null) {
                        share!(controller);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 46.w,
                      height: 32.w,
                      alignment: Alignment.centerRight,
                      child: Icon(
                        const IconData(0xe64b, fontFamily: 'iconfont'),
                        size: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              : null,
          content: Container(
            color: background,
            child: _buildContent(controller),
          ),
        );
      },
    );
  }

  Widget _buildContent(Controller controller) {
    if (controller.state == RequestState.loading) {
      return const Align(
        alignment: Alignment.center,
        child: LoadingView(),
      );
    }
    if (controller.state == RequestState.error) {
      return Align(
        alignment: Alignment.center,
        child: ErrorView(
          message: controller.message,
          callback: () {
            controller.request();
          },
        ),
      );
    }
    if (controller.state == RequestState.empty) {
      return Align(
        alignment: Alignment.center,
        child: EmptyView(
          message: emptyText ?? '暂无数据哟',
          callback: () {
            controller.request();
          },
        ),
      );
    }
    return builder(controller);
  }
}
