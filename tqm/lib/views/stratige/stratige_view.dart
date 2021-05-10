/*import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sample_data/avatars.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;

class StratigeView1 extends StatefulWidget {
  @override
  _StratigeViewState createState() => _StratigeViewState();
}

class _StratigeViewState extends State<StratigeView1> {
  final List<String> options = [
    'الكل ',
    'الحالية',
    'منتهية',
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاستراتيجية',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
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
                                  options[index],
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
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(24),
          itemBuilder: (context, index) => Divider(
                height: 3,
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: 5),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customRedColor,
        child: Icon(
          MaterialCommunityIcons.chat_outline,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pushNamed('/createInboxView'),
      ),
    );
  }
}
*/
/////////////
///
///
//////////////
///
///
///
///
///
///

////////
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

//////////////////////
///
///
///
///
///
///
///
