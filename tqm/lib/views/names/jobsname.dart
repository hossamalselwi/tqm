import 'dart:convert';
import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/search/search_view.dart';
import 'package:tqm/views/shareView/FormText.dart';
import '../../services/nameJobs.dart';

import 'package:tqm/views/shareView/customDialogBoxs.dart';

class JobsNamsView extends StatefulWidget {
  @override
  _JobsAllViewState createState() => _JobsAllViewState();
}

class _JobsAllViewState extends State<JobsNamsView> {
  List<JobsModel> datajob = List<JobsModel>();

  Future<dynamic> getAll() async {
    BotToast.showLoading(
        allowClick: false,
        clickClose: false,
        backButtonBehavior: BackButtonBehavior.ignore);

    var datajob1 = await JobsNameService.getNameAll();

    if (datajob1 != null) {
      setState(() {
        datajob = datajob1;
      });
    }
    BotToast.closeAllLoading();
  }

  @override
  initState() {
    getAll();
    super.initState();
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  showD(JobsModel mode, String op) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Form(
              key: _key,
              autovalidate: _validate,
              child: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    FormText.textFormF(context, mode.name, ' اسم الوظيفة', null,
                        FormValidator().validateisEmpty, (String value) {
                      mode.name = value;
                    }, 'اسم الوظيفة', null),
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

  JobsNameService _service = JobsNameService();

  _sendToServer(JobsModel mode, String op) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);
        String message = 'تم حفظ اسم الوظيفة ';
        bool sata = false;
        if (op == 'NEW')
          sata = await _service.add(mode);
        else {
          sata = await _service.update(mode);
          message = 'تم تعديل اسم الوظيفة ';
        }
        BotToast.closeAllLoading();
        if (sata) {
          uiUtilities.alertNotification(context: context, message: message);
          Navigator.of(context).pop();

          setState(() {
            getAll();
          });
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

  _delete(String id) async {
    final UiUtilities uiUtilities = UiUtilities();

    try {
      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);

      bool s = await _service.delete(id);
      BotToast.closeAllLoading();

      if (s) {
        setState(() {
          getAll();

          uiUtilities.alertNotification(
              context: context, message: 'تم حدف اسم الوظيفة :($id )');

          // _showMyDialog();
        });
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

    Widget child = Column(children: [
      Text(
        'Job Name: ${model.name.toString()}',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        'ID : ${model.id.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      SizedBox(
        height: 10,
      ),
      Text(
        'هل انت متأكد من حذف المسمى الوظيفي',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        'احذر سيتم حذف جميع وظائف الاقسام',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w600, color: Colors.redAccent),
        textAlign: TextAlign.center,
      ),
    ]);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          action: () {
            _delete(model.id);
            Navigator.pop(context);
          },
          descriptions: child,
          title: model.name,
          text: 'حذف ',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var widht = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showD(new JobsModel(id: '0'), 'NEW');
          }),
      body: Container(
        padding: EdgeInsets.only(left: 2, right: 2, top: 5),
        child: Column(
          children: <Widget>[
            Container(
                // padding: EdgeInsets.all(10),
                child: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: SearchView(),
                          );
                        }),
                  ]),
            )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2),
              ),
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 1,
                    color: Colors.grey[700],
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                            bottom: 5, right: 20, left: 20, top: 5),
                        width: widht / 4,
                        child: Text(
                          "اسم الوظيفة ",
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
                        "الوصف ",
                        style: TextStyle(fontSize: 15),
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
            ),
            datajob.length == 0
                ? StateNetWork.connectionWaitWidegt()
                //Text('please Wait')
                : Expanded(
                    child: ListView.separated(
                      itemCount: datajob.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            showD(datajob[index], 'EDIT');
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
                                        padding: EdgeInsets.only(
                                            bottom: 5,
                                            right: 20,
                                            left: 20,
                                            top: 5),
                                        width: widht / 4,
                                        child: Text(
                                          datajob[index].name,
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
                                      child: Row(
                                        children: [
                                          Text(
                                            datajob[index].img.toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.download_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                // print('delete');
                                              }),
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    width: widht / 4,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              showAlertDialog(
                                                  context, datajob[index]);
                                              // print('delete');
                                            }),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
///////////////
///
///
///
///
///
///
///
