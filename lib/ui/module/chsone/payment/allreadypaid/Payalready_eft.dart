import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/pay_already_eft_presontor.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/payment_bank_model.dart';

class PayAlreadyEFTPage extends StatefulWidget {
  var onNext;

  PayAlreadyEFTPage({var onNext}) {
    this.onNext = onNext;
  }

  @override
  PayAlreadyEFTPageState createState() => new PayAlreadyEFTPageState(onNext);
}

class PayAlreadyEFTPageState extends State<PayAlreadyEFTPage>
    implements IPaymentBankModel {
  PayAlreadyEFTPageStatePresentor payAlreadyChequePageState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    payAlreadyChequePageState = new PayAlreadyEFTPageStatePresentor(this);
    payAlreadyChequePageState.getBankAccounts();
  }

  var onNext;

  /*payAlreadyChequePageState = new PayAlreadyChequePagePresentor(this);
    payAlreadyChequePageState.getBankAccounts();*/
  TextEditingController dateController = new TextEditingController();

  String dateError;
  String transactionNumberError;

  TextEditingController transactionNumberController =
  new TextEditingController();

  PayAlreadyEFTPageState(onNext) {
    this.onNext = onNext;
  }

  List _bank = []; // Option 2
  String _selectedBank;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            alignment: Alignment.center,
            child: Text(
              'add EFT details'.toLowerCase(),
              style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h5size,
                color: FsColor.darkgrey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: TextField(
              controller: transactionNumberController,
              decoration: InputDecoration(
                  errorText: transactionNumberError,
                  labelText: "Enter transaction Number".toLowerCase(),
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: FsColor.basicprimary))
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              subtitle: DateTimeField(
                controller: dateController,
                showCursor: false,
                style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                ),
                format: DateFormat("dd/MM/yyyy"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now());
                },
                decoration: InputDecoration(
                    errorText: dateError,
                    labelText: "Enter Transaction Date".toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(
                'Deposit In Bank Account'.toLowerCase(),
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
              ),
              value: _selectedBank,
              onChanged: (newValue) {
                setState(() {
                  _selectedBank = newValue;
                });
              },
              items: _bank.map((bank) {
                return DropdownMenuItem(
                  child: new Text(
                    bank["ledger_account_name"],
                    style: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  ),
                  value: bank["ledger_account_name"],
                );
              }).toList(),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text('Submit',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold')),
                      onPressed: () {
                        setState(() {
                          dateError = null;
                        });
                        if (dateController.text.trim() == "") {
                          setState(() {
                            dateError = "Please enter transaction date";
                          });
                        } else if (_selectedBank == null ||
                            _selectedBank.trim() == "") {
                          Toasly.error(context, "Please select bank");
                        } else {
                          print("DDDDDDDDDDDDDDDDDDDDDDD");
                          String accountId = null;
                          for (var a in _bank) {
                            if (a["ledger_account_name"] == _selectedBank) {
                              accountId = a["ledger_account_id"].toString();
                              break;
                            }
                          }
                          print(accountId);
                          if (accountId == null) {
                            Toasly.error(context, "Please select bank");
                            return;
                          }
                          onNext({
                            "payment_date": dateController.text.trim(),
                            "bank_account": accountId,
                            "transaction_reference":
                            transactionNumberController.text.trim(),
                          });
                        }
                      },
                      color: FsColor.primaryflat,
                      textColor: FsColor.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      /*),*/
    );
  }

  @override
  void onBanksDetails(List banks) {
    setState(() {
      _bank = banks;
    });
  }

  @override
  void onBanksDetailsError() {}

  @override
  void onBanksDetailsFailed() {}
}

/**/
