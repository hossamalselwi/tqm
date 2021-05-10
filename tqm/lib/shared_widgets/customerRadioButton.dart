import 'package:flutter/material.dart';

class RaioButton extends StatefulWidget {
  final Function onChange;

  const RaioButton({Key key, @required this.onChange}) : super(key: key);

  @override
  _RaioButtonState createState() => _RaioButtonState();
}

class _RaioButtonState extends State<RaioButton> {
  String _radioValue; //Initial definition of radio button value
  String choice;

  // ------ [add the next block] ------
  @override
  void initState() {
    setState(() {
      _radioValue = "Year";
    });
    super.initState();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'Year':
          choice = value;
          break;
        case 'Month':
          choice = value;
          break;

        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
    widget.onChange(choice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            title: const Text('سنوية'),
            leading: Radio(
              value: 'Year',
              groupValue: _radioValue,
              onChanged: radioButtonChanges,
            ),
          ),

          /*   Row(
    children: <Widget>[
          Radio(
            value: 'Month',
            groupValue: _radioValue,
            onChanged: radioButtonChanges,
          ),
          Text(
            "شهرية",
          ),
    ],
  ),*/
        ],
      ),
    );
  }
}
