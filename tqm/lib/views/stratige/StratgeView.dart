import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/services/Stratege/stratigeService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/shareView/IconAction.dart';
import 'package:tqm/views/stratige/stratigeCard.dart';

StratigeService _stratigeService = StratigeService();

class StratigeView extends StatefulWidget {
  @override
  _StratgeViewState createState() => _StratgeViewState();
}
/////////////////////
///

class _StratgeViewState extends State<StratigeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController controller;
  Future<List<StratigeModel>> data;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    getData();
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
        for (int i = 0; i < 10; i++) {}
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  getData() async {
    setState(() {
      data = _stratigeService.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget iii = StreamBuilder<List<StratigeModel>>(
      stream: data.asStream(),
      //initialData: StrViewModel.getData(),
      builder:
          (BuildContext context, AsyncSnapshot<List<StratigeModel>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          return StateNetWork.hasErrorStrWidegt('Error: ${snapshot.error}');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return StateNetWork.connectionNoneWidegt();
              break;
            case ConnectionState.waiting:
              return StateNetWork.connectionWaitWidegt();
              break;
            case ConnectionState.active:
              return StateNetWork.connectionActiveWidegt('\$${snapshot.data}');

              break;
            case ConnectionState.done:
              return
                  /*RefreshIndicator(
                onRefresh: _refresh,
                child: 
                */
                  ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      padding: EdgeInsets.all(24),
                      itemCount: snapshot.data.length,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return strCard(
                          snapshot.data[index],
                        );
                        /* StrCard(
                        model: snapshot.data[index],
                      );*/
                      });
              //);

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
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          hoverColor: bBasicColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(
              '/AddStratigeView',
            )
                .then((value) {
              getData();
            });
          }),
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
        'الاستراتيجية',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold),
      )),
      body: Container(
        child: SafeArea(
          right: false,
          child: Column(
            children: [
              /* Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child:
                 Row(
                  children: [],
                ),
              ),*/
              SizedBox(height: kDefaultPadding),
              Expanded(child: iii),
            ],
          ),
        ),
      ),
    );
  }
}

Widget strCard(StratigeModel model) {
  return Card(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: model.goals.length > 0 ? Colors.green : Colors.limeAccent,
          )),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 120,
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /* IconAction(
                            icon: Icons.edit,
                            txt: 'Edit Dept Data',
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            action: () {}),*/
                      SizedBox(
                        width: 10,
                      ),
                      IconAction(
                          icon: Icons.delete,
                          txt: 'حذف الاستراتيجية',
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                          action: () {
                            // widget.deleteAction(context, widget.item);
                          })
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    /*Text(
                        'Name:',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),*/
                    Text(model.name.toString(),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                        //fontSize: 14,
                        ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              'ID:',
                              style: TextStyle(
                                color: Colors.black12,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              model.id.toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                              //fontSize: 14,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ملف الاستراتيجية ',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'null.Pdf',
                              //fontSize: 14,
                            ),
                          ],
                        ),
                      ],
                    ),
                    /*RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            text: 'Address :',
                          ),
                          TextSpan(
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                            text: widget.item.address,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {},
                          ),
                        ]))*/
                  ],
                ),
              ),

              //)
            ),
            Divider(),
            Column(children: [
              Divider(
                color: Colors.grey[400],
                height: 0.5,
              ),
              /* Text(
                  'وظائف القسم :',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                ),*/

              /*
                Container(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.item.jobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Material(
                            color: currentIndex == index
                                ? customRedColor.withOpacity(.2)
                                : customGreyColor.withOpacity(.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                widget.item.jobs[index].name.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        color: currentIndex == index
                                            ? customRedColor
                                            : customGreyColor),
                              )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              */
            ])
          ]),
    ),
  );
}

/////////////
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
