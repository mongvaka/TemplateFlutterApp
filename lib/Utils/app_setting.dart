import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/error_message.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/paginator.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Utils/constants.dart';

class Appsetting extends ChangeNotifier {
  Color _appColor = Colors.teal;
  Color get appColor => _appColor;
  String _language;
  String get language => _language;
  String _font;
  String get font => _font;
  double _fontSize;
  double get fontSize => _fontSize;
  double _fieldHeight = 75;
  double get fieldHeight => _fieldHeight;
  int _itemPerRows = 10;
  int get itemPerRows => _itemPerRows;
  SearchParameterModel _searchParameterModel =
      new SearchParameterModel(isAscs: [], sortColumns: []);
  SearchParameterModel get searchParameterModel => _searchParameterModel;
  void updateColor(int index) {
    _appColor = Constans.colors[index];
    notifyListeners();
  }

  void updateLanguages(int index) {
    _language = Constans.languages[index];
    notifyListeners();
  }

  void updateFont(int index) {
    _font = Constans.fonts[index];
    notifyListeners();
  }

  void updateFontSize(double index) {
    _fontSize = index;
    notifyListeners();
  }

  void updateSearchParameter(SearchParameterModel searchParameterModel) {
    _searchParameterModel = searchParameterModel;
  }

  void clearSearchParameter() {
    _searchParameterModel = new SearchParameterModel(
        searchCondition: [], isAscs: [], sortColumns: []);
  }

  void addSortingKey(String columnName, bool isAsc, bool isActive) {
    // print(columnName);
    // print(isAsc);
    // if (_searchParameterModel == null) {
    //   _searchParameterModel =
    //       new SearchParameterModel();
    // }

    if (_searchParameterModel.sortColumns == null) {
      _searchParameterModel.sortColumns = [];
    }
    if (_searchParameterModel.isAscs == null) {
      _searchParameterModel.isAscs = [];
    }
    int indexColumn = checkSortingColumnIsAccess(columnName);
    if (indexColumn == -1) {
      _searchParameterModel.sortColumns.add(columnName);
      _searchParameterModel.isAscs.add(isAsc);
    } else {
      if (isActive) {
        _searchParameterModel.sortColumns[indexColumn] = columnName;
        _searchParameterModel.isAscs[indexColumn] = isAsc;
      } else {
        _searchParameterModel.sortColumns.removeAt(indexColumn);
        _searchParameterModel.isAscs.removeAt(indexColumn);
      }
    }
  }

  void addCondition(SearchCondition newSearchCondition) {
    bool isColumnIsAccess = checkCondition(newSearchCondition);
    print('widget.item.value : ${newSearchCondition.value}');
    if (isColumnIsAccess) {
      updateCondition(newSearchCondition);
    } else {
      addNewCondition(newSearchCondition);
    }
    //_searchParameterModel.searchCondition.add(newSearchCondition);
  }

  bool checkCondition(SearchCondition newCondition) {
    try {
      bool columnIsAccess = false;
      if (_searchParameterModel == null) {
        setDefaultSearchCondition();
      }
      for (var i = 0; i < _searchParameterModel.searchCondition.length; i++) {
        SearchCondition parentCondition =
            _searchParameterModel.searchCondition[i];
        if (parentCondition.columnName == newCondition.columnName) {
          columnIsAccess = true;
        }
      }
      return columnIsAccess;
    } catch (e) {
      print(e);
    }
  }

  void addNewCondition(SearchCondition newSearchCondition) {
    try {
      if (_searchParameterModel == null) {
        setDefaultSearchCondition();
      }
      _searchParameterModel.searchCondition.add(newSearchCondition);
    } catch (e) {
      print(e);
    }
  }

  void setDefaultSearchCondition() {
    _searchParameterModel = new SearchParameterModel(
        isAscs: [], searchCondition: [], sortColumns: []);
  }

