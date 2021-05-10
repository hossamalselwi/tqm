import 'package:flutter/material.dart';
import '../../utils/ui_utils/custom_colors.dart';
import 'deptname.dart';
import 'jobsname.dart';

class HomeNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          //  backgroundColor: customRedColor,
          bottom: TabBar(
            labelColor: bBasicColor,
            indicatorColor: bBasicColor,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.symmetric(vertical: 5),

            // isScrollable: true,
            tabs: [
              Text(
                'الاقسام ',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: bBasicColor),
              ),
              Text(
                'الوظائف ',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: bBasicColor),
              ),
            ],
          ),
          title: Text(
            'المسميات',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, color: bBasicColor),
          ),
        ),
        body: TabBarView(
          children: [DeptNameView(), JobsNamsView()],
        ),
      ),
    );
  }
}
