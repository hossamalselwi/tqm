import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/shared_widgets/customerFielsLable.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class JobCard {
  static Widget build(
      {JobsModel model,
      BuildContext context,
      Function(BuildContext context, JobsModel model) action}) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      Card(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  )),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 70,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            model.name,
                            style: TextStyle(fontSize: 15),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                              ),
                              onPressed: () {
                                action(context, model);
                              }),
                        ]),
                  ])))
    ]);
  }

  static Widget buildEmp(
      {JobsEmpModel model,
      BuildContext context,
      Function(BuildContext context, JobsEmpModel model) action}) {
    return Column(children: [
      SizedBox(
        height: 5,
      ),
      Card(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                  )),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 145,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            model.nameJob,
                            style:
                                TextStyle(fontSize: 18, color: customGreyColor),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                              ),
                              onPressed: () {
                                action(context, model);
                              }),
                        ]),
                    /* SizedBox(
                      height: 1,
                    ),*/
                    FieldLabel(
                      field: 'الفرع :',
                      value: model.nameBrch,
                      verfy: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    FieldLabel(
                      field: 'Dept  :',
                      value: model.namedept,
                      verfy: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ])))
    ]);
  }
}
