import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_service.dart';
import 'package:ice_fac_mobile/Shared/Base/base_dropdown_service.dart';
import 'package:ice_fac_mobile/Shared/Base/base_item_page.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum.dart';
import 'package:ice_fac_mobile/Shared/Constants/enum_constans.dart';
import 'package:ice_fac_mobile/Shared/Widget/appbar_item_widget.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_calendar.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_switch_widget.dart';
import 'package:ice_fac_mobile/Shared/Widget/cs_input_text_field.dart';
import 'package:ice_fac_mobile/Shared/Widget/dropdown.dart';
import 'package:ice_fac_mobile/ViewModel/bank_item_view.dart';
import 'package:ice_fac_mobile/ViewModel/bank_list_view.dart';

class BankItemPage extends BaseItemPage {
  String id;
  Function onCreated;
  BankItemPage({this.id, this.onCreated})
      : super(id: id, isUpdateMode: id != null);

  @override
  _BankItemPageState createState() => _BankItemPageState();
}

class _BankItemPageState extends State<BankItemPage> {
  BankItemView _model = BankItemView();
  TextEditingController controller = new TextEditingController();
  BankService bankService = new BankService();
  BaseDropdownService dropdownService = new BaseDropdownService();
  _BankItemPageState();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.isUpdateMode) {
      bankService.getBankItemById(widget.id).then((value) {
        setState(() {
          _model = value;
          widget.assignSystemEditField(_model);
          _model.assignControllerToModel();
        });
      });
    } else {
      bankService.initialCreateData().then((value) {
        setState(() {
          _model = value;
          widget.assignSystemCreateField(_model);
          _model.assignControllerToModel();
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppbarItem(
        title: 'BANK',
        actions: [
          IconButton(
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  if (widget.isUpdateMode) {
                    bankService.editBank(_model);
                  } else {
                    BankItemView modelCreated =
                        await bankService.createBank(_model);
                    widget.onCreated(BankListView.formItem(modelCreated));
                  }
                } else {
                  print('notValidate');
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Input(
                  controller: _model.bank_code_controler,
                  hintText: "Email",
                  mandatory: true,
                  inputType: TextFieldType.EMAIL,
                  suffixIcon: Icons.email,
                ),
                Input(
                  controller: _model.bank_name_controler,
                  hintText: 'Password',
                  mandatory: true,
                  inputType: TextFieldType.PASSWORD,
                  suffixIcon: Icons.visibility,
                ),
                Input(
                  controller: _model.bank_branch_controler,
                  hintText: "Text",
                  mandatory: false,
                  inputType: TextFieldType.TEXT,
                ),
                Input(
                  controller: _model.bank_number_controler,
                  hintText: "Number",
                  mandatory: true,
                  inputType: TextFieldType.NUMBER_8,
                ),
                Input(
                  controller: _model.bank_number_2_controler,
                  hintText: "Number 2",
                  mandatory: true,
                  inputType: TextFieldType.NUMBER_8_2,
                ),
                Input(
                  controller: _model.bank_phone_controler,
                  hintText: "Phone",
                  mandatory: true,
                  inputType: TextFieldType.PHONE,
                ),
                DropDown(
                    options: EnumOptions.carOptions,
                    lable: 'DropDown Item',
                    controller: _model.bank_dropdown_controler),
                CsCalendar(
                  controller: _model.bank_date_controler,
                ),
                CSSwitch(
                  // isSwitch: true,
                  controller: _model.bank_status_controler,
                )
                // CsDropdown(
                //   controller: _model.bank_dropdown_controler,
                //   hintText: "Dropdown",
                //   options: carOptions,
                //   onChange: (SelectedItem value) {
                //     print(value.label);
                //   },
                // ),
                // CsImageUpload(
                //   controller: controller,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
