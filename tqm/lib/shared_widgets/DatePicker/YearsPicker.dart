import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearsPicker {
  int _selecteValue = DateTime.now().year;
  List<int> year = new List<int>();

  showPicker(context, int min, int max, Function onokk) {
    List<Widget> temp = List<Widget>();
    for (int i = min; i < max; i++) {
      temp.add(Text('$i'));
      year.add(i);
    }

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text('بداية فترة الإستراتيجية -سنوات'),
              ),
              Expanded(
                child: CupertinoPicker(
                    itemExtent: 40.0,
                    onSelectedItemChanged: (index) {
                      _selecteValue = year[index];
                    },
                    diameterRatio: 400.0,
                    useMagnifier: false,
                    magnification: 1.0,
                    looping: false,
                    backgroundColor: Colors.white,
                    offAxisFraction: 1.0,
                    children: temp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: () {
                        if (_selecteValue != 0) {
                          Navigator.of(context).pop();
                          onokk(_selecteValue);
                        }
                      },
                      child: Text('موافق')),
                  SizedBox(
                    width: 8,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('الغاء'))
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
