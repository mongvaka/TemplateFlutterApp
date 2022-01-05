import 'dart:convert';

import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';

class SearchCondition {
  final String columnName;
  final String tableName;
  final String fieldName;
  final String subColumnName;
  final String parameterName;
  final String value;
  final List<String> values;
  final String operator;
  final bool isParentKey;
  final String equalityOperator;
  final List<String> mockValues;
  final int bracket;
  bool isActive;
  final int conditionType;
  final String dropdownUrl;
  final SearchParameterModel searchParameter;
  final dynamic function;
  // final Future<List<SelectedItem>> futureList;
  List<SelectedItem> selectedItems = [];
  SearchCondition(
      {this.columnName,
      this.tableName,
      this.fieldName,
      this.subColumnName,
      this.parameterName,
      this.value,
      this.values,
      this.operator,
      this.isParentKey,
      this.equalityOperator,
      this.mockValues,
      this.bracket,
      this.isActive,
      this.conditionType,
      this.dropdownUrl,
      this.searchParameter,
      this.selectedItems,
      this.function});
  Map toJson() {
    return {
      'columnName': columnName,
      'tableName': tableName,
      'fieldName': fieldName,
      'subColumnName': subColumnName,
      'parameterName': parameterName,
      'value': value,
      'values': values,
      'operator': operator == null ? '=' : operator,
      'isParentKey': isParentKey,
      'equalityOperator': equalityOperator,
      'mockValues': mockValues,
      'bracket': bracket,
      'conditionType': conditionType
    };
  }
}
