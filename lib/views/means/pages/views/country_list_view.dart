import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/widgets/request_widget.dart';
import 'package:iwacai_lottery_app/views/means/controller/country_list_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/custom_scroll_behavior.dart';

class CountryListView extends StatefulWidget {
  ///
  const CountryListView({
    Key? key,
    required this.area,
  }) : super(key: key);

  ///
  final int area;

  @override
  CountryListViewState createState() => CountryListViewState();
}

class CountryListViewState extends State<CountryListView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RequestWidget<CountryListController>(
      global: false,
      init: CountryListController(area: widget.area),
      builder: (controller) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: controller
                  .groupCountries()
                  .entries
                  .map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xFFFBFBFB),
                          padding: EdgeInsets.only(
                            left: 16.w,
                            bottom: 8.w,
                            top: 8.w,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.key,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GridView.count(
                          padding: EdgeInsets.all(16.w),
                          crossAxisCount: 4,
                          mainAxisSpacing: 16.w,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 0.8,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children:
                              e.value.map((v) => _countryItemView(v)).toList(),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _countryItemView(CountryInfo country) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '/country/league/${country.id}',
          arguments: country,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          border: Border.all(
            width: 0.8.w,
            color: const Color(0xFFF6F7F9),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 6.w,
                ),
                child: CachedAvatar(
                  width: 32.w,
                  height: 32.w,
                  url: country.logo,
                  color: Colors.white,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.w),
              child: Text(
                Tools.limitText(country.name, 4),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13.sp,
                ),
              ),
            ),
            Container(
              color: const Color(0xFFF6F7F9),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: Text(
                '${country.leagues}个赛事',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 11.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
