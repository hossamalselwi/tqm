import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqm/managers/nameDeptmanager.dart';
import 'package:tqm/models/dept.dart';
import 'package:tqm/models/docsModel.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/search/search_view.dart';
import 'package:tqm/views/shareView/FormText.dart';
import '../../services/namesDept.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:tqm/views/shareView/customDialogBoxs.dart';

class DeptNameView extends StatefulWidget {
  @override
  DataTableViewState createState() {
    return new DataTableViewState();
  }
}

//bool isNotSearch = true;

class DataTableViewState extends State<DeptNameView> {
  var your_number_of_rows = 4;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  Data model = Data();

  NameDeptManager manager = NameDeptManager();

  //data.length;

  Widget bodyData() => DataTable(
        dividerThickness: 1,
        showBottomBorder: true,
        onSelectAll: (b) {},
        sortColumnIndex: 1,
        sortAscending: true,
        showCheckboxColumn: false,
        columnSpacing: MediaQuery.of(context).size.width / 8,

        //dividerThickness: 2,
        headingRowHeight: 50,
        dataRowHeight: 50,
        // showBottomBorder: true,

        columns: <DataColumn>[
          /* DataColumn(
            label: Text("الرقم"),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                data.sort((a, b) => a.id.compareTo(b.id));
              });
            },
            tooltip: "To display first name of the Name",
          ),*/
          DataColumn(
            label: Text("القسم"),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                data.sort((a, b) => a.name.compareTo(b.name));
              });
            },
            tooltip: "اسم القسم",
          ),
          DataColumn(
            label: Text("مهام القسم"),
            numeric: false,
            onSort: (i, b) {
              setState(() {
                data.sort((a, b) => a.fileTask.compareTo(b.fileTask));
              });
            },
            tooltip: "مهام القسم",
          ),
          DataColumn(
            label: Text("عمليات"),
            numeric: false,
            onSort: (i, b) {
              // setState(() {});
            },
            tooltip: "عمليات",
          ),
        ],
        rows: data
            .map(
              (name) => DataRow(
                onSelectChanged: (sel) {
                  model = name;
                  showD('EDIT');
                },
                cells: [
                  /* DataCell(
                    Text(name.id.toString()),
                    showEditIcon: false,
                    placeholder: false,
                  ),*/
                  DataCell(
                    Text(name.name),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text('${name.fileTask.toString()}.pdf'),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showAlertDialog(context, name);
                            // showCuatomerDialgo(context, name, true);
                          },
                          child: Icon(Icons.delete),
                        )
                      ],
                    ),
                    showEditIcon: false,
                    placeholder: false,
                  )
                ],
              ),
            )
            .toList(),
      );

  List<Data> data = List<Data>();

  Future<dynamic> getAll() async {
    Dept data1 = await deptmanager.getA();

    if (data1 != null)
      setState(() {
        data = data1.data;
      });
  }

  final NameDeptManager deptmanager = NameDeptManager();

  _delete(int id) async {
    final UiUtilities uiUtilities = UiUtilities();

    try {
      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);

      String s = await deptmanager.deleteName(id);
      BotToast.closeAllLoading();

      if (s == 'Succ') {
        setState(() {
          getAll();

          uiUtilities.alertNotification(
              context: context, message: 'تم حدف القسم :($id )');

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

  final myController = TextEditingController();

  @override
  initState() {
    getAll();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  showAlertDialog(BuildContext context, Data model) {
    // set up the button

    Widget child = Column(children: [
      Text(
        'Dept Name: ${model.name.toString()}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
        'هل انت متأكد من حذف مسمى القسم',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        ' احذر سيتم حذف جميع اقسام الفروع لهذا الاسم',
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

  _sendToServer(String op) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool sata = false;
        if (op == 'NEW') {
          model.id = 0;
          sata = await manager.createNameDept(model: model);
        } else
          sata = await manager.updateName(model);
        BotToast.closeAllLoading();
        if (sata) {
          uiUtilities.alertNotification(
              context: context, message: 'تم حفظ القسم ');
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

  showD(String op) {
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
                    FormText.textFormF(context, model.name, 'اسم القسم', null,
                        FormValidator().validateisEmpty, (String value) {
                      // setState(() {
                      model.name = value;
                      // });
                    }, 'اسم القسم', null),
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
                          _sendToServer(op);

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

  @override
  Widget build(BuildContext context) {
    //var rowHeight = (MediaQuery.of(context).size.height - 56) / your_number_of_rows;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: customRedColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showD('NEW');
            }),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.white24,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
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
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      data.length == 0
                          ? StateNetWork.connectionWaitWidegt()
                          : bodyData(),
                    ],
                  ),
                ],
              )),
        ));
  }
}

List<DocsModel> docs = [
  new DocsModel(
      id: '49',
      name: '',
      path:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/OOjs_UI_icon_add.svg/1024px-OOjs_UI_icon_add.svg.png'),
  new DocsModel(
      id: '62',
      name: 'دكومنت1',
      path:
          'https://icons.iconarchive.com/icons/zhoolego/material/512/Filetype-Docs-icon.png',
      typefile: 'PNG'),
  new DocsModel(
      id: '63',
      name: 'دكومنت2',
      path:
          'https://www.ghrd.org/wp-content/uploads/2020/09/833px-pdf_file_icon.svg_.png',
      typefile: 'PDF'),
  new DocsModel(
      id: '416',
      name: 'doc3 ',
      path:
          'https://icon-library.com/images/add-file-icon/add-file-icon-29.jpg',
      typefile: 'JPG'),
];

//
//

//
/////////////////////
///
////////////////////
///
///
///
