import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MainController extends GetxController with WidgetsBindingObserver {
  ///
  /// [BottomNavigationBar]默认下标
  ///
  int currentIndex = 0;

  ///
  /// [BottomNavigationBar]页面控制器
  ///
  final PageController pageController = PageController(initialPage: 0);

  ///
  /// 上一次点击时间
  ///
  DateTime? lastTime;

  ///
  /// 跳转指定下标页面
  ///
  void jumpToPage(int index) {
    pageController.jumpToPage(index);
  }

  ///
  /// 处理[BottomNavigationBar]下标变化
  ///
  void handleChange(index) {
    if (currentIndex == index) {
      return;
    }
    currentIndex = index;
    update();
  }

  ///
  /// 退出应用判断
  ///
  Future<bool> isExit() async {
    DateTime current = DateTime.now();
    if (lastTime == null ||
        current.difference(lastTime!) > const Duration(seconds: 2)) {
      lastTime = current;
      EasyLoading.showToast('再按一次退出');
      return false;
    }
    return true;
  }

  ///
  /// 应用前后台切换处理
  ///
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
