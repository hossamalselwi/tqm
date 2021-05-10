import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:strings/strings.dart';
import 'package:tqm/managers/task_manager.dart';
import 'package:tqm/models/task.dart';
import 'package:tqm/models/task_statistic.dart';
import 'package:tqm/services/StarigeService.dart';
import 'package:tqm/services/Stratege/stratigeService.dart';
import 'package:tqm/shared_widgets/custom_appbar_widget.dart';
import 'package:tqm/shared_widgets/empty_widget.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import '../../managers/StratigeManager.dart';
import '../../models/Stratige/Stratige.dart';

final StratigeService _staratigeService = new StratigeService();

final TaskManager _taskManager = TaskManager();

class OverView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'نظرة عامة ',
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          StreamBuilder<List<StratigeModel>>(
              stream: _staratigeService.getData().asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return LinearProgressIndicator(
                    minHeight: 2,
                  );
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasData) {
                  return SizedBox.shrink();
                }

                if (snapshot.data == null) {
                  return SizedBox.shrink();
                }
                return Column(
                  children: [
                    Container(
                        color: customGreyColor.withOpacity(.1),
                        height: 45,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        width: size.width,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'الاستراتيجيات الحالية',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 140,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              for (int i = 0; i < snapshot.data.length; i++)
                                HomeTaskCountCard(
                                    model: snapshot.data[i],
                                    size: size,
                                    image: 'dots.png',
                                    color: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)])
                            ]),
                      ),
                    ),
                  ],
                );
              }),
          Container(
            color: customGreyColor.withOpacity(.1),
            height: 45,
            width: size.width,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'مهمات الشهر الحالي (Soon)',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<Task>(
              stream: _taskManager.getTasks().asStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return Center(child: CupertinoActivityIndicator());
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasData) {
                  return EmptyView(
                    title: 'لا مهمات في الشهر الحالي',
                  );
                }

                if (snapshot.data == null) {
                  return EmptyView(
                    title: 'لا مهمات في الشهر الحالي',
                  );
                }
                return ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String date = snapshot.data.data[index].dueDate;
                      List<String> dateList = date.split(' ');
                      return HomeTaskSummary(
                        size: size,
                        priority:
                            camelize(snapshot.data.data[index].priorityLevel),
                        time:
                            '${UiUtilities().twenty4to12conventer(dateList[1])}',
                        title: snapshot.data.data[index].description,
                      );
                    },
                    itemCount: snapshot.data.data.length);
              })
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: customRedColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () =>
            Navigator.pushReplacementNamed(context, '/createNewTaskView'),
      ),*/
    );
  }
}

class HomeTaskSummary extends StatelessWidget {
  const HomeTaskSummary({
    Key key,
    @required this.size,
    @required this.title,
    @required this.priority,
    @required this.time,
  }) : super(key: key);

  final Size size;
  final String title;
  final String priority;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 10),
      child: Card(
        elevation: 0,
        color: priority == 'Low'
            ? Color.fromRGBO(236, 249, 245, 1)
            : priority == 'Medium'
                ? Color.fromRGBO(251, 245, 225, 1)
                : Color.fromRGBO(252, 244, 248, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 80,
                decoration: BoxDecoration(
                    color: priority == 'Low'
                        ? Colors.green
                        : priority == 'Medium'
                            ? Colors.amber
                            : Colors.red,
                    borderRadius: BorderRadius.circular(45)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: size.width - 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$priority Priority',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: priority == 'Low'
                                  ? Colors.green
                                  : priority == 'Medium'
                                      ? Colors.amber
                                      : Colors.red,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              AntDesign.clockcircleo,
                              color: customGreyColor,
                              size: 15,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              time,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: customGreyColor,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width - 90,
                    child: Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeTaskCountCard extends StatelessWidget {
  const HomeTaskCountCard({
    Key key,
    @required this.size,
    @required this.image,
    this.color,
    this.model,
  }) : super(key: key);

  final StratigeModel model;

  final Size size;

  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(.5),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 150,
        width: size.width / 3 - 10, //- 32,
        child: Stack(
          children: [
            /* Positioned(
                top: 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/$image',
                      fit: BoxFit.cover,
                    ))),*/
            Positioned(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 130,
                width: size.width / 3 - 10, //- 32,
                color: Colors.black87.withOpacity(.3),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${model.name.toString()}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        'تاريخ الادخال ',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w600,
                            color: color,
                            fontSize: 11),
                      ),
                      Text(
                        '',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.normal,
                            color: color,
                            fontSize: 11),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.timelapse_outlined),
                      Text(
                        '5 Years',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w900,
                            color: color,
                            fontSize: 12),
                      ),
                      Text(
                        '${model.dateEnter.toString()}',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.normal,
                            color: color,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/////////////////////
///
//////////
///
///
///
///
///
///
