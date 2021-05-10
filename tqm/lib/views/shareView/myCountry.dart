import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tqm/models/countryModel.dart';

class MyCountryView extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;

  String countryInti;

  String stateInti;

  MyCountryView(
      {Key key,
      this.onCountryChanged,
      this.onStateChanged,
      this.countryInti = "الدولة",
      this.stateInti = "مقاطعة"})
      : super(key: key);

  @override
  _MyCountryViewState createState() => _MyCountryViewState();
}

class _MyCountryViewState extends State<MyCountryView> {
  //List<String> _cities = ["Choose City"];
  List<StatusModel> _country = [new StatusModel(name: "الدولة", code2: '')];
  //String _selectedCity = "Choose City";
  String _selectedCountry; // "الدولة";
  String _selectedState;
  List<String> _states = ["مقاطعة"];
  var responses;
  dynamic dataJson;

  getst() async {
    _states = await getState();
  }

  @override
  void initState() {
    getCounty();
    Future.delayed(Duration(seconds: 2), () {
      _selectedCountry = widget.countryInti; // "الدولة";
      _onSelectedCountry(_selectedCountry);

      _selectedState = widget.stateInti;
      _onSelectedState(_selectedState);

      //setState(() {});
    });

    //_selectedState = widget.stateInti;

    //getst();

    super.initState();
  }

  Future getResponse() async {
    String res = await rootBundle.loadString('assets/data/countries.json');
    //  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    dataJson = jsonDecode(res);

    return dataJson;
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = StatusModel();

      String countryCode = data['code2'];

      String flag = countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));

      model.name = data['name'];
      model.code2 = flag; //data['code2'];
      if (!mounted) return;
      setState(() {
        //model.code2 + "    " +
        _country.add(new StatusModel(name: model.name, code2: model.code2));
        // _country..addAll(takecountry2);
      });
    });

    return _country;
  }

  Future<List<String>> getState() async {
    //var response = await getResponse();
    if (dataJson == null) {
      var dataJson = await getResponse();
    } else {
      var datastate = dataJson
          .map((map) => StatusModel.fromJson(map))
          .where((item) => item.name == _selectedCountry)
          .map((item) => item.state)
          .toList();
      var states = datastate as List;
      states.forEach((f) {
        if (!mounted) return;
        setState(() {
          var name = f.map((item) => item.name).toList();
          for (var statename in name) {
            print(statename.toString());

            _states.add(statename.toString());
          }
        });
      });
    }

    return _states;
  }

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      _selectedState = "مقاطعة";
      _states = ["مقاطعة"];
      _selectedCountry = value;
      getState();
      this.widget.onCountryChanged(value);
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      // _selectedCity = "Choose City";
      // _cities = ["Choose City"];
      _selectedState = value;
      this.widget.onStateChanged(value);
      //getCity();
    });
  }

  /*void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      _selectedCity = value;
      this.widget.onCityChanged(value);
    });
  }*/

  _DropDownFormCountryField() {
    return FormField<String>(
      validator: (value) {
        if (value == null || value == 'الدولة') {
          return "الرجاء اختيار الدولة";
        }
        return null;
      },
      onSaved: (value) => _onSelectedCountry(value),
      builder: (
        FormFieldState<String> state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: new EdgeInsets.only(
                  bottom: 0,
                ),
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(
                      new Radius.circular(30.0),
                    ),
                    border: Border.all(
                        color: state.hasError ? Colors.redAccent : Colors.grey),
                    // color: Colors.lightBlueAccent
                  ),
                  child: new InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(right: 15, left: 15),
                      //labelText: 'Area',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        isDense: false,
                        underline: Container(),

                        dropdownColor: Colors.grey[200],
                        hint: new Text("Select country"),
                        value: _selectedCountry,

                        //icon:Icon(Icons.public_rounded) ,

                        onChanged: (newValue) {
                          // => _onSelectedCountry(value),
                          // (String newValue) {
                          state.didChange(newValue);
                          _onSelectedCountry(newValue);
                          setState(() {
                            //_selectedCountry = newValue;
                          });
                        },

                        items: _country.map((StatusModel dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem.name,
                            child: Row(
                              children: [
                                Text(
                                    '${dropDownStringItem.code2}   ${dropDownStringItem.name}')
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )),
            // SizedBox(height: 5.0),
            state.hasError
                ? Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700, fontSize: 12.0),
                  )
                : SizedBox(
                    height: 5.0,
                  ),
          ],
        );
      },
    );
  }

  _DropDownFormStatField() {
    return FormField<String>(
      validator: (value) {
        /*
        if (value == null || value == 'مقاطعة') {
          return "الرجاء مقاطعة";
        }*/
        return null;
      },
      onSaved: (value) => _onSelectedState(value),
      builder: (
        FormFieldState<String> state,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: new EdgeInsets.only(
                bottom: 0,
              ),
              child: new DecoratedBox(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(
                    new Radius.circular(30.0),
                  ),
                  border: Border.all(
                      color: state.hasError ? Colors.redAccent : Colors.grey),
                  // color: Colors.lightBlueAccent
                ),
                child: new InputDecorator(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(right: 15, left: 15),
                    //labelText: 'مقاطعة',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: new Text("مقاطعة"),
                      value: _selectedState,
                      onChanged: (String newValue) {
                        state.didChange(newValue);
                        setState(() {
                          _onSelectedState(newValue);
                          // _selectedCountry = newValue;
                        });
                      },
                      items: _states.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 5.0),
            state.hasError
                ? Text(
                    state.hasError ? state.errorText : '',
                    style: TextStyle(
                        color: Colors.redAccent.shade700, fontSize: 12.0),
                  )
                : SizedBox(
                    height: 5.0,
                  ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _DropDownFormCountryField(),
        _DropDownFormStatField(),

        /*  DropdownButton<String>(
          isExpanded: true,
          items: _country.map((StatusModel dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem.name,
              child: Row(
                children: [Text('${dropDownStringItem.code2}   ${dropDownStringItem.name}')],
              ),
            );
          }).toList(),
          

          onChanged: (value) => _onSelectedCountry(value),
          value: _selectedCountry,
        ),
        DropdownButton<String>(
          isExpanded: true,
          items: _states.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          // onChanged: (value) => print(value),
          onChanged: (value) => _onSelectedState(value),
          value: _selectedState,
        ),*/

        /* DropdownButton<String>(
          isExpanded: true,
          items: _cities.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          // onChanged: (value) => print(value),
          onChanged: (value) => _onSelectedCity(value),
          value: _selectedCity,
        ),*/

        SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}

/*********************models  */
