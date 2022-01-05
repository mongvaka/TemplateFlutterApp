import 'package:ice_fac_mobile/Shared/SystemModel/selected_item.dart';

class EnumOptions {
  List<SelectedItem> static = carOptions;

  static var carOptions = [
    SelectedItem(label: 'thisValue1', value: '0', rowData: '0'),
    SelectedItem(label: 'thisValue2', value: '1', rowData: '1'),
    SelectedItem(label: 'thisValue3', value: '2', rowData: '2'),
    SelectedItem(label: 'thisValue4', value: '3', rowData: '3'),
    SelectedItem(label: 'thisValue5', value: '4', rowData: '4')
  ];
}

// ignore: non_constant_identifier_names
// EnumOptions() {
//   var carOptions = [
//     'thisValue1',
//     'thisValue2',
//     'thisValue3',
//   ];
//   return carOptions;
// }
