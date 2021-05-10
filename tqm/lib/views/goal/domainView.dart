import 'package:flutter/material.dart';

import 'package:tqm/models/Stratige/domain.dart';
import 'package:tqm/services/Stratege/domainService.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'goalView.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:bot_toast/bot_toast.dart';

final DomainService _domainService = DomainService();

class DomainForm extends StatefulWidget {
  @override
  _DomainFormState createState() => _DomainFormState();
}

class _DomainFormState extends State<DomainForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _domainFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  DomainModel domainModel = DomainModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _getDomainForm();
  }

  Widget _getDomainForm() {
    var mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SimpleDialog(
        title: Container(
          width: mainWidth,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(7),
          child: Text(
            'إضافة مجال',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        children: [
          Container(
            width: mainWidth,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                Form(
                  key: _domainFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: FormText.textFormF(
                          context,
                          //null,
                          domainModel.name,
                          'إسم المجال',
                          null,
                          FormValidator().validateisEmpty,
                          (value) => domainModel.name = value,
                          'إسم المجال',
                          null,
                          [TextInputType.text],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: !_isLoading
                            ? Container(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'حــفــظ المجال',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _sendToServer();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendToServer() async {
    try {
      if (_domainFormKey.currentState.validate()) {
        _domainFormKey.currentState.save();

        final UiUtilities uiUtilities = UiUtilities();

        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool sata = false;

        sata = await _domainService.add(this.domainModel);
        ;

        BotToast.closeAllLoading();
        if (sata) {
          /*uiUtilities.alertNotification(
              context: context, message: 'تم حفظ الوظيفة ');
          Navigator.of(context).pop();*/

          SystemMsg.showMsg(
            _scaffoldKey,
            'تم حفظ المجال بنجاح',
            SystemMsg.backgroundSuccessColor,
          );
          Navigator.of(context).pop(this.domainModel);
        }
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }
}
