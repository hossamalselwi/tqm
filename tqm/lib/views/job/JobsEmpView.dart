import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/models/dept.dart' as dept;
import 'package:tqm/models/empModel.dart';
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/services/jopEmpService.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/shareView/NewComboAlter.dart';
import 'package:tqm/views/shareView/customDialogBoxs.dart';
import 'package:tqm/views/shareView/customerDialogBox2.dart';

import 'JobCard.dart';

JobEmpService _jobEmpService = JobEmpService();

class JobsEmpPage extends StatefulWidget {
  final EmpModel data;

  const JobsEmpPage({Key key, this.data}) : super(key: key);
  @override
  _JobEmpPageState createState() => _JobEmpPageState();
}

class _JobEmpPageState extends State<JobsEmpPage> {
  List<JobsEmpModel> data;

  @override
  void initState() {
    super.initState();
    data = widget.data.jobs;
  }

  @override
  Widget build(BuildContext context) {
    var widht = MediaQuery.of(context).size.width;

    _onSave() {
      Navigator.pop(context);
    }

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
                  onJobChanged: (value) {
                    var idJob = value;
                  },
                  onSave: _onSave,
                )
              ]))
        ]);*/
    //
    JobsEmpModel model = JobsEmpModel();

    GlobalKey<FormState> _key = new GlobalKey();
    bool _validate = false;

    _sendToServer(JobsEmpModel model, String op) async {
      if (_key.currentState.validate()) {
        _key.currentState.save();
        final UiUtilities uiUtilities = UiUtilities();

        try {
          BotToast.showLoading(
              allowClick: false,
              clickClose: false,
              //backgroundColor: bBasicColor,

              backButtonBehavior: BackButtonBehavior.ignore);

          bool sata = false;
          if (op == 'NEW')
            sata = await _jobEmpService.add(model);
          else
            sata = await _jobEmpService.update(model);
          BotToast.closeAllLoading();
          if (sata) {
            uiUtilities.alertNotification(
                context: context, message: ' تم اضافة الوظيفة ');
            Navigator.of(context).pop();

            setState(() {
              widget.data.jobs.add(model);
            });
            ////

            // getData();
          } else {
            uiUtilities.alertNotification(
                context: context,
                message: ' حدث خطا الرجاء التاكد من اتصالك بالانترنت ');
          }
        } catch (ee) {
          uiUtilities.alertNotification(
              context: context,
              message: ' حدث خطا الرجاء التاكد من اتصالك بالانترنت ');
        }
      } else {
        setState(() {
          _validate = true;
        });
      }
    }

    _deleteJob(String id) async {
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool s = await _jobEmpService.delete(id);
        BotToast.closeAllLoading();

        if (s) {
          // getData();
          int id1 = int.parse(id);

          setState(() {
            widget.data.jobs.removeWhere((element) => element.id == id1);
          });

          uiUtilities.alertNotification(
              context: context, message: '  تم حذف وظيفة الموظف  :($id )');
        } else {
          uiUtilities.alertNotification(
              context: context,
              message: 'حدث خطا اثناء الحدف تاكد من اتصالك بالانترنت');
        }
      } catch (eee) {
        BotToast.closeAllLoading();

        uiUtilities.alertNotification(
            context: context,
            message: 'حدث خطا اثناء الحدف تاكد من اتصالك بالانترنت');
      }
    }

    showAlertDialogJob(BuildContext context, JobsEmpModel model) {
      // set up the button
      /* Widget okButton = FlatButton(
      child: Text("موافق "),
      onPressed: () {
        _deleteJob(model.id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.help,
            color: Colors.white,
          )),
      content: 
      Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'هل انت متأكد من حذف الوظيفة ',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
            Text(
              model.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 12,
                // color: Colors.black87
              ),
            ),
            Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),

              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
            Text(
              'لقسم :${widget.item.name} فرع : ${widget.item.nameBrch}  ',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              softWrap: true,
            ),
          ]),
      actions: [
        okButton,
      ],
    );*/
      // show the dialog
      //

      Widget child = Column(children: [
        Text(
          'Job: ${model.nameJob.toString()}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'Dept : ${model.namedept.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'Branch : ${model.nameBrch.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Divider(),
        Text(
          ' الموظف : ${widget.data.name}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Text(
          'هل انت متأكد من حذف الوظيفة',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ]);

      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            action: () {
              _deleteJob(model.id.toString());
              Navigator.pop(context);
            },
            descriptions: child,
            title: model.nameJob,
            text: 'OK',
          );
        },
      );
    }

    showD(JobsEmpModel mode, String op) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox2(
              context: context,
              action: () {},
              txtaction: 'Add',
              child: Form(
                key: _key,
                autovalidate: _validate,
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      NewCombBrchDeptView(
                        initBrch: null
                        //Barch(id: mode.idBrch)
                        ,
                        initDept: dept.Data(id: mode.idDeptJob),
                        initJob: JobsModel(idNameJob: mode.idJob),
                        onBrchChanged: (value) {
                          mode.idBrch = value.id;
                          mode.nameBrch = value.name;
                        },
                        onDeptChanged: (value) {
                          //mode.idDeptJob = value.;
                          mode.namedept = value.name;
                        },
                        onJobChanged: (value) {
                          mode.idDeptJob = int.parse(value.id);
                          mode.idEmp = int.parse(widget.data.id);
                          mode.nameJob = value.name;
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
                            _sendToServer(mode, op);

                            //setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              op == 'NEW' ? 'اضافة' : 'تعديل',
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

      /* return
          //CustomDialogBox2

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: 
                  Form(
                    key: _key,
                    autovalidate: _validate,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          NewCombBrchDeptView(
                            initBrch: null
                            //Barch(id: mode.idBrch)
                            ,
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
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
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
    */
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            ' Count Jobs : ${widget.data.jobs.length.toString()}'),
                        Divider()
                      ]),
                ),
                //addWidget,
                SizedBox(height: kDefaultPadding / 3),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return JobCard.buildEmp(
                            context: context,
                            model: data[index],
                            action: (context, mo) {
                              showAlertDialogJob(context, mo);
                            });
                        // bodyColumn(data[index]);
                      }),
                ),
                //JobCard
                /*
                Expanded(
                  child: StreamBuilder<List<JobsEmpModel>>(
                      stream: data,
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
             */
              ]))),
    );
  }
}

//JobsEmpModel
