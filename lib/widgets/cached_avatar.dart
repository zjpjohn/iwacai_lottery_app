import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedAvatar extends StatelessWidget {
  ///
  ///
  const CachedAvatar({
    Key? key,
    required this.width,
    required this.url,
    this.height,
    this.radius = 0,
    this.opacity = 1.0,
    this.progress = false,
    this.fit = BoxFit.cover,
    this.error = '',
    this.color = const Color(0xFFF8F8F8),
    this.errorImage,
  }) : super(key: key);
  final double width;
  final double? height;
  final Color color;
  final String url;
  final double radius;
  final double opacity;
  final BoxFit? fit;
  final bool progress;
  final String error;
  final String? errorImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      imageBuilder: (context, provider) {
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: provider,
              opacity: opacity,
              fit: fit,
            ),
          ),
        );
      },
      errorWidget: (context, url, _) {
        if (errorImage != null) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(errorImage!),
              ),
            ),
          );
        }
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Text(
            error,
            style: TextStyle(
              color: const Color(0xFFF2F2F2),
              fontSize: width * 0.3,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: progress
              ? SizedBox(
                  width: width / 3 >= 20.w ? 20.w : width / 3,
                  height: width / 3 >= 20.w ? 20.w : width / 3,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.grey.withOpacity(0.1),
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
