import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ice_fac_mobile/Shared/Base/base_dropdown_service.dart';
import 'package:ice_fac_mobile/Shared/Base/base_service.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_bool_selected.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_date_selected.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_item_selected.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_list_selected.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_sorting_item.dart';
import 'package:ice_fac_mobile/Shared/Widget/build_time_range_selected.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_button.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_calendar.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_text_feild.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:ice_fac_mobile/Utils/constants.dart';
import 'package:provider/src/provider.dart';

import 'build_dropdown_selected.dart';
import 'build_textfield_selected.dart';

class SearchParameter extends StatelessWidget {
  final List<SearchCondition> searchConditions;
  final List<SortingModel> sortingList;
  final Function onSearch;
  SearchParameter({this.searchConditions, this.onSearch, this.sortingList});
  final TextEditingController controller = new TextEditingController();

  // List<bool> isAsc = [true, true, true, true];
  // List<String> sortColumn = ['column1', 'column2', 'column3', 'column4'];
  double parentWidth;
  @override
  Widget build(BuildContext context) {
    parentWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: CsButton(
                text: 'ACCEPT',
                onPress: () {
                  // inspect(context.read<Appsetting>().searchParameterModel);
                  // print(json
                  //     .encode(context.read<Appsetting>().searchParameterModel));
                  //
                  // for (var i = 0;
                  //     i <
                  //         context
                  //             .read<Appsetting>()
                  //             .searchParameterModel
                  //             .searchCondition
                  //             .length;
                  //     i++) {
                  //   SearchCondition item = context
                  //       .read<Appsetting>()
                  //       .searchParameterModel
                  //       .searchCondition[i];
                  //   print(item.value);
                  Navigator.pop(context);
                  onSearch();
                },
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'SORTING',
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(sortingList.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // context.read<Appsetting>().updateColor(index);
                      },
                      child: BuildSortingItem(
                        item: sortingList[index],
                      ),
                    );
                  }),
                ),
              ),
            ),
            Divider(),
            Container(
              child: Wrap(
                children:
                    List<Widget>.generate(searchConditions.length, (index) {
                  return buildSocketSearchCondition(index);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSocketSearchCondition(int index) {
    final int conditionType = searchConditions[index].conditionType;
    return Container(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text(searchConditions[index].columnName)),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: conditionType == ConditionType.BOOL
                  ? boolSelector(searchConditions[index].columnName)
                  : conditionType == ConditionType.DATE_RANGE
                      ? dateRangeSelected(searchConditions[index].columnName)
                      : conditionType == ConditionType.ENUM
                          ? listSelected(searchConditions[index].dropdownUrl,
                              searchConditions[index].searchParameter)
                          : conditionType == ConditionType.LIST
                              ? listSelected(
                                  searchConditions[index].dropdownUrl,
                                  searchConditions[index].searchParameter)
                              : conditionType == ConditionType.NUMBER
                                  ? numberSelected(
                                      searchConditions[index].columnName)
                                  : conditionType == ConditionType.TEXT
                                      ? textInputSelected(
                                          searchConditions[index].columnName)
                                      : conditionType ==
                                              ConditionType.TIME_RANGE
                                          ? timeRangeSelected(
                                              searchConditions[index]
                                                  .columnName)
                                          : defaultSelected()),
          Divider(),
        ],
      ),
    );
  }

  Widget boolSelector(String columnName) {
    return BuildBoolSelected(
      controller: new TextEditingController(),
      columnName: columnName,
    );
  }

  listSelected(String dropdownUrl, SearchParameterModel searchParameterModel) {
    return Container(
      child: BuildListSelected(
        dropdownUrl: dropdownUrl,
        searchParameterModel: searchParameterModel,
      ),
      // child: BuildDropDownSelected(
      //   dropdownUrl: dropdownUrl,
      //   searchParameterModel: searchParameterModel,
      // ),
    );
  }

  dateRangeSelected(String columnName) {
    return Container(
        width: parentWidth,
        child: BuildDateRangeSelected(
          columnName: columnName,
        ));
  }

  numberSelected(String columnName) {
    return Container(
      width: parentWidth,
      child: TextFieldSelected(
        inputType: TextFieldType.NUMBER_8_2,
        conditionType: ConditionType.NUMBER,
      ),
    );
  }

  textInputSelected(String columnName) {
    return Container(
      width: parentWidth,
      child: TextFieldSelected(
        inputType: TextFieldType.TEXT,
        conditionType: ConditionType.TEXT,
      ),
    );
  }

  defaultSelected() {
    return Container(
      width: parentWidth,
      child: Text('default'),
    );
  }

  timeRangeSelected(String columnName) {
    return Container(
      child: BuildTimeRangeSelected(
        columnName: columnName,
      ),
    );
  }
}
