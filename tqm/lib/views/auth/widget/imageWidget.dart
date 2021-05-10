import 'package:flutter/material.dart';
import 'package:tqm/views/shareView/cachImageWidget.dart';

Widget hero(BuildContext context,
    {String extraTag = "",
    fit = BoxFit.cover,
    double width,
    double height,
    String path}) {
  return Hero(
    tag: path + '/' + extraTag,
    child: Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: Colors.transparent,
      child: CacheImageWidget(
        imageUrl: path,
        fit: fit,
        width: width,
        height: width,
        //assetImageTag: PlaceHolderImages.userIcon,
      ),
    ),
  );
}

class AccountScreenImageCard extends StatelessWidget {
  const AccountScreenImageCard({
    Key key,
    @required this.extraTag,
    @required this.path,
  }) : super(key: key);

  final String extraTag;
  final String path;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 10 / 10,
      child: Container(
        width: double.infinity,
        child: hero(context,
            extraTag: extraTag,
            path: path,
            width: double.infinity,
            height: double.infinity),
      ),
    );
  }
}

class EdittingImageProfile extends StatelessWidget {
  const EdittingImageProfile({
    Key key,
    @required this.extraTag,
    this.path,
  }) : super(key: key);

  // final ImageProfile imageProfile;
  final String extraTag;

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        child: hero(context,
            extraTag: extraTag,
            width: double.infinity,
            path: path,
            height: double.infinity),
      ),
    );
  }
}
