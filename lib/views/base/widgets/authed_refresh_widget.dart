import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/user.dart';
import 'package:iwacai_lottery_app/views/base/page_controller.dart';
import 'package:iwacai_lottery_app/views/base/request_state.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';

class AuthedRefreshWidget<Controller extends BasePageQueryController>
    extends StatelessWidget {
  ///
  ///
  const AuthedRefreshWidget({
    Key? key,
    required this.init,
    this.tag,
    this.header,
    this.footer,
    this.emptyText = '暂无数据哟',
    this.topBouncing = true,
    this.bottomBouncing = true,
    this.enableRefresh = true,
    this.enableLoad = true,
    this.scrollController,
    required this.builder,
    this.widgetBuilder,
    this.headBuilder,
  }) : super(key: key);

  ///
  ///
  final Controller init;

  ///
  /// 空值描述文字
  final String emptyText;

  ///
  ///
  final String? tag;

  ///
  /// 上拉刷新header
  ///
  final Header? header;

  ///
  /// 下拉加载footer
  ///
  final Footer? footer;

  ///
  /// 是否开启加载更多
  ///
  final bool enableLoad;

  ///
  /// 是否允许刷新
  final bool enableRefresh;

  ///
  /// 顶部是否有弹性
  final bool topBouncing;

  /// 底部是否有弹性
  final bool bottomBouncing;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 分页业务数据Widget,必须为ListView
  final PageRequestBuilder<Controller> builder;

  /// 非分页数据Widget
  final WidgetRequestBuilder<Controller>? widgetBuilder;

  /// 头部非分页数据Widget
  final WidgetRequestBuilder<Controller>? headBuilder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserStore>(builder: (store) {
      if (!store.authSuccess) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              R.unLoginIllus,
              width: 180.w,
              height: 180.w,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.login);
              },
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '登录后查看，',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black26,
                    ),
                  ),
                  Text(
                    '去登录吧',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
      Controller controller = Get.put<Controller>(init, tag: tag);
      if (controller.state == RequestState.error) {
        controller.onInitial();
      }
      return RefreshWidget<Controller>(
        tag: tag,
        global: true,
        header: header,
        footer: footer,
        emptyText: emptyText,
        topBouncing: topBouncing,
        bottomBouncing: bottomBouncing,
        enableLoad: enableLoad,
        enableRefresh: enableRefresh,
        builder: builder,
        widgetBuilder: widgetBuilder,
        headBuilder: headBuilder,
      );
    });
  }
}
