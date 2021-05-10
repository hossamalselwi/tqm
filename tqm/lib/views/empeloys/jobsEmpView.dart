/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/models/dept.dart' as dept;
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/models/empModel.dart';
import 'package:tqm/services/empService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/shareView/NewComboAlter.dart';

EmpService _empService = EmpService();

class JobEmpView extends StatefulWidget {
  final EmpModel data;

  const JobEmpView({Key key, this.data}) : super(key: key);
  @override
  _JobEmpPageState createState() => _JobEmpPageState();
}

class _JobEmpPageState extends State<JobEmpView> {
  Future<List<JobsEmpModel>> data;

  @override
  void initState() {
    super.initState();
    data = _empService.getJobs(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    var widht = MediaQuery.of(context).size.width;
    Widget head = Container(
      decoration:
          BoxDecoration(border: Border.all(width: 2), color: Colors.grey),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 1,
            color: Colors.grey[700],
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.all(4.0),
                width: widht / 4,
                child: Text(
                  " المسمى الوظيفي ",
                  style: TextStyle(fontSize: 15),
                )),
          ),
          Container(
            width: 1,
            color: Colors.grey[700],
          ),
          Container(
              padding: EdgeInsets.all(4.0),
              width: widht / 5,
              child: Text(
                "القسم  ",
                style: TextStyle(fontSize: 15),
              )),
          Container(
            width: 1,
            color: Colors.grey[700],
          ),
          Container(
              padding: EdgeInsets.all(4.0),
              width: widht / 4,
              child: Text(
                "الفرع",
                style: TextStyle(fontSize: 18),
              )),
          Container(
              padding: EdgeInsets.all(4.0),
              width: widht / 4,
              child: Text(
                "عمليات",
                style: TextStyle(fontSize: 18),
              )),
        ],
      ),
    );

    Widget bodyColumn(JobsEmpModel model) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              fullscreenDialog: true,
              builder: (c) {
                // return JobsOnePage(data:  datajob[index],typeOp: 'تفاصيل المسمى الوظيفي', );
              }));
        },
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 1,
                  color: Colors.grey[700],
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(4.0),
                      width: widht / 4,
                      child: Text(
                        model.nameJob,
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(4.0),
                    width: widht / 5,
                    child: Text(
                      model.namedept,
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  width: 1,
                  color: Colors.grey[700],
                ),
                Container(
                    padding: EdgeInsets.all(4.0),
                    width: widht / 5,
                    child: Text(
                      model.nameBrch,
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: widht / 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.delete_forever_sharp,
                            size: 18,
                          ),
                          onPressed: () {
                            // print('delete');
                          }),
                    ],
                  ),
                )
              ],
            ),
            Divider()
          ],
        ),
      );
    }

    var isExpaorg = false;

    GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

    _onSave() {}
/*
    Widget addWidget = ExpansionTile(
        title: const Text(
          'اضافة  ',
          style: TextStyle(fontSize: 13),
        ),
        childrenPadding: EdgeInsets.symmetric(horizontal: 40),
        expandedAlignment: Alignment.center,
        leading: Icon(isExpaorg ? Icons.close : Icons.add),
        onExpansionChanged: (value) {
          setState(() {
            isExpaorg = value;
          });
        },
       // trailing: SizedBox(),
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
        children: <Widget>[
          new Container(
              height: 150,
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              alignment: Alignment.centerLeft,
              child: ListView(children: [
               
               NewCombBrchDeptView(
                  onBrchChanged: (value) {
                    var idbrch = value;
                  },
                  onDeptChanged: (value) {
                    var iddept = value;
                  },
                  onJobChanged: (value){
                    var idJob= value;
                  },
                 // onSave: _onSave,
                ),
                
                TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.black),
                          onPressed: () {
                            _sendToServer(mode, op);

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              op == 'NEW' ? 'انشاء' : 'تعديل',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white),
                            ),
                          ))

              ]))
        ]);
        //
*/
    JobsEmpModel model = JobsEmpModel();

    showD(JobsEmpModel mode, String op) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Form(
                key: _key,
                autovalidate: _validate,
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      NewCombBrchDeptView(
                        initBrch: Barch(id: mode.idBrch),
                        initDept: dept.Data(id: mode.idDeptJob),
                        initJob: JobsModel(idNameJob: mode.idJob),
                        onBrchChanged: (value) {
                          //  mode.idBrch = value;
                        },
                        onDeptChanged: (value) {
                          // mode.idDeptJob = value;
                        },
                        onJobChanged: (value) {
                          // mode.idNameJob = value;
                        },
                        isJob: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: customRedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                          onPressed: () {
                            // _sendToServer(mode, op);

                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              op == 'NEW' ? 'انشاء' : 'تعديل',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('وظائف الموظف : ${widget.data.name}',
            style: Theme.of(context).textTheme.headline6),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showD(model, 'NEW');
          }),
      body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgLightColor,
          child: SafeArea(
              right: false,
              child: Column(children: [
                /*Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: kDefaultPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            ' وظائف الموظف : ${widget.data.name} | ${widget.data.id}'),
                        Divider()
                      ]),
                ),*/

                //addWidget,

                SizedBox(height: kDefaultPadding),
                head,
                Expanded(
                  child: StreamBuilder<List<JobsEmpModel>>(
                      stream: data.asStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<JobsEmpModel>> snapshot) {
                        if (snapshot.hasError) {
                          return StateNetWork.hasErrorStrWidegt(
                              'Error: ${snapshot.error}');
                        } else {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return StateNetWork.connectionNoneWidegt();
                              break;
                            case ConnectionState.waiting:
                              return StateNetWork.connectionWaitWidegt();
                              break;
                            case ConnectionState.active:
                              return StateNetWork.connectionActiveWidegt(
                                  '\$${snapshot.data}');

                              break;
                            case ConnectionState.done:
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return bodyColumn(snapshot.data[index]);
                                  });
                          }
                        }
                      }),
                )
              ]))),
    );
  }
}

//JobsEmpModel
*/
