import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/Goal.dart';

class GoalList extends StatelessWidget {
  final GoalModel goalModel;
  final Function(GoalModel) onPressDelete;
  final Function(GoalModel) onPressEdit;

  const GoalList(
      {Key key, this.goalModel, this.onPressEdit, this.onPressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        goalModel.name,
        textAlign: TextAlign.start,
        textDirection: TextDirection.rtl,
        softWrap: true,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.redAccent,
          textDirection: TextDirection.rtl,
          size: 36,
        ),
        onPressed: () async {
          await onPressDelete(goalModel);
        },
      ),
      onTap: () => onPressEdit(goalModel),
    );
  }
}
