import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String field;
  final String value;
  final Widget verfy;

  const FieldLabel({Key key, this.field, this.value, this.verfy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0, top: 0, bottom: 0),
      child: Row(
        children: <Widget>[
          Text(
            field,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          RichText(
              maxLines: 2,
              text: TextSpan(children: [
                TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  text: value,
                ),
              ])),
          verfy == null ? Container() : verfy
        ],
      ),
    );
  }
}
