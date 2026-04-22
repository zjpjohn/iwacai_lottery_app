import 'package:flutter/material.dart';
import 'package:iwacai_lottery_app/routes/names.dart';
import 'package:iwacai_lottery_app/routes/pages.dart';

class RouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    AppPages.history.remove(route.settings.name);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    var name = route.settings.name ?? '';
    if (name.isNotEmpty && name != AppRoutes.login) {
      AppPages.history.add(name);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute == null) {
      return;
    }
    var name = newRoute.settings.name ?? '';
    if (name.isEmpty) {
      return;
    }
    if (name != AppRoutes.login) {
      var index = AppPages.history.indexWhere((e) => e == name);
      if (index > 0) {
        AppPages.history[index] = name;
      }
      AppPages.history.add(name);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    AppPages.history.remove(route.settings.name);
  }
}
