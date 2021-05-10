import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/services/deptService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/barch/BrchCardView.dart';
import 'package:tqm/views/shareView/NewComboAlter.dart';
import 'package:tqm/views/shareView/appBar.dart';
import 'package:tqm/views/shareView/brachComAlter.dart';
import 'package:tqm/views/shareView/deptCompAlter.dart';
import '../../models/dept.dart';
import 'deptCardView.dart';
import 'deptDetails.dart';

import 'package:tqm/views/shareView/customDialogBoxs.dart';
import '../../shared_widgets/empty_widget.dart';

DeptService _deptService = DeptService();

class DeptView extends StatefulWidget {
  Barch brch;
  final String op;

  DeptView({Key key, this.brch = null, this.op = 'ALL'}) : super(key: key);

  @override
  _DeptBAllPageState createState() => _DeptBAllPageState();
}

class _DeptBAllPageState extends State<DeptView> {
  Future<List<Data>> data;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  int count = 0;

  getData() async {
    Future<List<Data>> data1;

    if (widget.op == 'ALL')
      data1 = _deptService.getAll();
    else
      data1 = _deptService.getByBrch(widget.brch.id);

    setState(() {
      data = data1;
      data.then((value) {
        setState(() {
          count = value.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /* Widget addWidget = ExpansionTile(
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
                 
                  isJob: false,
                )

              ]))
        ]);
        */
    //

    _sendToServer(Data mode, String op) async {
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
            sata = await _deptService.add(mode);
          else
            sata = await _deptService.update(mode);
          BotToast.closeAllLoading();
          if (sata) {
            uiUtilities.alertNotification(
                context: context, message: 'تم حفظ القسم ');

            Navigator.of(context).pop();
            getData();

            /*setState(() {
            data = _deptService.getDeptAll();
          });*/
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

    showD(Data mode, String op) {
      if (op != 'ALL') mode.idBrch = widget.brch.id;

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
                  height: 170,
                  child: Column(
                    children: [
                      op != 'ALL'
                          ? Text('Name : ${widget.brch.name}')
                          : BrchCompView(
                              onBrchChanged: (value) {
                                if (value.id != '-100') {
                                  widget.brch = value;
                                  mode.idBrch = value.id;
                                }
                              },
                            ),
                      Divider(),
                      Text('Select Dept : '),
                      DeptCompView(
                        onDeptChanged: (value) {
                          if (value != -100) {
                            //mode.id = value;
                            mode.idNameDept = value.toString();
                          }
                        },
                      ),
                      /* NewCombBrchDeptView(
                        initBrch: Barch(id: mode.idBrch),
                        initDept: mode,
                        onBrchChanged: (value) {
                          var idbrch = value;
                        },
                        onDeptChanged: (value) {
                          var iddept = value;
                        },
                        onJobChanged: (value) {
                          var idJob = value;
                        },
                        isJob: false,
                      ),*/
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

    _delete(int id) async {
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool s = await _deptService.delete(id);
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

    showAlertDialog(BuildContext context, Data model) {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("موافق "),
        onPressed: () {
          _delete(model.id);
          Navigator.pop(context);
        },
      );

      Widget child = Column(children: [
        Text(
          'القسم: ${model.name.toString()}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'الفرع : ${model.nameBrch.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'عدد الوظائف : ${model.jobs.length.toString()}',
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
        Divider(),
        /* Text(
        'ID : ${model.id.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),*/
        SizedBox(
          height: 10,
        ),
        Text(
          'هل انت متأكد من حذف القسم ',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          ' احذر قد تفقد جميع بيانات الوظائف لهذا القسم',
          maxLines: 2,
          softWrap: true,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent),
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

    /*  Widget bodyColumn(Data model) {
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
                      width: widht / 8,
                      child: Text(
                        model.id.toString(),
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(4.0),
                    width: widht / 3,
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
                      model.nameBrch,
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  padding: EdgeInsets.all(4.0),
                  width: widht / 5,
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
    }*/

    Data model = Data();

    return Scaffold(
      appBar: appBarOne(
          context,
          widget.op == 'ALL'
              ? ' الاقسام | لكل الفروع'
              : ' اقسام الفرع: ${widget.brch.name.toString()}'),
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
          color: Colors.white24,
          child: Column(children: [
            //SizedBox(height: kDefaultPadding),
            widget.op == 'ALL'
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Column(
                      children: [
                        Text('بيانات الفرع'),
                        BrchCardView(
                          item: widget.brch,
                        ),
                      ],
                    ),
                  ),
            //head,
            Text('بيانات الاقسام  :        ($count) Depts'),
            Expanded(
              child: StreamBuilder<List<Data>>(
                  stream: data.asStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Data>> snapshot) {
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
                          if (snapshot.data.length == 0) {
                            return EmptyView(
                              title: 'لا اقسام مضافة بعد',
                            );
                          }

                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DeptDetailsView(
                                                item: snapshot.data[index],
                                                op: 'EDIT',
                                              )),
                                    ).then((value) => getData());
                                    //
                                  },
                                  child: DeptCardView(
                                    item: snapshot.data[index],
                                    deleteAction: showAlertDialog,
                                    op: widget.op,
                                  ),
                                );
                                //bodyColumn(snapshot.data[index]);
                              });
                      }
                    }
                  }),
            )
          ])),
    );
  }
}

//JobsEmpModel
/////////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
