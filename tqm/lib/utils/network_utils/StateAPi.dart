import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tqm/views/shareView/loaderView.dart';

class StateNetWork {
  static Widget hasErrorStrWidegt(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error: $error'),
        )
      ],
    );
  }

  static Widget connectionNoneWidegt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.info,
          color: Colors.blue,
          size: 28,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text('خطاء بالاتصال بالشبكة '),
        )
      ],
    );
  }

  static Widget connectionWaitWidegt() {
    return ColorLoader5();

    /*Center(
        child: CupertinoActivityIndicator(
      radius: 33,
    ));*/
  }

  static Widget connectionActiveWidegt(String data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('$data'),
        )
      ],
    );
  }
}
