import 'package:flutter/material.dart';

import 'package:tqm/models/Stratige/customer.dart';
import 'package:tqm/services/Stratege/domainService.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'goalView.dart';
import 'package:tqm/services/Stratege/customerService.dart';

final CustomerService _customerService = CustomerService();

class CustomerForm extends StatefulWidget {
  @override
  _CustomerFormFormState createState() => _CustomerFormFormState();
}

class _CustomerFormFormState extends State<CustomerForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _beneficiaryFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  CustomerModel beneficiaryModel = CustomerModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _getBeneficiaryForm();
  }

  Widget _getBeneficiaryForm() {
    var mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SimpleDialog(
        title: Container(
          width: mainWidth,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(7),
          child: Text(
            'إضافة مستفيد',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        children: [
          Container(
            width: mainWidth,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                Form(
                  key: _beneficiaryFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: FormText.textFormF(
                          context,
                          //null,
                          beneficiaryModel.name,
                          'إسم المستفيد',
                          null,
                          FormValidator().validateisEmpty,
                          (value) => beneficiaryModel.name = value,
                          'إسم المستفيد',
                          null,
                          [TextInputType.text],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: !_isLoading
                            ? Container(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'حــفــظ المستفيد',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _addBeneficiary();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addBeneficiary() async {
    try {
      if (_beneficiaryFormKey.currentState.validate()) {
        _beneficiaryFormKey.currentState.save();
        _customerService.add(this.beneficiaryModel);
        SystemMsg.showMsg(
          _scaffoldKey,
          'تم حفظ المستفيد بنجاح',
          SystemMsg.backgroundSuccessColor,
        );
        Navigator.of(context).pop(this.beneficiaryModel);
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }
}
