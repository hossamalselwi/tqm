import 'package:flutter/material.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class OrgTags extends StatelessWidget {
  OrgTags({
    Key key,
  }) : super(key: key);

  //Color kGrayColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            //Icon(Icons.o, size: 16),

            SizedBox(width: 5),
            //Icon(Icons.app_blocking, size: 20),

            SizedBox(width: 9),
            Text(
              "المنشأة",
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: bBasicColor),
            ),
            Spacer(),
            /*MaterialButton(
              padding: EdgeInsets.all(10),
              minWidth: 40,
              onPressed: () {},
              child: Icon(
                Icons.add,
                color: kGrayColor,
                size: 20,
              ),
            )*/
          ],
        ),
        SizedBox(height: 5),
        buildTag(context,
            color: Color(0xFF23CF91),
            title: "المسميات",
            routePage: '/homeNames'),
        buildTag(context,
            color: Color(0xFF3A6FF7), title: "الفروع", routePage: '/brshView'),
        buildTag(context,
            color: Color(0xFFF3CF50), title: "الاقسام", routePage: '/deptView'),
        /* buildTag(context,
            color: Color(0xFFF3CF50),
            title: "الوظائف",
            routePage: '/jobView'), */
        buildTag(context,
            color: Color(0xFF8338E1),
            title: "الموظفين",
            routePage: '/empsView'),
      ],
    );
  }

  InkWell buildTag(BuildContext context,
      {@required Color color, @required String title, String routePage}) {
    //
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routePage);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
        child: Row(
          children: [
            SizedBox(width: 15),
            //Icon(Icons.app_blocking, size: 20),
            SizedBox(width: 15),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: bBasicColor),
            ),
          ],
        ),
      ),
    );
  }
}

/////
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
///
///
///
///
///
///
