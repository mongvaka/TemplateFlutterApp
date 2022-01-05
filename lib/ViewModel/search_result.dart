import 'package:ice_fac_mobile/Shared/SystemModel/paginator.dart';

class SearchResult {
  final Paginator paginator;
  final dynamic results;

  SearchResult({
    this.paginator,
    this.results,
  });

  factory SearchResult.formJson(Map<dynamic, dynamic> json) {
    return SearchResult(
      paginator: Paginator.fromJson(json['paginator']),
      results: json['results'],
    );
  }
}
