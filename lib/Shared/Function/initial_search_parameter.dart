import 'package:ice_fac_mobile/Shared/SystemModel/paginator.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';

class InitialSearchParameter {
  static getInitialSearchParameter(
      List<SearchCondition> conditionList, List<SortingModel> sortingList) {
    List<SearchCondition> newConditionList = [];
    List<SortingModel> newSortingList = [];
    List<String> columnSortingName = [];
    List<bool> columnSortingType = [];
    for (var i = 0; i < conditionList.length; i++) {
      if (conditionList[i].value != null && conditionList[i].isActive) {
        newConditionList.add(conditionList[i]);
      }
      // if (conditionList[i].values != null) {
      //   newConditionList.add(conditionList[i]);
      // }
    }
    for (var i = 0; i < sortingList.length; i++) {
      if (sortingList[i].isActive) {
        newSortingList.add(sortingList[i]);
        columnSortingType.add(sortingList[i].isAsc);
        columnSortingName.add(sortingList[i].columnName);
      }
    }
    print('newConditionList : ${newConditionList.toString()}');
    return new SearchParameterModel(
      sortColumns: columnSortingName,
      isAscs: columnSortingType,
      sortCondition: newSortingList,
      searchCondition: newConditionList,
      paginator: new Paginator(rows: 10, page: 0),
    );
  }
}
