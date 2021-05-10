import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tqm/managers/nameDeptmanager.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/models/dept.dart' as dept;

import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/services/barchService.dart';
import 'package:tqm/services/deptService.dart';
import 'package:tqm/services/jobDeptService.dart';
import 'package:tqm/services/nameJobs.dart';
//
//

class NewCombBrchDeptView extends StatefulWidget {
  final ValueChanged<Barch> onBrchChanged;
  final ValueChanged<dept.Data> onDeptChanged;
  final ValueChanged<JobsModel> onJobChanged;
  final bool isJob;

  final Barch initBrch;
  final dept.Data initDept;
  final JobsModel initJob;

  NewCombBrchDeptView({
    Key key,
    this.onBrchChanged,
    this.onDeptChanged,
    this.onJobChanged,
    this.isJob = true,
    this.initBrch,
    this.initDept,
    this.initJob,
  }) : super(key: key);

  @override
  _NewCombBrchDeptViewState createState() => _NewCombBrchDeptViewState();
}

class _NewCombBrchDeptViewState extends State<NewCombBrchDeptView> {
  List<Barch> _brch = [new Barch(name: "اختر الفرع", image: '', id: "-100")];
  Barch _selectedbrch = Barch(name: "اختر الفرع", image: '', id: "-100");

  List<dept.Data> _depts = [
    new dept.Data(name: "اختر القسم", idBrch: "1", id: -100),
  ];

  dept.Data _selecteddept =
      dept.Data(name: "اختر القسم", idBrch: "1", id: -100);

  List<JobsModel> _jobs = [new JobsModel(name: "اختر المسمى الوظيفي")];
  JobsModel _selectedJob = new JobsModel(name: "اختر المسمى الوظيفي");

  BrchSerivce _brchSerivce = BrchSerivce();
  @override
  void initState() {
    getBarchs();
    Future.delayed(Duration(seconds: 2), () {
      getDept(widget.initBrch.id);
      //if (widget.isJob) getJobs();
    });

    super.initState();
  }

  Future getBarchs() async {
    var data = await _brchSerivce.getAll();

    setState(() {
      _brch.addAll(data);

      if (widget.initBrch == null)
        _selectedbrch = Barch(name: "اختر الفرع", image: '', id: "-100");
      else
        _selectedbrch = _brch.where((x) => x.id == widget.initBrch.id).first;

      //widget.initBrch;
    });
  }

  Future<void> _showBrchDialog(String message, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (int i = 0; i < _brch.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _onSelectingBarch(_brch[i]);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Text(_brch[i].name),
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

  Future<void> _showJobsDialog(String message, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (int i = 0; i < _jobs.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _onSelectedJobs(_jobs[i]);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Text(_jobs[i].name),
                            ],
                          ),
                        ),
                      ],
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

  Future getDept(String idBrch) async {
    List<dept.Data> data = List<dept.Data>();

    if (widget.isJob)
      data = await _deptService.getByBrch(idBrch);
    else {
      var data1 = await _deptmanager.getA();
      data = data1.data;
    }

    var dat = data;

    if (!mounted) return;
    _depts = [new dept.Data(name: "اختر القسم", idBrch: "0", id: -100)];
    setState(() {
      _depts.addAll(dat);
    });

    if (widget.initDept == null)
      _selecteddept = dept.Data(name: "اختر القسم", idBrch: "0", id: -100);
    else {
      /*if (_depts.length > 1) {
        var _selecteddept1 = _depts
            .where((x) => x.id.toString() == widget.initDept.idNameDept)
            .toList();
        _selecteddept = _selecteddept1[0];
      } else {
        _selecteddept = dept.Data(name: "اختر القسم", idBrch: "0", id: -100);
      }*/
    }

    return _depts;
  }

  JobDeptService _jobService = JobDeptService();

  Future getJobs(String idDept) async {
    List<JobsModel> datajob = await _jobService.getbyDept(idDept);

    if (!mounted) return;

    var dat = datajob;

    _jobs = [new JobsModel(name: "اختر المسمى الوظيفي")];
    //
    setState(() {
      _jobs.addAll(dat);
    });

    if (widget.isJob) {
      if (widget.initJob == null)
        _selectedJob = new JobsModel(name: "اختر المسمى الوظيفي");
      else {
        /*
        _selecteddept =
            _depts.where((x) => x.id == widget.initDept.idNameDept).first;*/
      }
    }
    return _jobs;
  }

  void _onSelectingBarch(Barch value) {
    if (!mounted) return;
    setState(() {
      if (_depts.length == 0) {
        _selecteddept = dept.Data(name: "اختر القسم", id: -100);
        _depts = [_selecteddept];
      }
      _selectedbrch = value;
      this.widget.onBrchChanged(value);
      if (widget.isJob) getDept(value.id);
    });
  }

  void _onSelectingDept(dept.Data value) {
    if (!mounted) return;
    setState(() {
      this.widget.onDeptChanged(value);
      _selecteddept = value;

      if (widget.isJob) {
        _selectedJob = new JobsModel(name: "اختر المسمى الوظيفي");
        _jobs = [_selectedJob];
        getJobs(value.id.toString());
      }
    });
  }

  void _onSelectedJobs(JobsModel value) {
    if (!mounted) return;
    setState(() {
      _selectedJob = value;
      this.widget.onJobChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    /* Widget okeyWidget = Material(
        child: InkWell(
            onTap: () async {

              //widget.onSave();
             
            },
            child: Ink(
                child: Container(
                    padding: EdgeInsets.all(4),
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: bBasicColor,
                          style: // !isSelected ?
                              //BorderStyle.solid :
                              BorderStyle.none),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.blue,
                    ),
                    child: Text(
                      'موافق',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                      textAlign: TextAlign.center,
                    )))));
*/
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text(
              'الفرع : ',
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _showBrchDialog('', '');
                },
                child: Row(
                  children: [
                    Text(
                      _selectedbrch.name,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ),
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
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.isJob)
          Row(
            children: [
              Text(
                'المسمى الوظيفي : ',
                style: TextStyle(fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _showJobsDialog('', '');
                  },
                  child: Row(
                    children: [
                      Text(
                        _selectedJob.name,

                        // JobsModel _selectedJob = new JobsModel(name: "اختر المسمى الوظيفي");

                        style: TextStyle(
                            fontSize: 15,
                            color: _selectedJob.name == 'اختر المسمى الوظيفي'
                                ? Colors.black
                                : Colors.redAccent),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_drop_down,
                          color: _selectedJob.name == 'اختر المسمى الوظيفي'
                              ? Colors.black
                              : Colors.redAccent)
                    ],
                  ),
                ),
              ),
            ],
          ),
        // okeyWidget,
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
