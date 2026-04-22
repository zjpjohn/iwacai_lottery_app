import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/store.dart';

class RouteAuthMiddleware extends GetMiddleware {
  ///
  /// 越小优先级越高
  @override
  int? priority = 0;

  RouteAuthMiddleware({this.priority = 0});

  @override
  RouteSettings? redirect(String? route) {
    String token = UserStore().authToken;
    if (token.isNotEmpty || route == AppRoutes.login) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
