import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/controller.dart';
import 'package:iwacai_lottery_app/env/log_profile.dart';
import 'package:iwacai_lottery_app/resources/assets_cache.dart';
import 'package:iwacai_lottery_app/routes/routes.dart';
import 'package:iwacai_lottery_app/store/balance.dart';
import 'package:iwacai_lottery_app/store/store.dart';
import 'package:iwacai_lottery_app/utils/storage.dart';
import 'package:iwacai_lottery_app/views/base/not_found_view.dart';

void main() async {
  ///运行时初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///存储初始化
  await Storage().initialize();

  ///强制竖屏
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  ///主应用入口
  runApp(const LotteryApp());

  ///
  ///状态栏一体化
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  ///EasyLoading初始化配置
  loadingConfiguration();
}

///
/// easyLoading初始化
void loadingConfiguration() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 32.0
    ..radius = 4.0
    ..lineWidth = 1.5
    ..userInteractions = false
    ..contentPadding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
}

class LotteryApp extends StatefulWidget {
  ///
  const LotteryApp({Key? key}) : super(key: key);

  @override
  LotteryAppState createState() => LotteryAppState();
}

class LotteryAppState extends State<LotteryApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    ThemeData theme =
    Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory);
    return ScreenUtilInit(
      designSize: const Size(375, 760),
      builder: (context, widget) =>
          GetMaterialApp(
            title: '哇彩',
            theme: theme,
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.fade,
            transitionDuration: const Duration(milliseconds: 300),
            builder: EasyLoading.init(),
            initialRoute: AppRoutes.splash,
            getPages: AppPages.routes,
            navigatorObservers: [AppPages.observer],
            unknownRoute: GetPage(
              name: AppRoutes.notFound,
              page: () => const RouteUnknownView(),
            ),
          ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logger.i('app life state [$state],current route ${Get.currentRoute}');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();

    ///应用监听
    WidgetsBinding.instance.addObserver(this);

    /// 应用配置加载
    ConfigStore();

    ///app应用初始化注册
    AppController();

    /// 用户信息加载
    UserStore();

    ///初始化余额账户
    BalanceInstance();

    ///图片预缓存
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //图片预缓存
      AssetsCache.preCacheImages(context);

      ///标记打开应用
      ConfigStore().openApp();
    });
  }
}
