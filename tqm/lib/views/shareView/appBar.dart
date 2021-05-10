
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/ui_utils/custom_colors.dart';

Widget appBarApp(context,String title ) {
    return
 AppBar(
        centerTitle:  false,
        elevation: 1,
       // excludeHeaderSemantics: true,
        //toolbarHeight: 70,

        //backgroundColor: Colors.white,


       /* bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight), //70
            child: new Container(
              padding: EdgeInsets.only(right: 10,left: 10),
              alignment: Alignment.centerRight,
              child:
               Text(
        '$title',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold),
      ),
        )),*/
        
       // leading: Container(),

        title: 
      Container(
            width:  MediaQuery.of(context).size.width/2 +10,
            height: 35.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image/logoHerz.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
                actions: [
/*
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 15) ,
                    child: InkWell(
                onTap: () {
                    Navigator.of(context).pop();
                },
                child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: bBasicColor,
                    size: 20,
                ) ,),
                  ),*/
                ],
      );

}

Widget appBarOne(context,String title)
{

  return  AppBar(
          backgroundColor: customRedColor,
          iconTheme: IconThemeData(color: Colors.white),
          leading: BackButton(
            color: Colors.white,
            onPressed: () =>
                Navigator.pop(context),
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
}

///
////
///
///
///
///
///
///
///
Widget myappBar(context ) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 11, top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            child: Container(
              width: 25,
              height: 25,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: bBasicColor,
                  size: 20,
                ),
              ),
            ),
          ),
          Container(
            width: 118.0,
            height: 32.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/home/logoHerz.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
         /* Material(
            child: Container(
              width: 25,
              height: 25,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  color: iconsColor,
                  size: 25,
                ),
              ),
            ),
          ),*/

          /* _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.lightBlue
              ,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          }),*/
        ],
      ),
    );
  }
//////////////////////
///
///
///
///