import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_card.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_item_page.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_service.dart';
import 'package:ice_fac_mobile/Shared/Base/base_dropdown_service.dart';
import 'package:ice_fac_mobile/Shared/Base/keywords_model.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/Function/initial_search_parameter.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/paginator.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_parameter_model.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';
import 'package:ice_fac_mobile/Shared/Widget/appbar_list_widget.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_app_bar.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_card.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_float_action.dart';
import 'package:ice_fac_mobile/Shared/Widget/delete_confirmation.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:ice_fac_mobile/ViewModel/bank_list_view.dart';
import 'package:ice_fac_mobile/ViewModel/search_result.dart';
import 'package:provider/src/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BankListPage extends StatefulWidget {
  const BankListPage({Key key}) : super(key: key);

  @override
  _BankListPageState createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  List<SearchCondition> searchConditionList;
  List<SortingModel> sortingModelList;
  int currentPage = 0;
  int totalPage;
  String baseModule = 'Bank';
  BankService bankService;
  BaseDropdownService baseDropdownService = new BaseDropdownService();
  List<BankListView> dataList = [];
  @override
  // TODO: implement context
  BuildContext get context => super.context;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  Future<bool> getDataList({bool isRefresh = false}) async {
    bankService = new BankService();
    if (isRefresh) {
      currentPage = 0;
    }
    setPaginator(currentPage);
    SearchResult searchResult = await bankService
        .getBankList(context.read<Appsetting>().searchParameterModel);

    print('data: $searchResult');
    currentPage++;

    if (searchResult != null) {
      if (isRefresh) {
        dataList = BankListView.fromArray(searchResult.results);
      } else {
        dataList.addAll(BankListView.fromArray(searchResult.results));
      }
      totalPage = searchResult.paginator.pageCount;
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortingModelList = getSortingList();
    searchConditionList = getSearchConditions();
    initialSearchParameter();
    // getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarList(
        title: 'BankList',
        showBackButton: false,
        onSearch: () {
          getDataList(isRefresh: true);
        },
        onCreate: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BankItemPage(onCreated: (BankListView item) {
                  setState(() {
                    dataList.add(item);
                  });
                }),
              ));
        },
        searchConditions: searchConditionList,
        sortingList: sortingModelList,
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getDataList(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getDataList(isRefresh: false);
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              BankListView model = dataList[index];
              return CsCard(
                model: model,
                headerText: model.bank_name,
                imageLeader:
                    'https://cars.usnews.com/static/images/Auto/custom/14737/2022_Acura_ILX_1.jpg',
                service: bankService,
                titleText: dataList[index].bank_branch,
                keywords: [
                  new CsKeywordsModel(text: model.bank_code),
                  new CsKeywordsModel(text: model.bank_uuid)
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(
                  thickness: 10,
                ),
            itemCount: dataList.length),
      ),
    );
  }

  List<SearchCondition> getSearchConditions() {
    return [
      // new SearchCondition(
      //     fieldName: 'bank_uuid',
      //     tableName: 'bank_table',
      //     columnName: 'is_active',
      //     value: 'true',
      //     isActive: false,
      //     conditionType: ConditionType.BOOL),
      new SearchCondition(
          tableName: 'bank_table',
          fieldName: 'company_uuid',
          columnName: 'company_name',
          value: 'TEST_DATA',
          isActive: false,
          conditionType: ConditionType.TEXT),
      new SearchCondition(
          tableName: 'bank_table',
          fieldName: 'person',
          columnName: 'PERSON_NAME',
          isActive: false,
          values: ['a', 'b', 'c'],
          conditionType: ConditionType.LIST,
          searchParameter: new SearchParameterModel(
              searchCondition: [new SearchCondition()],
              tableKey: '',
              urlPath: '',
              paginator: new Paginator(),
              refTable: '',
              branchFilterMode: '',
              isAscs: [],
              sortColumns: []),
          dropdownUrl: '/Bank/getBankDropdown'),
      new SearchCondition(
          fieldName: 'remark',
          tableName: 'bank_table',
          columnName: 'REMARK',
          isActive: false,
          conditionType: ConditionType.DATE_RANGE),
      new SearchCondition(
          fieldName: 'provider',
          tableName: 'bank_table',
          columnName: 'PROVIDER',
          isActive: false,
          values: ['a', 'b', 'c'],
          searchParameter: new SearchParameterModel(
              searchCondition: [new SearchCondition()],
              isAscs: [],
              sortColumns: []),
          conditionType: ConditionType.TIME_RANGE,
          dropdownUrl: '/Bank/GetCarDropdown'),
      new SearchCondition(
          fieldName: 'inter',
          columnName: 'INTER_GRADE',
          isActive: false,
          conditionType: ConditionType.NUMBER)
    ];
  }

  List<SortingModel> getSortingList() {
    return [
      new SortingModel(
          isAsc: false,
          value: 'employeeName',
          label: 'EMPLOYEE_NAME',
          tableName: 'bank_table',
          columnName: 'bank_name',
          isActive: true),
      new SortingModel(
          isAsc: false,
          value: 'companyName',
          tableName: 'bank_table',
          label: 'COMPANY_NAME',
          columnName: 'company_name',
          isActive: false)
    ];
  }

  void setPaginator(int pageNumber) {
    context.read<Appsetting>().setPaginator(pageNumber);
  }

  void initialSearchParameter() {
    context.read<Appsetting>().updateSearchParameter(
        InitialSearchParameter.getInitialSearchParameter(
            searchConditionList, sortingModelList));
  }
}
