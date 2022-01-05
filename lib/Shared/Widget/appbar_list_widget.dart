import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/search_condition.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';
import 'package:ice_fac_mobile/Shared/Widget/search_parameter.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class AppbarList extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Function onSearch;
  final Function onCreate;
  final List<SearchCondition> searchConditions;
  final List<SortingModel> sortingList;
  final bool showBackButton;

  AppbarList(
      {this.title,
      this.onSearch,
      this.onCreate,
      this.searchConditions,
      this.sortingList,
      this.showBackButton});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.watch<Appsetting>().appColor,
      title: Text(title.tr()),
      centerTitle: true,
      leading: showBackButton ? BackButton() : SizedBox(),
      actions: [
        IconButton(
            onPressed: () {
              // context.read<Appsetting>().clearSearchParameter();
              showBottomSheet(
                  context: context,
                  // pageBuilder: (BuildContext context, Animation first,
                  //     Animation second) {
                  //   return Center(
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width - 10,
                  //       height: MediaQuery.of(context).size.height - 80,
                  //       padding: EdgeInsets.all(20.0),
                  //       color: Colors.white,
                  //       child: SearchParameter(),
                  //     ),
                  //   );
                  // }
                  builder: (context) => SearchParameter(
                        searchConditions: searchConditions,
                        onSearch: onSearch,
                        sortingList: sortingList,
                        // onSearch: onSearch,
                      ));
            },
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              onCreate();
            },
            icon: Icon(Icons.add))
      ],
    );
  }
  // @override
  // Widget build(BuildContext context) => AppBar(
  //       title: Text(title.tr()),
  //       centerTitle: true,
  //       leading: BackButton(),
  //       actions:,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
  //       flexibleSpace: Container(
  //         decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //                 colors: [Colors.purple, Colors.red],
  //                 begin: Alignment.bottomRight,
  //                 end: Alignment.topLeft)),
  //       ),
  //     );
}
