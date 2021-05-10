//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImageWidget extends StatelessWidget {
  const CacheImageWidget({
    Key key,
    this.fit = BoxFit.cover,
    this.imageUrl,
    this.assetImageTag,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);
  final BoxFit fit;
  final String imageUrl;
  final String assetImageTag;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return imageUrl != ''
        ? Text('Image  ')
        /* CachedNetworkImage(
            fit: fit,
            width: width,
            height: height,
            imageUrl: imageUrl,
            fadeInCurve: Curves.easeInCirc,
            errorWidget: (context, error, _) {
              return Image.asset(
                assetImageTag ?? 'assets/image/defoult/no0image.jpg',
                width: width,
                height: height,
                fit: fit,
                color: color,
              );
            },
            placeholder: (context, s) => Stack(
              children: [
                Image.asset(
                  assetImageTag ?? 'assets/image/defoult/no0image.jpg',
                  width: width,
                  height: height,
                  fit: fit,
                ),
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(50),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          )
          */
        : Image.asset(
            assetImageTag ?? 'assets/image/defoult/no0image.jpg',
            width: width,
            height: height,
            fit: fit,
            color: color,
          );
  }
}
/////////////////
///
