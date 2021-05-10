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

class JobCompView extends StatefulWidget {
  final ValueChanged<JobsModel> onJobChanged;

  final JobsModel initJob;

  JobCompView({
    Key key,
    this.onJobChanged,
    this.initJob,
  }) : super(key: key);

  @override
  _JobCompViewState createState() => _JobCompViewState();
}

class _JobCompViewState extends State<JobCompView> {
  List<JobsModel> _jobs = [new JobsModel(name: "Select Job")];
  JobsModel _selectedJob = new JobsModel(name: "Select Job");

  BrchSerivce _brchSerivce = BrchSerivce();
  @override
  void initState() {
    getJobs();

    super.initState();
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

  JobsNameService _jobService = JobsNameService();

  Future getJobs() async {
    List<JobsModel> datajob = await JobsNameService.getNameAll();

    var dat = datajob;

    // _depts = [new dept.Data(name:"اختر القسم")];

    dat.forEach((f) {
      if (!mounted) return;

      setState(() {
        _jobs.add(f);
      });
    });
    if (widget.initJob == null)
      _selectedJob = new JobsModel(name: "Select Job");

    return _jobs;
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
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      //
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                      style: TextStyle(fontSize: 13),
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
