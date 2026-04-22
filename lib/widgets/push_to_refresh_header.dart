import 'dart:math';
import 'dart:ui' as ui show Image;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwacai_lottery_app/resources/resources.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

double get maxDragOffset => 100;
double hideHeight = maxDragOffset / 2.5;
double refreshHeight = maxDragOffset / 1.5;

class PullToRefreshHeader extends StatelessWidget {
  const PullToRefreshHeader(
    this.info, {
    super.key,
    this.color,
  });

  final PullToRefreshScrollNotificationInfo? info;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final PullToRefreshScrollNotificationInfo? _info = info;
    if (_info == null) {
      return Container();
    }
    String text = '';
    if (_info.mode == PullToRefreshIndicatorMode.armed) {
      text = '释放刷新';
    } else if (_info.mode == PullToRefreshIndicatorMode.refresh ||
        _info.mode == PullToRefreshIndicatorMode.snap) {
      text = '正在加载';
    } else if (_info.mode == PullToRefreshIndicatorMode.done) {
      text = '加载成功';
    } else if (_info.mode == PullToRefreshIndicatorMode.drag) {
      text = '下拉刷新';
    } else if (_info.mode == PullToRefreshIndicatorMode.canceled) {
      text = '取消刷新';
    }

    final double dragOffset = info?.dragOffset ?? 0.0;

    return Container(
      height: dragOffset,
      color: color ?? Colors.transparent,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const RefreshLottie(),
            Text(
              text,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RefreshLottie extends StatelessWidget {
  ///
  const RefreshLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(R.loadingRocket, width: 72.w, height: 72.w);
  }
}

class RefreshImage extends StatelessWidget {
  const RefreshImage(this.top, {super.key});

  final double top;

  @override
  Widget build(BuildContext context) {
    const double imageSize = 30;
    return ExtendedImage.asset(
      R.avatar,
      width: imageSize,
      height: imageSize,
      afterPaintImage: (Canvas canvas, Rect rect, ui.Image image, Paint paint) {
        final double imageHeight = image.height.toDouble();
        final double imageWidth = image.width.toDouble();
        final Size size = rect.size;
        final double y =
            (1 - min(top / (refreshHeight - hideHeight), 1)) * imageHeight;

        canvas.drawImageRect(
          image,
          Rect.fromLTWH(0.0, y, imageWidth, imageHeight - y),
          Rect.fromLTWH(rect.left, rect.top + y / imageHeight * size.height,
              size.width, (imageHeight - y) / imageHeight * size.height),
          Paint()
            ..colorFilter =
                const ColorFilter.mode(Color(0xFFea5504), BlendMode.srcIn)
            ..isAntiAlias = false
            ..filterQuality = FilterQuality.low,
        );

        //canvas.restore();
      },
    );
  }
}
