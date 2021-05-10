import 'package:flutter/material.dart';

class EmptyView extends StatefulWidget {
  final String title;
  final String img;

  const EmptyView({Key key, @required this.title, this.img = 'no_data.png'})
      : super(key: key);

  @override
  _EmptyViewState createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 2,
      width: width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/${widget.img}',
              height: width / 2,
              width: width / 2,
            ),
            Container(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 51),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
///////////////
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
