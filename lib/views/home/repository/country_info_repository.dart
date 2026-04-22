import 'package:iwacai_lottery_app/utils/date_util.dart';
import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/country_info.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';
import 'package:iwacai_lottery_app/views/home/model/match_filter_model.dart';

///
///
class CountryInfoRepository {
  ///
  /// 查询指定区域的国家集合
  ///
  static Future<List<CountryInfo>> areaCountries(int area) {
    return HttpRequest().get('/ssport/share/country/$area').then((value) {
      List list = value.data;
      return list.map((e) => CountryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 主流国家过滤集合
  ///
  static Future<List<MatchFilter>> mainCountryFilters(DateTime date) {
    return HttpRequest().get(
      '/ssport/share/country/main',
      params: {'date': DateUtil.formatDate(date, format: "yyyy-MM-dd")},
    ).then((value) {
      return (value.data as List).map((e) => MatchFilter.fromJson(e)).toList();
    });
  }

  ///
  /// 查询指定区域的主要国家
  ///
  static Future<List<CountryInfo>> areaMainCountries(int area) {
    return HttpRequest().get('/ssport/share/country/main/$area').then((value) {
      List list = value.data;
      return list.map((e) => CountryInfo.fromJson(e)).toList();
    });
  }

  ///
  /// 分页查询国家
  ///
  static Future<PageResult<CountryInfo>> countryList(
      Map<String, dynamic> params) {
    return HttpRequest().get('/ssport/share/country/list', params: params).then(
          (value) => PageResult.fromJson(
            json: value.data,
            handle: (e) => CountryInfo.fromJson(e),
          ),
        );
  }
}
