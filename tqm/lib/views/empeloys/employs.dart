import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sample_data/avatars.dart';
import 'package:tqm/models/empModel.dart';
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/services/empService.dart';
import 'package:tqm/services/jobDeptService.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/search/search_view.dart';
import '../../shared_widgets/empty_widget.dart';

import 'EmpCard.dart';

EmpService _empService = EmpService();
JobDeptService _jobService = JobDeptService();

class EmpsView extends StatefulWidget {
  @override
  _JobsAllViewState createState() => _JobsAllViewState();
}

class _JobsAllViewState extends State<EmpsView> {
  Future<List<EmpModel>> data;
  List<JobsModel> options;

  @override
  void initState() {
    super.initState();
    getData();
  }

  int currentIndex = -1;
  getData() async {
    //options = await _jobService.getAll();
    setState(() {
      //options = await _jobService.getAll();
      data = _empService.getData();
    });
  }

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return AppBar(
        centerTitle: false,
        leading: Container(),
        title: Text(
          'الموظفين',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchView(),
                );
              }),
          PopupMenuButton(
            itemBuilder: (context) {
              var list = <PopupMenuEntry<Object>>[];
              list.addAll([
                PopupMenuItem(
                  child: Text("By Job ",
                      style: Theme.of(context).textTheme.bodyText1),
                  value: 1,
                ),
                PopupMenuDivider(
                  height: 10,
                ),
                PopupMenuItem(
                  child: Text(
                    "By Dept ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: 2,
                ),
                PopupMenuDivider(
                  height: 10,
                ),
                PopupMenuItem(
                  child: Text(
                    "By Branch ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: 2,
                ),
              ]);
              return list;
            },
            onSelected: (value) {},
            icon: Icon(Icons.sort),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              var list = <PopupMenuEntry<Object>>[];
              list.addAll([
                PopupMenuItem(
                  child: Text("جلب من ملف اكسل ",
                      style: Theme.of(context).textTheme.bodyText1),
                  value: 1,
                ),
                PopupMenuDivider(
                  height: 10,
                ),
                PopupMenuItem(
                  child: Text(
                    "استخراج ",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: 2,
                )
              ]);
              return list;
            },
            onSelected: (value) {},
            icon: Icon(Icons.more_vert),
          )
        ],
      );
    }

    void routToAddJob(EmpModel model) {
      Navigator.of(context)
          .pushNamed(
        '/jobEmpView',
        arguments: model,
      )
          .then((value) {
        getData();
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: customRedColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(
              '/empDetials',
              arguments: new EmpModel(
                  id: '-1',
                  address: '',
                  email: '',
                  docs: [],
                  name: '',
                  numIdityfy: '',
                  phone: ''),

              // arguments: snapshot.data[index],
            )
                .then((value) {
              getData();
            });
            //showD(model, 'NEW');
          }),
      appBar: AppBar(
        title: appBar(),
        /*  bottom: 
        PreferredSize(
          preferredSize:
              Size(MediaQuery.of(context).size.width, kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    options.length,
                    (index) => Padding(
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
                                  options[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: currentIndex == index
                                              ? customRedColor
                                              : customGreyColor),
                                )),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ),
      */
      ),
      body: Container(
        //padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<EmpModel>>(
                  stream: data.asStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<EmpModel>> snapshot) {
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
                              title: 'لا موظفين مضافين بعد',
                            );
                          }

                          return ListView.separated(
                              //padding: EdgeInsets.all(),
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(
                                      '/empDetials',
                                      arguments: snapshot.data[index],
                                    )
                                        .then((value) {
                                      getData();
                                    });
                                  },
                                  child: EmpCardView(
                                    empModel: snapshot.data[index],
                                    addjobClick: routToAddJob,
                                    //press: () {},
                                  ),
                                );
                                // bodyItem(snapshot.data[index]);
                              });
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
//////////
///
///
///
///
///
///
