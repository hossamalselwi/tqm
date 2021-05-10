import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/dept.dart' as dept;
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import '../../views/shareView/IconAction.dart';

class DeptCardView extends StatefulWidget {
  final dept.Data item;
  final String op;
  final Function(BuildContext, dept.Data) deleteAction;

  DeptCardView({Key key, this.item, this.deleteAction, this.op = 'ALL'})
      : super(key: key);
  @override
  _DeptCardViewState createState() => _DeptCardViewState();
}

class _DeptCardViewState extends State<DeptCardView> {
  int currentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.item.jobs.length > 0
                  ? Colors.green
                  : Colors.limeAccent,
            )),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 170,
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
                            txt: 'حذف القسم',
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            action: () {
                              widget.deleteAction(context, widget.item);
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
                      Text(widget.item.name.toString(),
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
                                widget.item.id.toString(),
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
                                'مهام القسم ',
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
              widget.op == 'ALL'
                  ? Container(
                      width: 100,
                      // height: 100,
                      decoration: BoxDecoration(
                          //color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          text: 'الفرع :',
                        ),
                        TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          text: widget.item.nameBrch.toString(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {},
                        ),
                      ])))
                  : Container(),
              Divider(),
              Column(children: [
                Divider(
                  color: Colors.grey[400],
                  height: 0.5,
                ),
                Text(
                  'وظائف القسم :',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.normal, fontSize: 11),
                ),
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
              ])
            ]),
      ),
    );
  }
}
