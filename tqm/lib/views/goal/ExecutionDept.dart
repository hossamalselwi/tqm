import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/ExecuteDept.dart';

class ExecutionDeptList extends StatelessWidget {
  final ExecuteDeptModel executionOfficer;
  final Function(ExecuteDeptModel) onPressDelete;
  final Function(ExecuteDeptModel) onPressEdit;

  const ExecutionDeptList(
      {Key key, this.executionOfficer, this.onPressEdit, this.onPressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        executionOfficer.nameDept,
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
          await onPressDelete(executionOfficer);
        },
      ),
      onTap: () => onPressEdit(executionOfficer),
    );
  }
}
