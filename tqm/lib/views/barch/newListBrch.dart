import 'package:flutter/material.dart';

import 'BarchOne.dart';
import '../../services/barchService.dart';
import '../../models/barch.dart';
import '../../models/barch.dart';
import '../../utils/network_utils/StateAPi.dart';
import '../../utils/ui_utils/custom_colors.dart';
import '../../views/shareView/appBar.dart';

import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:bot_toast/bot_toast.dart';

import 'BrchCardView.dart';

import 'package:tqm/views/shareView/customDialogBoxs.dart';
import 'package:tqm/views/dept/deptView.dart';
import '../../shared_widgets/empty_widget.dart';

class BrshView extends StatefulWidget {
  const BrshView({
    Key key,
  }) : super(key: key);

  @override
  _ListBrshState createState() => _ListBrshState();
}

class _ListBrshState extends State<BrshView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController controller;

  List<Barch> data = List<Barch>();
  //
  BrchSerivce brchService = BrchSerivce();

  getData() async {
    data = await brchService.getAll();
  }

  @override
  void initState() {
    /* 
if(EmpViweModel.dataApi==null)
{
  EmpViweModel.getData();
}*/
    getData();
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(controller.position.extentAfter);

    //if (controller.position.extentAfter < 500)
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        for (int i = 0; i < 10; i++) {
          data.add(new Barch(
            id: i.toString(),
            address: "address New ",
            email: "email@New",
            name: 'name emp',
            city: 'City',
            image: null,
          ));
        }

        /*  Fluttertoast.showToast(
            msg: ' عدد السجلات  ${BrchViewModel.dataApi.length.toString()} ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,

            // timeInSecForIos: 1,
            fontSize: 16.0);
      });*/
      });
    }
  }

  //
  /* _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("reach the bottom");
        fetchPost(gcm);
      });
    }
  }
*/

  Future<void> _refresh() async {
    //List<Brew> tempList = await DatabaseService().brews;

    setState(() async {
      data = await brchService.getAll();
    });
    // print(brews);
  }

  _delete(String id) async {
    final UiUtilities uiUtilities = UiUtilities();

    try {
      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);

      bool s = await brchService.delete(id);
      BotToast.closeAllLoading();

      if (s) {
        setState(() {
          brchService.getAll();

          uiUtilities.alertNotification(
              context: context, message: 'تم حدف الفرع :($id )');

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

  showAlertDialog(BuildContext context, Barch model) {
    Widget child = Column(children: [
      Text(
        'الفرع: ${model.name.toString()}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        'عدد الاقسام : ${model.countDepts.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        'الدولة : ${model.countryid.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        ' المدينة: ${model.city.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
      ),
      Divider(),
      Text(
        ' Address: ${model.address.toString()}',
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 5,
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
        'هل انت متأكد من حذف الفرع',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        ' احذر قد تفقد جميع بيانات الاقسام لهذا الفرع',
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

  @override
  Widget build(BuildContext context) {
    var widht = MediaQuery.of(context).size.width;

    Widget iii = StreamBuilder<List<Barch>>(
      stream: brchService.getAll().asStream(),
      //initialData: BrchViewModel.dataApi,
      builder: (BuildContext context, AsyncSnapshot<List<Barch>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          return StateNetWork.hasErrorStrWidegt('Error: ${snapshot.error}');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return StateNetWork.connectionNoneWidegt();
              break;
            case ConnectionState.waiting:
              {
                return StateNetWork.connectionWaitWidegt();
              }

              break;
            case ConnectionState.active:
              return StateNetWork.connectionActiveWidegt('\$${snapshot.data}');

              break;
            case ConnectionState.done:
              {
                if (snapshot.data.length == 0) {
                  return EmptyView(
                    title: 'لا فروع مضافة بعد',
                  );
                }

                return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.separated(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeptView(
                                          brch: snapshot.data[i],
                                          op: 'ONE',
                                        )),
                              );
                              /*
                              Navigator.of(context).pushNamed('/barchPage',
                                  arguments: snapshot.data[i]);*/
                            },
                            child: BrchCardView(
                              item: snapshot.data[i],
                              editAction: () {
                                Navigator.of(context).pushNamed('/barchPage',
                                    arguments: snapshot.data[i]);
                              },
                              deleteAction: (rr, dd) {
                                showAlertDialog(rr, dd);
                              },
                            )
                            //bodyData(snapshot.data)
                            );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    ));
              }

              break;
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );
      },
    );

    return Scaffold(
      appBar: appBarOne(context, 'الفروع'),
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(
                  '/barchPage',
                  arguments: new Barch(
                    id: '0',
                    address: '',
                    email: '',
                    name: '',
                  ),

                  // arguments: snapshot.data[index],
                )
                .then((value) => brchService.getAll());

            // showD(model, 'NEW');
          }),
      body: Column(
        children: [
          /*
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2), color: Colors.grey),
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
                            "رقم الفرع ",
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
                          "اسم الفرع  ",
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
              */
          Expanded(child: iii),
        ],
      ),
    );
  }
}
