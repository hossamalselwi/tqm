import 'package:flutter/material.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class SideMenuItem extends StatelessWidget {
  SideMenuItem({
    Key key,
    this.isActive,
    this.isHover = false,
    //this.itemCount,
    this.showBorder = true,
    @required this.title,
    @required this.press,
    this.icon,
  }) : super(key: key);

  final bool isActive, isHover, showBorder;
  //final int itemCount;
  String title;
  final VoidCallback press;

  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding / 4),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            /*(isActive || isHover)
                ? Icon(
                    Icons.circle,
                    size: 8,
                    color: bBasicColor,
                  )
                : SizedBox(width: 15),*/
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 5),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    icon,

                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: (isActive || isHover)
                                ? customRedColor
                                : bBasicColor,
                          ),
                    ),
                    Spacer(),
                    //if (itemCount != null)
                    // CounterBadge(count: itemCount)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////
////////////////////////
///
///
///
///
///
////////////////
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
///

////////////////
///
///
///
///
///
///
///

//////////////////
///
///
/////
///
///
///
///
///
///
///
///
