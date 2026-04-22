import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/app/open_install.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:iwacai_lottery_app/views/home/pages/home_center_view.dart';
import 'package:iwacai_lottery_app/views/main/controller.dart';
import 'package:iwacai_lottery_app/views/means/pages/means_center_view.dart';
import 'package:iwacai_lottery_app/views/news/controller/channel_top_news.dart';
import 'package:iwacai_lottery_app/views/news/pages/news_center_view.dart';
import 'package:iwacai_lottery_app/views/user/index.dart';

class MainView extends StatefulWidget {
  ///
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> with WidgetsBindingObserver {
  ///
  /// tabbar页面集合
  final pages = [
    const HomeCenterView(),
    const NewsCenterView(),
    const MeansCenterView(),
    const UserCenterView(),
  ];

  ///
  /// 构建[BottomNavigationBarItem]集合
  List<BottomNavigationBarItem> _buildBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(R.home, width: 24.w, height: 24.w),
        activeIcon: Image.asset(R.homeOn, width: 24.w, height: 24.w),
        label: '赛程',
      ),
      BottomNavigationBarItem(
        icon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.news, width: 24, height: 22.w),
        ),
        activeIcon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.newsOn, width: 24.w, height: 22.w),
        ),
        label: '资讯',
      ),
      BottomNavigationBarItem(
        icon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.bifen, width: 24.w, height: 22.w),
        ),
        activeIcon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.bifenOn, width: 24.w, height: 22.w),
        ),
        label: '赛事',
      ),
      BottomNavigationBarItem(
        icon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.ucenter, width: 24.w, height: 22.w),
        ),
        activeIcon: Container(
          height: 24.w,
          width: 24.w,
          alignment: Alignment.center,
          child: Image.asset(R.ucenterOn, width: 24.w, height: 22.w),
        ),
        label: '我的',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find<MainController>();
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: WillPopScope(
        onWillPop: controller.isExit,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            itemCount: pages.length,
            itemBuilder: (context, index) => pages[index],
            onPageChanged: (index) {
              controller.handleChange(index);
            },
          ),
          bottomNavigationBar: GetBuilder<MainController>(
            builder: (_) {
              return BottomNavigationBar(
                items: _buildBarItems(),
                type: BottomNavigationBarType.fixed,
                currentIndex: controller.currentIndex,
                selectedItemColor: const Color(0xffFF0033),
                unselectedItemColor: const Color(0xff353535),
                iconSize: 22.0,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                onTap: (index) {
                  controller.jumpToPage(index);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    ///应用监听
    WidgetsBinding.instance.addObserver(this);

    ///置顶资讯配置
    ChannelTopNews();

    ///应用渠道安装初始化
    OpenInstall();

    ///主页面加载后获取安装参数
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///应用安装渠道参数
      OpenInstall().install();
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
