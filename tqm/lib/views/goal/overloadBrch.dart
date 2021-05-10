import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/Overload.dart';

import 'package:tqm/models/Stratige/Unit.dart';
import 'package:tqm/services/Stratege/UnitsService.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'goalView.dart';
import 'package:tqm/services/Stratege/customerService.dart';

class BrunchLoadList extends StatelessWidget {
  final OverloadModel brchSrt;
  final Function(OverloadModel) onPressMCycle;

  const BrunchLoadList({Key key, this.brchSrt, this.onPressMCycle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(1.0),
      child: Row(
        children: [
          Container(
            width: 65,
            alignment: Alignment.center,
            child: Text(brchSrt.nameBrch.toString()),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1), left: BorderSide(width: 1)),
              ),
              padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
              child: FormText.textFormF(
                context,
                //null,
                brchSrt.qty.toString(),
                'نسبة التحمل',
                null,
                FormValidator().validateNumberNonZero,
                (value) => brchSrt.qty = double.parse(value),
                'نسبة التحمل',
                null,
                [TextInputType.number],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            child: RaisedButton(
              color: Colors.blue,
              child: Text('دورات القياس'),
              onPressed:
                  brchSrt.finishMCycle ? null : () => onPressMCycle(brchSrt),
            ),
          ),
        ],
      ),
    );
  }
}
