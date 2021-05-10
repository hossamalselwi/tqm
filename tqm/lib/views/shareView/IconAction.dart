import 'package:flutter/material.dart';

class IconAction extends StatelessWidget {
  final IconData icon;
  final String txt;
  final Color color;
  final FontWeight fontWeight;
  final Function action;

  const IconAction(
      {Key key, this.icon, this.txt, this.color, this.fontWeight, this.action})
      : super(key: key);

  Widget _iconAcion() {
    return InkWell(
        onTap: () {
          action();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 17,
            ),
            Text(
              txt,
              style:
                  TextStyle(fontSize: 11, color: color, fontWeight: fontWeight),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _iconAcion();
  }
}
