
import 'package:flutter/material.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_item_page.dart';
import 'package:ice_fac_mobile/Page/Bank/bank_service.dart';
import 'package:ice_fac_mobile/Shared/Widget/delete_confirmation.dart';
import 'package:ice_fac_mobile/ViewModel/bank_list_view.dart';

class BankCard extends StatelessWidget {
  BankListView model;
  BankService service;

  BankCard({this.model, this.service});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        height: MediaQuery.of(context).size.height * 0.28,
        child: Container(
          // color: Colors.white,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          // elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('BANK_NAME'),
                        Text(' : '),
                        Text(model.bank_name)
                      ],
                    ),
                    Row(
                      children: [
                        Text('BANK_CODE'),
                        Text(' : '),
                        Text(model.bank_code)
                      ],
                    ),
                    Row(
                      children: [
                        Text('BANK_BRANCH'),
                        Text(' : '),
                        Text(model.bank_branch)
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('You want to delete this'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    BankListView result = await service
                                        .deleteBank(model.bank_uuid);
                                    print('result');
                                    print(result);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'DELETE',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankItemPage(
                                      id: model.bank_uuid,
                                    )),
                          );
                        },
                        child: Text(
                          'VIEW',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      );
}
