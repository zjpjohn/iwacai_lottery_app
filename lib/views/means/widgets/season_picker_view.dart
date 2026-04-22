import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iwacai_lottery_app/views/base/model/league_season.dart';
import 'package:iwacai_lottery_app/widgets/empty_widget.dart';
import 'package:iwacai_lottery_app/widgets/modal_sheet_view.dart';

typedef OnSeasonSelected = Function(LeagueSeason season);

class SeasonPickerView extends StatefulWidget {
  ///选中的赛季
  final LeagueSeason? picked;

  ///
  final List<LeagueSeason> seasons;

  ///
  final OnSeasonSelected onSelected;

  ///
  final Function onClosed;

  const SeasonPickerView({
    super.key,
    this.picked,
    required this.seasons,
    required this.onSelected,
    required this.onClosed,
  });

  @override
  SeasonPickerViewState createState() => SeasonPickerViewState();
}

class SeasonPickerViewState extends State<SeasonPickerView> {
  ///当前选中的赛季
  LeagueSeason? _picked;

  @override
  Widget build(BuildContext context) {
    return ModalSheetView(
      title: '请选择赛季',
      height: Get.height * 0.45,
      onClose: widget.onClosed,
      child: widget.seasons.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(bottom: 12.w),
              child: Column(
                children: _buildSeasonList(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 64.w),
              child: EmptyView(
                size: 100.w,
                message: '暂无赛季信息',
              ),
            ),
    );
  }

  List<Widget> _buildSeasonList() {
    List<Widget> items = [];
    if (widget.seasons.isNotEmpty) {
      for (int i = 0; i < widget.seasons.length; i++) {
        items.add(
            _buildSeasonItem(widget.seasons[i], i < widget.seasons.length - 1));
      }
    }
    return items;
  }

  void pickedAndClose() {
    Get.back();
    widget.onClosed();
  }

  Widget _buildSeasonItem(LeagueSeason season, bool bordered) {
    return GestureDetector(
      onTap: () {
        if (hasPicked(season)) {
          return;
        }
        widget.onSelected(season);
        setState(() {
          _picked = season;
        });
        pickedAndClose();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.20.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              season.name + '赛季',
              style: TextStyle(
                fontSize: 15.sp,
                color: hasPicked(season) ? Colors.redAccent : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasPicked(season))
              Icon(
                const IconData(0xe66b, fontFamily: 'iconfont'),
                size: 17.sp,
                color: Colors.greenAccent,
              ),
          ],
        ),
      ),
    );
  }

  bool hasPicked(LeagueSeason season) {
    return _picked != null && _picked!.id == season.id;
  }

  @override
  void initState() {
    super.initState();
    _picked = widget.picked;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
