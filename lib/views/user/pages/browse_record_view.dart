import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_browse.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/user/controller/browse_record_controller.dart';
import 'package:iwacai_lottery_app/widgets/cached_avatar.dart';
import 'package:iwacai_lottery_app/widgets/layout_container.dart';

class BrowseRecordView extends StatelessWidget {
  ///
  const BrowseRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutContainer(
      title: '浏览历史',
      content: Container(
        color: const Color(0xFFF6F6FB),
        child: RefreshWidget<BrowseRecordController>(
          emptyText: '暂无浏览历史记录',
          builder: (controller) => ListView.builder(
            padding: EdgeInsets.only(top: 8.w, bottom: 16.w),
            itemCount: controller.records.length,
            itemBuilder: (context, index) => _buildRecordItem(
              controller.records[index],
              index < controller.records.length - 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordItem(SportBrowseRecord record, bool bordered) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 12.w, top: 10.w),
              child: Transform.rotate(
                angle: -pi / 12,
                child: Text(
                  record.type.description,
                  style: TextStyle(
                      fontSize: 34.sp,
                      color: Colors.blueAccent.withOpacity(0.1),
                      fontWeight: FontWeight.w700,
                      fontFamily: 'zhengdao'),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
            child: record.type.value == 1
                ? _buildLeague(record)
                : (record.type.value == 2
                    ? _buildTeam(record)
                    : _buildMatch(record)),
          ),
        ],
      ),
    );
  }

  Widget _buildLeague(SportBrowseRecord record) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/league/${record.browseId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedAvatar(
                width: 18.w,
                height: 18.w,
                url: record.browse.logo!,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  record.browse.name!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateUtil.formatDate(
                    DateUtil.parse(record.gmtCreate,
                        pattern: "yyyy/MM/dd HH:mm:ss"),
                    format: "yyyy.MM.dd HH:mm",
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    '浏览',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTeam(SportBrowseRecord record) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/team/${record.browse.leagueId}/${record.browseId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedAvatar(
                width: 18.w,
                height: 18.w,
                url: record.browse.logo!,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  record.browse.name!,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateUtil.formatDate(
                    DateUtil.parse(record.gmtCreate,
                        pattern: "yyyy/MM/dd HH:mm:ss"),
                    format: "yyyy.MM.dd HH:mm",
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    '浏览',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMatch(SportBrowseRecord record) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/match/${record.browseId}');
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Text(
                      Tools.limitText(record.browse.home!, 5),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  CachedAvatar(
                    width: 18.w,
                    height: 18.w,
                    url: record.browse.homeLogo!,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      'vs',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 13.sp,
                        fontFamily: 'bebas',
                      ),
                    ),
                  ),
                  CachedAvatar(
                    width: 18.w,
                    height: 18.w,
                    url: record.browse.awayLogo!,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      Tools.limitText(record.browse.away!, 5),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                DateUtil.formatDate(
                  DateUtil.parse(record.browse.vsDate!,
                      pattern: "yyyy/MM/dd HH:mm:ss"),
                  format: "MM.dd HH:mm",
                ),
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateUtil.formatDate(
                    DateUtil.parse(record.gmtCreate,
                        pattern: "yyyy/MM/dd HH:mm:ss"),
                    format: "yyyy.MM.dd HH:mm",
                  ),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.w),
                  child: Text(
                    '浏览',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
