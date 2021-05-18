
import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/ExecuteDept.dart';
import 'package:tqm/models/Stratige/Goal.dart';
import 'package:tqm/models/Stratige/Pointer.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/models/Stratige/Years.dart';
import 'package:tqm/views/shareView/FormText.dart';

import '../../main.dart';

class PeriodicReadingForm extends StatefulWidget {
  final PeriodicReadingStratige periodicReadingStratige;

  const PeriodicReadingForm({Key key, @required this.periodicReadingStratige})
      : super(key: key);

  @override
  _PeriodicReadingFormState createState() => _PeriodicReadingFormState();
}

class _PeriodicReadingFormState extends State<PeriodicReadingForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _periodicReadingFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  PeriodicReadingStratige prs;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    prs = widget.periodicReadingStratige;
  }

  @override
  Widget build(BuildContext context) {
    return MyApp.getRoot(
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('إدخال القراءة الدورية'),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: _getEnterForm(),
          ),
        ),
        context);
  }

  Widget _getEnterForm() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.9,
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            //height: height*0.1,
            margin: EdgeInsets.only(bottom: 5.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'صيغة المؤشر: ${prs.selectedPointer.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  'العام ( ${prs.selectedYear.name} ) ، المستهدف العام ( ${prs.selectedPointer.qty.toString()} ) ',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height * 0.66,
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //width: width * 0.5,
                      child: Column(
                        children: _getBrnchs(),
                      ),
                    ),
                    Container(
                      width: width * 0.53,
                      height: height * 0.70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _getMCycle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            //height: height*0.1,
            margin: EdgeInsets.all(10.0),
            child: !_isLoading
                ? Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.blue,
                child: Text(
                  'حفظ القراءة الدورية',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  _savePeriodicReading();
                },
              ),
            )
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  List<Widget> _getBrnchs() {
    //print('prs.selectedExeOfficer.overload.length');
    //print(prs.selectedExeOfficer.overload.length);
    double width = MediaQuery.of(context).size.width * 0.4;
    List<Widget> brnchsList = [];
    brnchsList.add(Container(
      height: 52.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0),
                  right: BorderSide(width: 1.0),
                  top: BorderSide(width: 1.0),
                )),
            alignment: Alignment.center,
            width: width * 0.3,
            child: Text('الفروع'),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(width: 1.0)),
            ),
            width: width * 0.7,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0),
                      )),
                  child: Text('المستهدفين'),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: width * 0.3,
                        child: Text('نسبة'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1.0),
                            )),
                        alignment: Alignment.center,
                        width: width * 0.38,
                        child: Text('رقم'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    prs.selectedExeOfficer.overload.map((overload) {
      brnchsList.add(Container(
        height: 24.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0),
                    right: BorderSide(width: 1.0),
                    top: BorderSide(width: 1.0),
                  )),
              alignment: Alignment.center,
              width: width * 0.3,
              child: Text('${overload.nameBrch}'),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(width: 1.0)),
              ),
              width: width * 0.7,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: width * 0.3,
                          child: Text('${overload.qty}'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(width: 1.0),
                              )),
                          alignment: Alignment.center,
                          width: width * 0.38,
                          child: Text(
                              '${(overload.qty / 100) * prs.selectedPointer.qty}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
      brnchsList.add(Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
        alignment: Alignment.center,
        height: 42,
        width: width,
        child: Text('الفعلي'),
      ));
      brnchsList.add(Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
        alignment: Alignment.center,
        height: 24.0,
        width: width,
        child: Text('الفرق'),
      ));
      brnchsList.add(Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0))),
        alignment: Alignment.center,
        height: 24.0,
        width: width,
        child: Text('النسبة'),
      ));
    }).toList();
    return brnchsList;
  }

  List<Widget> _getMCycle() {
    List<Widget> mCycleList = [];
    mCycleList.add(Form(
      key: _periodicReadingFormKey,
      child: Row(
        children: prs.selectedPointer.mCycle.map((mCycle) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(width: 1.0)),
                height: 52.0,
                width: 100,
                alignment: Alignment.center,
                child: Text('${mCycle.displayTitle}'),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: prs.selectedExeOfficer.overload.map((ov) {
                    var tt = ov.branchMCycle
                        .where((element) => element.year == prs.selectedYear.name)
                        .first
                        .mCycleTarget
                        .where((element) => element.measurementCycle == mCycle)
                        .first;
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(border: Border.all(width: 1.0)),
                            alignment: Alignment.center,
                            height: 24.0,
                            width: 100,
                            child: Text('${tt.cycleTarget}'),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(width: 1.0)),
                            height: 42.0,
                            width: 100,
                            child: FormText.textFormF(
                              context,
                              // _goalTextFocus,
                              tt.cTargetActual.toString(),
                              '',
                              null,
                              FormValidator().validateisEmpty,
                                  (value) => tt.cTargetActual = int.parse(value),
                              '',
                              null,
                              [TextInputType.text],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(width: 1.0)),
                            alignment: Alignment.center,
                            height: 24.0,
                            width: 100,
                            child: Text('${tt.cTargetActual-tt.cycleTarget}'),
                          ),
                          Container(
                            decoration: BoxDecoration(border: Border.all(width: 1.0)),
                            alignment: Alignment.center,
                            height: 24.0,
                            width: 100,
                            child: Text('${(tt.cTargetActual/tt.cycleTarget)*100} %'),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          );
        }).toList(),
      ),
    ));
    return mCycleList;
  }

  _savePeriodicReading() {
    setState(() {
      _periodicReadingFormKey.currentState.save();
    });
  }
}

class PeriodicReadingStratige {
  StratigeModel selectedStratige;
  YearsModel selectedYear;
  GoalModel selectedGoal;
  PointerModel selectedPointer;
  ExecuteDeptModel selectedExeOfficer;

  PeriodicReadingStratige(
      {this.selectedStratige,
        this.selectedYear,
        this.selectedGoal,
        this.selectedPointer,
        this.selectedExeOfficer});
}