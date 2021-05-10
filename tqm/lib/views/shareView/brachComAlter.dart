import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tqm/models/barch.dart';

import 'package:tqm/services/barchService.dart';
//
//

class BrchCompView extends StatefulWidget {
  final ValueChanged<Barch> onBrchChanged;

  final Barch initBrch;

  BrchCompView({
    Key key,
    this.onBrchChanged,
    this.initBrch,
  }) : super(key: key);

  @override
  _BrchCompViewState createState() => _BrchCompViewState();
}

class _BrchCompViewState extends State<BrchCompView> {
  List<Barch> _brch = [new Barch(name: "اختر الفرع", image: '', id: "-100")];
  Barch _selectedbrch = Barch(name: "اختر الفرع", image: '', id: "-100");

  BrchSerivce _brchSerivce = BrchSerivce();
  @override
  void initState() {
    getBarchs();

    /* Future.delayed(Duration(seconds: 2), () {
      getDept(widget.initBrch.id);
      if(widget.isJob)
      getJobs();
    });*/

    super.initState();
  }

  Future getBarchs() async {
    var data = await _brchSerivce.getAll();

    setState(() {
      _brch.addAll(data);

      if (widget.initBrch == null)
        _selectedbrch = Barch(name: "اختر الفرع", image: '', id: "-100");
      else
        _selectedbrch = _brch.where((x) => x.id == widget.initBrch.id).first;

      //widget.initBrch;
    });
  }

  Future<void> _showBrchDialog(String message, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (int i = 0; i < _brch.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        _onSelectingBarch(_brch[i]);
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        children: [
                          Text(_brch[i].name),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onSelectingBarch(Barch value) {
    if (!mounted) return;
    setState(() {
      _selectedbrch = value;
      this.widget.onBrchChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      //
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text(
              'الفرع : ',
              style: TextStyle(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _showBrchDialog('', '');
                },
                child: Row(
                  children: [
                    Text(
                      _selectedbrch.name,
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}

/*********************models  */
/////////////////
///
