import 'package:flutter/material.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

class CreateInboxView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customRedColor,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Text(
              'خروج',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        title: Text(
          'استراتيجية جديدة',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
//////////////////////
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
///////////////////
///
/////////
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
///////////////
///
///
///
///
///
///
///
///
///

/////////////////

////////////
///////////////
///
///
