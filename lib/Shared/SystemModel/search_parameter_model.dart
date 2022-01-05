import 'dart:convert';

import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/paginator.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';

class SearchParameterModel {
  List<SearchCondition> searchCondition;
  final String tableKey;
  final String urlPath;
  Paginator paginator;
  final String refTable;
  final String branchFilterMode;
  List<bool> isAscs;
  List<String> sortColumns;
  List<SortingModel> sortCondition;

  SearchParameterModel(
      {this.searchCondition,
      this.tableKey = '',
      this.urlPath = '',
      this.paginator,
      this.refTable = '',
      this.branchFilterMode = '',
      this.isAscs,
      this.sortColumns,
      this.sortCondition}); // SearchParameter() {
  //   this.searchCondition = [];
  //   this.tableKey = 'defual';
  //   this.urlPath = '';
  //   this.paginator = new Paginator();
  //   this.refTable = '';
  //   this.branchFilterMode = '';
  //   this.isAscs = [];
  //   this.sortColumns = [];
  // }
  SetSearchCondition(SearchCondition searchCondition) {
    this.searchCondition.add(searchCondition);
  }

  SetSortColumn(String sortType, String sortColumn) {
    if (sortType == SortType.ASC) {
      this.isAscs.add(true);
    } else {
      this.isAscs.add(false);
    }
    this.sortColumns.add(sortColumn);
  }

  // SetTableName(String tableName) {
  //   this.tableKey = tableName;
  // }
  //
  // SetPaginator(Paginator paginator) {
  //   this.paginator = paginator;
  // }

  Map<dynamic, dynamic> toJson() {
    // Map<String, dynamic> paginatorJson = paginationToJson();
    List<Map<dynamic, dynamic>> searchConditionJson = searchCondition != null
        ? searchCondition.map((e) => e.toJson()).toList()
        : null;
    List<Map<dynamic, dynamic>> sortList = sortCondition != null
        ? sortCondition.map((e) => e.toJson()).toList()
        : null;
    return {
      'searchCondition': searchConditionJson == null ? [] : searchConditionJson,
      'tableKey': tableKey == null ? '' : tableKey,
      'urlPath': urlPath == null ? '' : tableKey,
      'paginator': paginator == null ? '' : paginator.toJson(),
      'refTable': refTable == null ? '' : refTable,
      'branchFilterMode': branchFilterMode == null ? '' : branchFilterMode,
      'isAscs': isAscs == null ? [] : isAscs,
      'sortColumns': sortColumns == null ? [] : sortColumns,
      'sortCondition': sortList == null ? [] : sortList,
    };
  }

  Map<String, dynamic> searchConditiontoJson(SearchCondition condition) {
    return {
      'columnName': condition.columnName,
      'tableName': condition.tableName,
      'fieldName': condition.fieldName,
      'subColumnName': condition.subColumnName,
      'parameterName': condition.parameterName,
      'value': condition.value,
      'values': condition.values,
      'operator': condition.operator,
      'isParentKey': condition.isParentKey,
      'equalityOperator': condition.equalityOperator,
      'mockValues': condition.mockValues,
      'bracket': condition.bracket,
    };
  }

  List<Map<dynamic, dynamic>> searchConditionTojsonList() {
    List<Map<dynamic, dynamic>> searchConditionList = [];
    searchCondition.forEach((element) {
      Map<dynamic, dynamic> item = searchConditionToJson(element);
      searchConditionList.add(item);
    });
    return searchConditionList;
  }

  Map<dynamic, dynamic> searchConditionToJson(SearchCondition searchCondition) {
    return {
      'columnName': searchCondition.columnName,
      'tableName': searchCondition.tableName,
      'fieldName': searchCondition.fieldName,
      'subColumnName': searchCondition.subColumnName,
      'parameterName': searchCondition.parameterName,
      'value': searchCondition.value,
      'values': searchCondition.values,
      'operator': searchCondition.operator,
      'isParentKey': searchCondition.isParentKey,
      'equalityOperator': searchCondition.equalityOperator,
      'mockValues': searchCondition.mockValues,
      'bracket': searchCondition.bracket,
    };
  }

  Map<dynamic, dynamic> paginationToJson() {
    return {
      'page': paginator.page,
      'first': paginator.first,
      'rows': paginator.rows,
      'pageCount': paginator.pageCount,
      'totalRecord': paginator.totalRecord,
    };
  }
}
