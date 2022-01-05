import 'package:flutter/material.dart';

class BaseItemPage extends StatefulWidget {
  String id;
  String fuu;
  bool isUpdateMode;

  BaseItemPage({this.id, this.fuu, this.isUpdateMode});

  @override
  State<StatefulWidget> createState() {}

  void assignSystemEditField(dynamic model) {
    model.update_date = new DateTime.now().toString();
    model.update_by = 'admin';
  }

  void assignSystemCreateField(dynamic model) {
    model.create_date = new DateTime.now().toString();
    model.create_by = 'admin';
  }
}
