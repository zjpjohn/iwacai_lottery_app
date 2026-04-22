import 'package:iwacai_lottery_app/utils/request.dart';
import 'package:iwacai_lottery_app/views/base/model/sport_browse.dart';
import 'package:iwacai_lottery_app/views/base/page_model.dart';

///
///
class SportBrowseRepository {
  ///
  ///
 static Future<PageResult<SportBrowseRecord>> browseList(
      {int page = 1, int limit = 10}) {
    return HttpRequest().get(
      '/ssport/app/browse/list',
      params: {'page': page, 'limit': limit},
    ).then(
      (value) => PageResult.fromJson(
        json: value.data,
        handle: (e) => SportBrowseRecord.fromJson(e),
      ),
    );
  }
}
