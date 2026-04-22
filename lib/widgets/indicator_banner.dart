import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef BannerIndexChange = void Function(int index);

class IndicatorBanner extends StatefulWidget {
  ///
  ///
  const IndicatorBanner({
    Key? key,
    this.height = 160,
    this.inner = 5.0,
    this.outer = 8.0,
    this.autoPlay=false,
    this.onChange,
    required this.children,
    this.backGroundColor = Colors.white,
    this.interval = 1.5,
    this.viewportFraction = 1.0,
  }) : super(key: key);

  final bool autoPlay;
  final double height;
  final double viewportFraction;
  final List<Widget> children;
  final Color backGroundColor;
  final double interval;
  final double outer;
  final double inner;
  final BannerIndexChange? onChange;

  @override
  IndicatorBannerState createState() => IndicatorBannerState();
}

class IndicatorBannerState extends State<IndicatorBanner> {
  ///
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.children.length,
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: widget.viewportFraction,
            autoPlay: widget.autoPlay,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
              if (widget.onChange != null) {
                widget.onChange!(index);
              }
            },
          ),
          itemBuilder: (context, index, realIdx) {
            return widget.children[index];
          },
        ),
        if (widget.children.length > 1)
          Container(
            padding: EdgeInsets.only(top: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.children.asMap().entries.map((entry) {
                return _indicator(entry.key);
              }).toList(),
            ),
          )
      ],
    );
  }

  Widget _indicator(int index) {
    return Container(
      width: widget.outer,
      height: widget.outer,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: widget.interval),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.outer),
        color: _currentIndex != index
            ? Colors.transparent
            : const Color(0xFFF6F6F6),
      ),
      child: Container(
        width: widget.inner,
        height: widget.inner,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.inner),
          color:
              _currentIndex == index ? Colors.white : const Color(0x60F6F6F6),
        ),
      ),
    );
  }
}
