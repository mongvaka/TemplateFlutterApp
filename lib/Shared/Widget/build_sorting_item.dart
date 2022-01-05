import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Shared/SystemModel/sorting_model.dart';
import 'package:ice_fac_mobile/Utils/app_setting.dart';
import 'package:provider/src/provider.dart';

class BuildSortingItem extends StatefulWidget {
  final SortingModel item;

  BuildSortingItem({this.item});

  @override
  _BuildSortingItemState createState() => _BuildSortingItemState();
}

class _BuildSortingItemState extends State<BuildSortingItem> {
  @override
  Widget build(BuildContext context) {
    // BuildContext buildContext = context;
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: ActionChip(
        padding: EdgeInsets.all(2),
        avatar: !widget.item.isActive
            ? SizedBox()
            : widget.item.isAsc
                ? Icon(
                    Icons.arrow_downward,
                    color: Colors.blue,
                  )
                : Icon(Icons.arrow_upward, color: Colors.blue),
        labelPadding: EdgeInsets.only(left: 4, right: 4),
        shape: StadiumBorder(
            side: BorderSide(
                color: widget.item.isActive ? Colors.blue : Colors.grey)),
        label: Text(
          widget.item.label,
          style: TextStyle(
              color: widget.item.isActive ? Colors.blue : Colors.grey),
        ),
        labelStyle: TextStyle(color: Colors.grey),
        backgroundColor: Colors.white,
        onPressed: () {
          if (widget.item.isActive) {
            if (widget.item.isAsc) {
              widget.item.isAsc = false;
            } else {
              widget.item.isActive = false;
            }
          } else {
            widget.item.isActive = true;
            widget.item.isAsc = true;
          }
          context.read<Appsetting>().addSortingKey(
              widget.item.columnName, widget.item.isAsc, widget.item.isActive);
          setState(() {});
        },
      ),
    );
  }
}