  void updateCondition(SearchCondition newSearchCondition) {
    try {
      print('newSearchCondition : ${newSearchCondition.conditionType}');
      if (_searchParameterModel == null) {
        setDefaultSearchCondition();
      }
      int conditionType = newSearchCondition.conditionType;
      conditionType == ConditionType.TIME_RANGE
          ? updateConditionTimeRange(newSearchCondition)
          : conditionType == ConditionType.DATE_RANGE
              ? updateConditionDateRange(newSearchCondition)
              : conditionType == ConditionType.ENUM
                  ? updateConditionEnum(newSearchCondition)
                  : conditionType == ConditionType.LIST
                      ? updateConditionList(newSearchCondition)
                      : conditionType == ConditionType.TEXT
                          ? updateConditionText(newSearchCondition)
                          : conditionType == ConditionType.NUMBER
                              ? updateConditionNumber(newSearchCondition)
                              : conditionType == ConditionType.BOOL
                                  ? updateConditionBool(newSearchCondition)
                                  : defaultMethod();
    } catch (e) {
      print(e);
    }
  }

  updateConditionDateRange(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.isActive) {
        _searchParameterModel.searchCondition[index] = newSearchCondition;
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  updateConditionTimeRange(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.isActive) {
        _searchParameterModel.searchCondition[index] = newSearchCondition;
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  defaultMethod() {}

  updateConditionEnum(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.isActive) {
        bool isValueIsAccess = checkValueIsAccess(newSearchCondition.value,
            _searchParameterModel.searchCondition[index].values);
        if (isValueIsAccess) {
          for (var i = 0;
              i < _searchParameterModel.searchCondition[index].values.length;
              i++) {
            if (_searchParameterModel.searchCondition[index].values[i] ==
                newSearchCondition.value) {
              if (newSearchCondition.isActive) {
                _searchParameterModel.searchCondition[index].values[i] =
                    newSearchCondition.value;
              } else {
                _searchParameterModel.searchCondition[index].values.removeAt(i);
              }
            }
          }
        } else {
          _searchParameterModel.searchCondition[index].values
              .add(newSearchCondition.value);
        }
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  updateConditionList(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.isActive) {
        bool isValueIsAccess = checkValueIsAccess(newSearchCondition.value,
            _searchParameterModel.searchCondition[index].values);
        if (isValueIsAccess) {
          for (var i = 0;
              i < _searchParameterModel.searchCondition[index].values.length;
              i++) {
            if (_searchParameterModel.searchCondition[index].values[i] ==
                newSearchCondition.value) {
              if (newSearchCondition.isActive) {
                _searchParameterModel.searchCondition[index].values[i] =
                    newSearchCondition.value;
              } else {
                _searchParameterModel.searchCondition[index].values.removeAt(i);
              }
            }
          }
        } else {
          _searchParameterModel.searchCondition[index].values
              .add(newSearchCondition.value);
        }
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  updateConditionText(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.value.length > 0) {
        _searchParameterModel.searchCondition[index] = newSearchCondition;
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  updateConditionNumber(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.value.length > 0) {
        _searchParameterModel.searchCondition[index] = newSearchCondition;
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  updateConditionBool(SearchCondition newSearchCondition) {
    try {
      int index = getIndexFromNumber(newSearchCondition);
      if (newSearchCondition.isActive) {
        _searchParameterModel.searchCondition[index] = newSearchCondition;
      } else {
        _searchParameterModel.searchCondition.removeAt(index);
      }
    } catch (e) {
      print(e);
    }
  }

  int getIndexFromNumber(SearchCondition newSearchCondition) {
    int index = 0;
    for (var i = 0; i < _searchParameterModel.searchCondition.length; i++) {
      SearchCondition parentCondition =
          _searchParameterModel.searchCondition[i];
      if (parentCondition.columnName == newSearchCondition.columnName) {
        index = i;
      }
    }
    return index;
  }

  checkValueIsAccess(String value, List<String> values) {
    try {
      print('value : $value');
      bool isValueAccess = false;
      for (var i = 0; i < values.length; i++) {
        print('values : ${values[i]}');
        if (value == values[i]) {
          isValueAccess = true;
        }
      }
      return isValueAccess;
    } catch (e) {
      print(e);
    }
  }

  int checkSortingColumnIsAccess(String columnName) {
    int indexColumn = -1;
    if (_searchParameterModel.sortColumns == null) {
      return indexColumn;
    }
    for (var i = 0; i < _searchParameterModel.sortColumns.length; i++) {
      if (_searchParameterModel.sortColumns[i] == columnName) {
        indexColumn = i;
      }
    }
    return indexColumn;
  }

  setPaginator(int number) {
    _searchParameterModel.paginator = new Paginator(
        page: number,
        first: 0,
        rows: _itemPerRows,
        totalRecord: 0,
        pageCount: 0);
  }
}
