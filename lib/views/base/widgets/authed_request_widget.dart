import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/user.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';

class AuthedRequestWidget<Controller extends BaseRequestController>
    extends StatelessWidget {
  ///
  ///
  const AuthedRequestWidget({
    Key? key,
    this.tag,
    this.init,
    this.emptyText,
    this.global = true,
    required this.builder,
  }) : super(key: key);

  final bool global;
  final String? tag;
  final String? emptyText;
  final Controller? init;

  /// 业务数据子组件构造器
  final RequestControllerBuilder<Controller> builder;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserStore>(
      builder: (store) {
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
        return RequestWidget<Controller>(
          init: init,
          tag: tag,
          global: global,
          emptyText: emptyText,
          builder: builder,
        );
      },
    );
  }
}
