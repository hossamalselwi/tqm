import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tqm/managers/nameDeptmanager.dart';

import 'package:tqm/models/dept.dart' as dept;

import 'package:tqm/services/barchService.dart';
import 'package:tqm/services/deptService.dart';
//
//

class DeptCompView extends StatefulWidget {
  final ValueChanged<int> onDeptChanged;

  final dept.Data initDept;

  DeptCompView({
    Key key,
    this.onDeptChanged,
    this.initDept,
  }) : super(key: key);

  @override
  _DeptCompViewState createState() => _DeptCompViewState();
}

class _DeptCompViewState extends State<DeptCompView> {
  List<dept.Data> _depts = [
    new dept.Data(name: "اختر القسم", idBrch: "1", id: -100),
  ];

  dept.Data _selecteddept =
      dept.Data(name: "اختر القسم", idBrch: "1", id: -100);

  @override
  void initState() {
    getDept();

    Future.delayed(Duration(seconds: 2), () {});

    super.initState();
  }

  Future<void> _showDeptDialog(String message, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (int i = 0; i < _depts.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _onSelectingDept(_depts[i]);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Text(_depts[i].name),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  NameDeptManager _deptmanager = NameDeptManager();
  DeptService _deptService = DeptService();

  Future getDept() async {
    List<dept.Data> data = List<dept.Data>();

    /* if (widget.isJob)
      data = await _deptService.getByBrch(idBrch);*/
    // else
    // {
    var data1 = await _deptmanager.getA();
    data = data1.data;
    // }

    var dat = data;

    if (!mounted) return;

    setState(() {
      _depts.addAll(dat);
    });

    if (widget.initDept == null)
      _selecteddept = dept.Data(name: "اختر القسم", idBrch: "0", id: -100);
    else {
      _selecteddept =
          _depts.where((x) => x.id == widget.initDept.idNameDept).first;
    }

    return _depts;
  }

  void _onSelectingDept(dept.Data value) {
    if (!mounted) return;
    setState(() {
      this.widget.onDeptChanged(value.id);
      _selecteddept = value;
      /*
      if (widget.isJob) {
        _selectedJob = new JobsModel(name: "اختر المسمى الوظيفي");
        _jobs = [_selectedJob];
        getJobs();
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      //
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text(
              'القسم : ',
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _showDeptDialog('', '');
                },
                child: Row(
                  children: [
                    Text(
                      _selecteddept.name,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}

/*********************models  */
/////////////////
///
