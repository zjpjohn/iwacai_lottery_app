import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/utils/tools.dart';
import 'package:iwacai_lottery_app/views/base/widgets/refresh_widget.dart';
import 'package:iwacai_lottery_app/views/scheme/model/expert_scheme.dart';
import 'package:iwacai_lottery_app/views/subscribe/controller/focus_expert_controller.dart';

class FocusExpertView extends StatefulWidget {
  ///
  ///
  const FocusExpertView({Key? key}) : super(key: key);

  @override
  FocusExpertViewState createState() => FocusExpertViewState();
}

class FocusExpertViewState extends State<FocusExpertView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshWidget<FocusExpertController>(
      init: FocusExpertController(),
      emptyText: '暂无收藏专家情报',
      builder: (controller) => ListView.builder(
        itemCount: controller.datas.length,
        itemBuilder: (context, index) =>
            _ExpertView(scheme: controller.datas[index]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ExpertView extends StatefulWidget {
  ///
  final ExpertScheme scheme;

  const _ExpertView({
    Key? key,
    required this.scheme,
  }) : super(key: key);

  @override
  _ExpertViewState createState() => _ExpertViewState();
}

class _ExpertViewState extends State<_ExpertView> {
  ///
  ///
  late int _browse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/scheme/${widget.scheme.seqNo}');
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.15.w,
              color: Colors.black12,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpertView(widget.scheme),
            _buildSchemeView(widget.scheme),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertView(ExpertScheme scheme) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.w),
            child: CachedNetworkImage(
              imageUrl: scheme.avatar,
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 16,
                color: Colors.black12.withOpacity(0.05),
              ),
              placeholder: (context, uri) => Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.w,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheme.name,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  scheme.zhong,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemeView(ExpertScheme scheme) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.w),
            child: Text(
              scheme.title,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: scheme.events
                      .map((e) => Container(
                            margin: EdgeInsets.only(right: 8.w),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 1.w,
                              horizontal: 6.w,
                            ),
                            child: Text(
                              e,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 10.sp),
                            ),
                          ))
                      .toList(),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${scheme.delta.time}${scheme.delta.text}发布',
                      style: TextStyle(color: Colors.black38, fontSize: 12.sp),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Text(
                        '$_browse浏览',
                        style:
                            TextStyle(color: Colors.black38, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _browse = Tools.randLimit(widget.scheme.browse, 100);
  }
}
