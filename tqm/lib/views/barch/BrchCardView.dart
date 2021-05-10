import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/views/auth/widget/imageWidget.dart';
import 'package:tqm/views/dept/deptView.dart';
import '../../views/shareView/IconAction.dart';

class BrchCardView extends StatefulWidget {
  final Barch item;
  final Function(BuildContext, Barch) deleteAction;
  final Function editAction;

  const BrchCardView({Key key, this.item, this.deleteAction, this.editAction})
      : super(key: key);
  @override
  _BrchCardViewState createState() => _BrchCardViewState();
}

class _BrchCardViewState extends State<BrchCardView> {
  @override
  Widget build(BuildContext context) {
    return
        /*Column(children: [
      SizedBox(
        height: 10,
      ),*/
        Card(
      child: Container(
        height: 140,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'الدولة: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.item.countryid,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                        //fontSize: 14,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'المدينة: ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.item.city,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                        //fontSize: 14,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.transparent)),
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: widget.item.countDepts > 0
                                  ? Colors.green
                                  : Colors.lime[300],
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${widget.item.name.toString()}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      /* Row(
                        children: <Widget>[
                          Text(
                            'id: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            widget.item.id,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),*/
                      SizedBox(
                        height: 8,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          text: 'عنوان الفرع :',
                        ),
                        TextSpan(
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                          text: widget.item.address,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {},
                        ),
                      ])),
                      Container(
                          // padding: EdgeInsets.symmetric(horizontal: 20),
                          //margin: EdgeInsets.only(bottom: 20),
                          height: 20,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                              text:
                                  'عدد الاقسام : ${widget.item.countDepts.toString()} ',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DeptView(
                                              brch: widget.item,
                                              op: 'ONE',
                                            )),
                                  );
                                },
                            ),
                          ]))),
                    ],
                  ),
                ),

                //)
              ),
              Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: hero(
                    context,
                    extraTag: widget.item.id,
                    path: widget.item.image.toString(),
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(),
                /* IconAction(
                    icon: Icons.settings,
                    txt: '',
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    action: () {
                      widget.editAction();
                    }),*/
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconAction(
                        icon: Icons.edit,
                        txt: 'تعديل بيانات الفرع',
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        action: () {
                          widget.editAction();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    IconAction(
                        icon: Icons.delete,
                        txt: 'حذف الفرع',
                        color: Colors.grey[500],
                        // fontWeight: FontWeight.bold,
                        action: () {
                          widget.deleteAction(context, widget.item);
                        })
                  ],
                )
              ],
            ),
          ),

          // )
        ]),
      ),
    )
        //]);
        ;
  }
}
