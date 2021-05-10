import 'package:flutter/material.dart';
import '../../../models/barch.dart';
import '../../../services/barchService.dart';

class BrchDialog extends StatefulWidget {
  BrchDialog({this.context, this.onOk});

  final BuildContext context;
  final Function onOk;

  @override
  _BrchDialogState createState() => _BrchDialogState();
}

class _BrchDialogState extends State<BrchDialog> {
  List<Barch> dataAll = new List<Barch>();

  List<Barch> data = new List<Barch>();
  int count;

  BrchSerivce _brchSerivce = BrchSerivce();

  @override
  void initState() {
    geta();
    super.initState();
  }

  Future geta() async {
    dataAll = await _brchSerivce.getAll();

    setState(() {
      count = data.length;
    });
  }

  void showDialogBrch() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(15),
                            topRight: const Radius.circular(15)),
                      ),
                      child: Text(
                        "فروع الاستراتيجية ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 400,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int i) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              // vertical: 10
                            ),
                            //height: 170,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 40.0,
                                  height: 50.0,
                                  child: Image.asset(
                                      'assets/image/defoult/no0image.jpg'),
                                ),
                                Text(dataAll[i].name),
                                Checkbox(
                                  value: dataAll[i].isSelect == null
                                      ? false
                                      : dataAll[i].isSelect,
                                  onChanged: (bool value) {
                                    setState(() {
                                      dataAll[i].isSelect = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: dataAll.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          //color: Colors.blue,
                          onPressed: () {
                            var seliset = dataAll
                                .where((element) => element.isSelect == true)
                                .toList();
                            setState(() {
                              count = seliset.length;
                            });

                            dataAll.removeWhere(
                                (element) => element.isSelect == true);

                            Navigator.of(context).pop();
                            widget.onOk(seliset);
                          },
                          child: Text(
                            'اضافة للاستراتيجية',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RaisedButton(
                          // color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'الغاء',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('فروع الاستراتيجية العدد :'),
              Expanded(child: Text('$count')),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    showDialogBrch();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ],
          ),
          Divider(),

          /* for (int i = 0; i < count; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10,left:10 ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (newValue) {},
                      ),
                      Text(data[i].name),
                       Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            data.removeAt(i);
                            //widget.data.countTime=widget.data.years.length;

                          });
                        },
                        child: 
                       CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: Icon(
                            Icons.minimize,
                            size: 16,
                            color: Colors.black,
                          ) ,
                        ),
                      ),
                    ],
                  ),
                ),
            */
        ],
      ),
    );
  }
}
