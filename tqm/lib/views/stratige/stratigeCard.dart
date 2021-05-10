import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class TaskListTile extends StatelessWidget {
  TaskListTile({
    Key key,
    @required this.images,
    @required this.isCompleted,
    @required this.taskTitle,
    @required this.onTap,
  });

  final List<String> images;
  final bool isCompleted;
  final String taskTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Padding(
              padding: const EdgeInsets.only(top: 5),
              child: 
              CustomCheckBox(
                isChecked: isCompleted,
                onTap: (value) {
                  onTap(value);
                },
                uncheckedColor: customGreyColor,
                checkedColor: Colors.green,
                size: 27,
                checkedWidget: Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.green,
                ),
              ),
            ),*/
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '$taskTitle',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: images.length > 2 ? 100.0 : 60),
                child: Row(
                  children: [
                    Text(
                      'Due next week',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: customRedColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.more_vert,
                      color: customGreyColor,
                    ),
                  ],
                ))
          ],
        ),
      ],
    );
  }
}

class StrCard extends StatelessWidget {
  final StratigeModel model;

  const StrCard({
    Key key,
    this.model,
  }) : super(key: key);

  ListTile makeListTile(context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
        leading: FadeInImage.assetNetwork(
          alignment: Alignment.topCenter,
          placeholder: 'assets/image/defoult/placeholder-image.png',
          image: 'events[index].image',
          fit: BoxFit.fill,
          width: 70,
          // double.maxFinite,
          height: 55,
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 5.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 2.0, color: Colors.blue))),
              child: Column(
                children: <Widget>[
                  Text('Start :',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                  ),
                  Text('End : ',
                      style: TextStyle(fontSize: 11, color: Colors.white54)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                model.name.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(
                      Icons.timer_sharp,
                      color: Colors.white54,
                    ),
                    new Text(' عدد السنوات : 5} ',
                        style: TextStyle(color: Colors.white54),
                        textDirection: TextDirection.rtl),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  // tag: 'hero',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        'عدد الفروع : 3)',
                        style: TextStyle(fontSize: 10, color: Colors.white54),
                      ),
                      // new Icon(Icons.lightbulb_outline),
                    ],
                  ),

                  /*LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(255, 224, 224, 0.2),
                        value: 1.5,
                        valueColor: AlwaysStoppedAnimation(Colors.green)
                        
                        )*/
                )),
          ],
        ),
        isThreeLine: true,
        onTap: () {},
      );

  Card makeCard(BuildContext context) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return makeCard(context);
  }
}
