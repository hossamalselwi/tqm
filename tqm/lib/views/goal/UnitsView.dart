import 'package:flutter/material.dart';

import 'package:tqm/models/Stratige/Unit.dart';
import 'package:tqm/services/Stratege/UnitsService.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'goalView.dart';
import 'package:tqm/services/Stratege/customerService.dart';

final UnitService _unitService = UnitService();

class UnitForm extends StatefulWidget {
  @override
  _MeasuringUniteFormState createState() => _MeasuringUniteFormState();
}

class _MeasuringUniteFormState extends State<UnitForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _measuringUniteFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  UnitsModel measuringUniteModel = UnitsModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _getMeasuringUniteForm();
  }

  Widget _getMeasuringUniteForm() {
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
            'إضافة وحدة قياس',
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
                  key: _measuringUniteFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: FormText.textFormF(
                          context,
                          //null,
                          measuringUniteModel.name,
                          'وحدة القياس',
                          null,
                          FormValidator().validateisEmpty,
                          (value) => measuringUniteModel.name = value,
                          'وحدة القياس',
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
                                    'حــفــظ وحدة القياس',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _addMeasuringUnite();
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

  Future<void> _addMeasuringUnite() async {
    try {
      if (_measuringUniteFormKey.currentState.validate()) {
        _measuringUniteFormKey.currentState.save();
        _unitService.add1(model: this.measuringUniteModel);
        SystemMsg.showMsg(
          _scaffoldKey,
          'تم حفظ وحدة القياس بنجاح',
          SystemMsg.backgroundSuccessColor,
        );
        Navigator.of(context).pop(this.measuringUniteModel);
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }
}
