import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/models/dept.dart' as dept;
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/services/jobDeptService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/shareView/NewComboAlter.dart';
import 'package:tqm/views/shareView/appBar.dart';

JobDeptService _jobService = JobDeptService();

class JobView extends StatefulWidget {
  @override
  _AllJobsPageState createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<JobView> {
  Future<List<JobsModel>> jobsModel;

  @override
  void initState() {
    super.initState();
    getData();

    //JobsModel = _jobService.getAll();
  }

  getData() {
    setState(() {
      jobsModel = _jobService.getAll();
    });
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

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
                  " رقم  ",
                  style: TextStyle(fontSize: 13),
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
                "المسمى الوظيفي",
                style: TextStyle(fontSize: 13),
              )),
          Container(
            width: 1,
            color: Colors.grey[700],
          ),
          Container(
              padding: EdgeInsets.all(4.0),
              width: widht / 4,
              child: Text(
                "القسم ",
                style: TextStyle(fontSize: 13),
              )),
          Container(
              padding: EdgeInsets.all(4.0),
              width: widht / 4,
              child: Text(
                "الفرع",
                style: TextStyle(fontSize: 13),
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

    _sendToServer(JobsModel mode, String op) async {
      if (_key.currentState.validate()) {
        _key.currentState.save();
        final UiUtilities uiUtilities = UiUtilities();

        try {
          BotToast.showLoading(
              allowClick: false,
              clickClose: false,
              backButtonBehavior: BackButtonBehavior.ignore);

          bool sata = false;
          if (op == 'NEW')
            sata = await _jobService.add(mode);
          else
            sata = await _jobService.update(mode);
          BotToast.closeAllLoading();
          if (sata) {
            uiUtilities.alertNotification(
                context: context, message: 'تم حفظ الوظيفة ');
            Navigator.of(context).pop();

            getData();
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

    showD(JobsModel mode, String op) {
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
                        initDept: dept.Data(id: int.parse(mode.idDeptBra)),
                        initJob: JobsModel(idNameJob: mode.idNameJob),
                        onBrchChanged: (value) {
                          mode.idBrch = value.id;
                        },
                        onDeptChanged: (value) {
                          mode.idDeptBra = value.toString();
                        },
                        onJobChanged: (value) {
                          mode.idNameJob = value.id;
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

    _delete(String id) async {
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool s = await _jobService.delete(id);
        BotToast.closeAllLoading();

        if (s) {
          getData();

          uiUtilities.alertNotification(
              context: context, message: 'تم حدف القسم :($id )');
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

    showAlertDialog(BuildContext context, JobsModel model) {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("موافق "),
        onPressed: () {
          _delete(model.id);
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
        content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                ' هل انت متاكد من حدف',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
              Text(
                '   الوظيفة ${model.name}  |Dept: ${model.nameDept} |  الفرع: ${model.nameBrch}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ]),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    Widget bodyColumn(JobsModel model) {
      return InkWell(
        onTap: () {
          showD(model, 'EDIT');
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
                        model.id,
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(4.0),
                    width: widht / 5,
                    child: Text(
                      model.name,
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
                      model.nameDept,
                      style: TextStyle(fontSize: 13),
                    )),
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
                            Icons.delete,
                            size: 18,
                          ),
                          onPressed: () {
                            showAlertDialog(context, model);
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

    JobsModel model = JobsModel();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showD(model, 'NEW');
          }),
      appBar: appBarOne(context, 'الوظائف '),
      body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? 15 : 0),
          color: kBgLightColor,
          child: Container(
              child: Column(children: [
            SizedBox(height: kDefaultPadding),
            head,
            Expanded(
              child: StreamBuilder<List<JobsModel>>(
                  stream: jobsModel.asStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JobsModel>> snapshot) {
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
                              itemBuilder: (BuildContext context, int index) {
                                return bodyColumn(snapshot.data[index]);
                              });
                      }
                    }
                  }),
            ),
          ]))),
    );
  }
}

//JobsEmpModel
