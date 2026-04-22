import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/means/model/area_info.dart';
import 'package:iwacai_lottery_app/views/means/pages/views/country_list_view.dart';
import 'package:iwacai_lottery_app/widgets/custom_tab_indicator.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class AreaCountryView extends StatefulWidget {
  ///
  const AreaCountryView({Key? key}) : super(key: key);

  @override
  AreaCountryViewState createState() => AreaCountryViewState();
}

class AreaCountryViewState extends State<AreaCountryView>
    with TickerProviderStateMixin {
  ///
  List<AreaInfo> areas = [
    AreaInfo(code: 1, name: '欧洲赛事', nameEn: 'EUROPE'),
    AreaInfo(code: 2, name: '美洲赛事', nameEn: 'AMERICA'),
    AreaInfo(code: 3, name: '亚洲赛事', nameEn: 'ASIA'),
    AreaInfo(code: 5, name: '非洲赛事', nameEn: 'AFRICA'),
    AreaInfo(code: 4, name: '大洋洲赛事', nameEn: 'OCEANIA'),
    AreaInfo(code: 0, name: '国际赛事', nameEn: 'INTERNATION'),
  ];

  ///
  List<Widget> tabs = [
    Container(
      height: 28.h,
      child: const Text('欧洲'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('美洲'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('亚洲'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('非洲'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('大洋洲'),
      alignment: Alignment.center,
    ),
    Container(
      height: 28.h,
      child: const Text('国际'),
      alignment: Alignment.center,
    ),
  ];

  List<Widget> views = [
    const CountryListView(area: 1),
    const CountryListView(area: 2),
    const CountryListView(area: 3),
    const CountryListView(area: 5),
    const CountryListView(area: 4),
    const CountryListView(area: 0),
  ];

  ///
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '区域赛事',
      content: Column(
        children: [
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: _buildTabBar(),
          ),
          Expanded(
            child: TabBarView(
              children: views,
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.w, bottom: 6.w),
      width: double.infinity,
      child: TabBar(
        tabs: tabs,
        controller: _tabController,
        labelPadding: EdgeInsets.only(left: 2.w, right: 2.w),
        isScrollable: false,
        labelColor: Colors.blueAccent,
        unselectedLabelColor: Colors.black87,
        labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        indicator: CustomTabIndicator(
          ratio: 0.2,
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.w),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    int code = int.parse(Get.parameters['area'] ?? '0');
    int index = areas.indexWhere((e) => e.code == code);
    _tabController = TabController(
      initialIndex: index,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
