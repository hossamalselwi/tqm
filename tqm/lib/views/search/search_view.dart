import 'package:flutter/material.dart';
////////////////
/////////////////////////
/////////////////
////////////////////
///////////////////
//////////////////////////
////////////////////
/////////////////////
//////////////////////
/////////////////
//////////////////////////////
///
///

class SearchView extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: InkWell(
            onTap: () {
              query = '';
            },
            child: Center(
                child: Text(
              'تنظيف',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.grey),
            ))),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                "ابحث ",
              ),
            ),
          )
        ],
      );
    }
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
//////////
///
///
///
///
///
///
///
///
/////
//////////////////
///
///
///
///
