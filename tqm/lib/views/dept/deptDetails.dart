import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/services/deptService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/barch/BrchCardView.dart';
import 'package:tqm/views/job/JobCard.dart';
import 'package:tqm/views/shareView/NewComboAlter.dart';
import 'package:tqm/views/shareView/appBar.dart';
import '../../models/dept.dart';
import 'package:tqm/views/shareView/customDialogBoxs.dart';
import 'package:tqm/models/dept.dart' as dept;
import '../../services/jobDeptService.dart';
import '../../views/shareView/IconAction.dart';
import '../../views/shareView/jobCompAlter.dart';
import '../../shared_widgets/customerFielsLable.dart';

JobDeptService _jobService = JobDeptService();

class DeptDetailsView extends StatefulWidget {
  final dept.Data item;

  final String op;

  const DeptDetailsView({Key key, this.item = null, this.op = 'NEW'})
      : super(key: key);

  @override
  _DeptOneViewState createState() => _DeptOneViewState();
}

class _DeptOneViewState extends State<DeptDetailsView> {
  Future<List<Data>> data;

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
  }

  _sendToServerJob(JobsModel mode, String op) async {
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
              context: context, message: 'تم اضافة الوظيفة ');
          Navigator.of(context).pop();

          setState(() {
            widget.item.jobs.add(mode);
          });

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

  showAddJobDialog(JobsModel mode, String op) {
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
                height: 200,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text('اضافة وظيفة لقسم : ${widget.item.name} '),
                    Text(' فرع : ${widget.item.nameBrch}'),
                    JobCompView(
                      onJobChanged: (value) {
                        mode.idNameJob = value.id;
                        mode.name = value.name;
                      },
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
                          mode.idBrch = widget.item.idBrch;
                          mode.idDeptBra = widget.item.id.toString();

                          _sendToServerJob(mode, op);

                          //  setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            op == 'NEW' ? 'ADD ' : 'تعديل',
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

  _deleteJob(String id) async {
    final UiUtilities uiUtilities = UiUtilities();

    try {
      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);

      bool s = await _jobService.delete(id);
      BotToast.closeAllLoading();

      if (s) {
        // getData();

        setState(() {
          widget.item.jobs.removeWhere((element) => element.id == id);
        });

        uiUtilities.alertNotification(
            context: context, message: ' تم حذف الوظيفة   :($id )');
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

  showAlertDialogJob(BuildContext context, JobsModel model) {
    Widget child = Column(children: [
      Text(
        'الوظيفة: ${model.name.toString()}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        'القسم : ${widget.item.name.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        'الفرع : ${widget.item.nameBrch.toString()}',
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
        'هل انت متأكد من حذف وظيفة القسم',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        ' احذر سيتم حذف جميع وظائف الموظفين المسجلين بهذة الوظيفة',
        maxLines: 2,
        softWrap: true,
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
            _deleteJob(model.id);
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

    Data model = Data();

    return Scaffold(
      appBar: appBarOne(
          context,
          widget.op == 'NEW'
              ? ' انشاء قسم جديد'
              : ' تفاصيل القسم :${widget.item.name}'),
      /* floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showD(model, 'NEW');
          }),*/
      body: Container(
          color: Colors.white24,
          child: Column(children: [
            //SizedBox(height: kDefaultPadding),
            DeptCart2View(
              item: widget.item,
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 3,
                ),
                Text('وظائف القسم :(${widget.item.jobs.length.toString()})'),
                IconAction(
                    icon: Icons.add,
                    txt: 'New Job',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    action: () {
                      JobsModel model11 = JobsModel();

                      showAddJobDialog(model11, 'NEW');
                    }),
                SizedBox(
                  width: 3,
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                  itemCount: widget.item.jobs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return JobCard.build(
                        model: widget.item.jobs[index],
                        context: context,
                        action: showAlertDialogJob);

                    //bodyColumn(snapshot.data[index]);
                  }),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.black),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Back',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white)),
              ),
            ),

            SizedBox(height: 15),
          ])),
    );
  }
}

class DeptCart2View extends StatefulWidget {
  DeptCart2View({Key key, this.item}) : super(key: key);

  final dept.Data item;

  @override
  _DeptCart2ViewState createState() => _DeptCart2ViewState();
}

class _DeptCart2ViewState extends State<DeptCart2View> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Card(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.transparent,
              )),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 130,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconAction(
                          icon: Icons.settings,
                          txt: '',
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          action: () {}),
                      /* Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconAction(
                              icon: Icons.edit,
                              txt: 'Edit Dept Data',
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              action: () {}),
                          SizedBox(
                            width: 10,
                          ),
                          IconAction(
                              icon: Icons.delete,
                              txt: 'Delete Dept',
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              action: () {})
                        ],
                      )*/
                    ],
                  ),
                ),
                FieldLabel(
                  field: 'اسم القسم :    ',
                  value: widget.item.name,
                  verfy: null,
                ),
                FieldLabel(
                  field: 'الفرع:  ',
                  value: widget.item.nameBrch + ' (code County)',
                  verfy: null,
                ),
                FieldLabel(
                  field: 'عدد الوظائف:  ',
                  value: widget.item.jobs.length.toString(),
                  verfy: null,
                ),
                SizedBox(
                  height: 10,
                )
              ]),
        ),
      ),
    ]);
  }
}
