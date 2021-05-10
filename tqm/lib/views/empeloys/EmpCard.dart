import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sample_data/avatars.dart';
import 'package:tqm/models/empModel.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/job/DialogJob.dart';
import 'package:flutter/cupertino.dart';
import '../../shared_widgets/customerFielsLable.dart';

class EmpCardView extends StatefulWidget {
  final EmpModel empModel;
  final Function addjobClick;

  const EmpCardView({
    Key key,
    @required this.empModel,
    this.addjobClick,
  }) : super(key: key);

  @override
  _EmpCardViewState createState() => _EmpCardViewState();
}

int _currentIndex = 0;

class _EmpCardViewState extends State<EmpCardView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            )),
        width: MediaQuery.of(context).size.width,
        height: widget.empModel.jobs.length > 0 ? 180 : 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                child: CircleAvatar(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)]
                      .withOpacity(.2),
                  radius: 25,
                  backgroundImage:
                      ExactAssetImage(kidsAvatar(), package: 'sample_data'),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'رقم الهوية: ',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 11,
                                      /*color: 
                                      Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)]*/
                                    ),
                          ),
                          /* CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors
                                      .primaries[Random().nextInt(Colors.primaries.length)],
                                ),*/
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.empModel.numIdityfy.toString(),
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    //Spacer(),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            size: 15,
                            color: kTextColor,
                          ),
                          Text(
                            widget.empModel.phone != '' ||
                                    widget.empModel.phone != null
                                ? '${widget.empModel.phone.toString()}'
                                : ' غير معروف',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontSize: 11,
                                    color: widget.empModel.phone != '' ||
                                            widget.empModel.phone != null
                                        ? Colors.green
                                        : customGreyColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
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
                              backgroundColor: widget.empModel.jobs.length > 0
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
                            widget.empModel.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          widget.addjobClick(widget.empModel);
                        },
                        child: Material(
                          color: customRedColor,
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                            child: Row(
                              children: [
                                Text(
                                  'Add Job',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(
                                  Ionicons.ios_add,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FieldLabel(
                          field: 'Email: ',
                          value: widget.empModel.email.toString(),
                        ),
                        FieldLabel(
                          field: 'عدد الوظائف: ',
                          value: widget.empModel.jobs.length.toString(),
                        ),
                      ])
                ],
              ),
              // trailing: ,
            ),
            Row(
              children: [
                /* CircleAvatar(
                  backgroundColor: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)]
                      .withOpacity(.2),
                  radius: 25,
                  backgroundImage:
                      ExactAssetImage(kidsAvatar(), package: 'sample_data'),
                ),
                SizedBox(
                  width: 10,
                ),*/

                Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 2),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Text(
                      'عنوان الموظف: ${widget.empModel.address.toString()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                  ),
                ),

                /* Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(

                      width: MediaQuery.of(context).size.width - 120,
                      child: Text(
                        'عنوان الموظف: ${widget.empModel.address.toString()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 11),
                      ),
                    ),
                  ],
                )*/
              ],
            ),
            widget.empModel.jobs.length > 0
                ? Column(
                    children: [
                      Divider(
                        color: Colors.grey[400],
                        height: 0.5,
                      ),
                      Text(
                        'وظائف الموظف :',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 11),
                      ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.empModel.jobs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _currentIndex = index;
                                  });

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogJobView.build(
                                          context: context,
                                          txtaction: 'Delete Job',
                                          model: widget.empModel.jobs[index],
                                          nameEmp: widget.empModel.name,
                                        );
                                      });
                                },
                                child: Material(
                                  color: _currentIndex == index
                                      ? customRedColor.withOpacity(.2)
                                      : customGreyColor.withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      widget.empModel.jobs[index].nameJob,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              color: _currentIndex == index
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
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
//////////////////////////
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
///////////////////////////////////////
///
///
///
///
///
///
