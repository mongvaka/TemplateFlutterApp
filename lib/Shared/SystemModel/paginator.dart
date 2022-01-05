class Paginator {
  int page;
  int first;
  int rows;
  int pageCount;
  int totalRecord;

  Paginator(
      {this.page, this.first, this.rows, this.pageCount, this.totalRecord});
  factory Paginator.fromJson(Map<dynamic, dynamic> json) {
    return Paginator(
        page: json['page'],
        first: json['first'],
        rows: json['rows'],
        pageCount: json['pageCount'],
        totalRecord: json['totalRecord']);
  }
  Map toJson() {
    return {
      'page': page,
      'first': first,
      'rows': rows,
      'pageCount': pageCount,
      'totalRecord': totalRecord
    };
  }
}
