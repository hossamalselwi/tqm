import 'package:flutter/material.dart';
import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/views/shareView/customerDialogBox2.dart';

class DialogJobView {
  static Widget build(
      {JobsEmpModel model,
      String nameEmp,
      BuildContext context,
      String txtaction}) {
    Widget child = Column(
      children: [
        Text(
          'Job: ${model.nameJob.toString()}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'Dept : ${model.namedept.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        Divider(),
        Text(
          'Branch : ${model.nameBrch.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        Divider(),
        Text(
          ' الموظف : ${nameEmp.toString()}',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
              margin: EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  child,
                  SizedBox(
                    height: 22,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        onPressed: () {
                          //widget.action();
                          // Navigator.of(context).pop();
                        },
                        child: Text(
                          txtaction,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),

            /*  Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: Image.asset("assets/model.jpeg")),
          ),
        ),*/
          ],
        ));
  }

  /*static Widget build(
      {JobsEmpModel model, String nameEmp, BuildContext context}) {
    
    return CustomDialogBox2(
      context: context,
      child: cont,
      action: () {},
      txtaction: 'Delete Job',
    );
  }*/
}
