import 'package:flutter/material.dart';
import 'package:tqm/main.dart';
import 'package:tqm/models/Stratige/ExecuteDept.dart';
import 'package:tqm/models/Stratige/Goal.dart';
import 'package:tqm/models/Stratige/Pointer.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/models/Stratige/Years.dart';
import 'package:tqm/views/stratige/_periodic_reading_form.dart';

class PeriodicReadingPage extends StatefulWidget {
  @override
  _PeriodicReadingPageState createState() => _PeriodicReadingPageState();
}

class _PeriodicReadingPageState extends State<PeriodicReadingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _periodicReadingFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = false;

  final List<StratigeModel> dumpStratigeList = StratigeModel.dumpStratigeList;

  StratigeModel selectedStratige;
  YearsModel selectedYear;
  GoalModel selectedGoal;
  PointerModel selectedPointer;
  ExecuteDeptModel selectedExeOfficer;

  @override
  Widget build(BuildContext context) {
    return MyApp.getRoot(
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('القراءة الدورية'),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: _scrollController,
            children: [_getInitiativeForm()],
          ),
        ),
        context);
  }

  Widget _getInitiativeForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _periodicReadingFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'الإستراتيجيات'),
                  value: selectedStratige,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  isExpanded: true,
                  items: dumpStratigeList.map((stratige) {
                    return DropdownMenuItem(
                        child: Text(stratige.name), value: stratige);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStratige = value;
                      selectedGoal = null;
                      selectedPointer = null;
                      selectedYear = null;
                      selectedExeOfficer = null;
                    });
                  },
                  validator: (value) {
                    return value == null ? 'يجب إختيار إستراتيجية' : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'الأعوام'),
                  value: selectedYear,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  items: selectedStratige == null
                      ? null
                      : selectedStratige.years.map((year) {
                          return DropdownMenuItem(
                              child: Text(year.name), value: year);
                        }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                  validator: (value) {
                    return value == null ? 'يجب إختيار العام' : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: 'الأهداف'),
                  value: selectedGoal,
                  items: selectedStratige == null
                      ? null
                      : selectedStratige.goals.map((goal) {
                          return DropdownMenuItem(
                              child: Text(goal.name, softWrap: true),
                              value: goal);
                        }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGoal = value;
                      selectedPointer = null;
                      selectedExeOfficer = null;
                    });
                  },
                  validator: (value) {
                    return value == null ? 'يجب إختيار الهدف' : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'المؤشرات'),
                  value: selectedPointer,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  isExpanded: true,
                  items: selectedGoal == null
                      ? null
                      : selectedGoal.pointers.map((pointer) {
                          return DropdownMenuItem(
                              child: Text(pointer.name), value: pointer);
                        }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPointer = value;
                      selectedExeOfficer = null;
                    });
                  },
                  validator: (value) {
                    return value == null ? 'يجب إختيار مؤشر' : null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration:
                      InputDecoration(labelText: 'مسئولين التنفيذ(الأقسام)'),
                  value: selectedExeOfficer,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  isExpanded: true,
                  items: selectedPointer == null
                      ? null
                      : selectedPointer.executeDept.map((exeOfficer) {
                          return DropdownMenuItem(
                              child: Text(exeOfficer.nameDept),
                              value: exeOfficer);
                        }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedExeOfficer = value;
                    });
                  },
                  validator: (value) {
                    return value == null
                        ? 'يجب إختيار القسم مسئول التنفيذ'
                        : null;
                  },
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
                            'إدخال القراءة الدورية',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            _enterPeriodicReading();
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _enterPeriodicReading() {
    if (_periodicReadingFormKey.currentState.validate()) {
      _periodicReadingFormKey.currentState.save();
      PeriodicReadingStratige periodicReadingStratige = PeriodicReadingStratige(
        selectedStratige: selectedStratige,
        selectedYear: selectedYear,
        selectedGoal: selectedGoal,
        selectedPointer: selectedPointer,
        selectedExeOfficer: selectedExeOfficer,
      );
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => PeriodicReadingForm(
                periodicReadingStratige: periodicReadingStratige,
              )));
    }
  }
}

