import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/request_controller.dart';
import 'package:iwacai_lottery_app/views/home/repository/country_info_repository.dart';

class CountryListController extends BaseRequestController {
  ///
  CountryListController({required this.area});

  late int area;
  late List<CountryInfo> countries = [];

  Map<String, List<CountryInfo>> groupCountries() {
    return SplayTreeMap.from(
      groupBy(countries, (CountryInfo country) => country.initial),
    );
  }

  @override
  Future<void> request() async {
    showLoading();
    CountryInfoRepository.areaCountries(area).then((value) {
      countries
        ..clear()
        ..addAll(value);
      Future.delayed(const Duration(milliseconds: 250), () {
        showSuccess(countries);
      });
    }).catchError((error) {
      showError(error);
    });
  }
}
