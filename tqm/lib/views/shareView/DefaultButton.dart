import 'package:flutter/material.dart';
import 'package:tqm/utils/ui_utils/SizeSceen.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key key,
      this.text,
      this.press,
      this.backColor,
      this.foreColor,
      this.radioborder = 7})
      : super(key: key);
  final String text;
  final Function press;
  final Color backColor;
  final Color foreColor;
  final double radioborder;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // ProviderServices serviceapp = Provider.of<ProviderServices>(context, listen: false);
    return SizedBox(
      // width: width * .7,
      width: double.infinity,
      height: 55,
      // getProportionateScreenHeight(56),
      //,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radioborder)),
        color: backColor,
        onPressed: press,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12),
          child:
              /*  serviceapp.loading && serviceapp.loadingType == 'login'
                              ? 
                              Container(
                                padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                              )
                              : */
              Text(
            text,
            style: TextStyle(
              fontSize: 13
              //double.parse( getProportionateScreenWidth(12).toString())
              ,
              color: foreColor,
            ),
          ),
        ),
      ),
    );
  }
}
////////////////////////////////
///
///
///
///
///
///
///
////////////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
/////////////
//////////////////
/////////////
////////
///////////////////////
////////////////////
/////////////////////
///
///////////////////////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
