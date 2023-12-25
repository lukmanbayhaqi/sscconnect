import 'package:sscconnect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CCarouselItem extends StatelessWidget {
  final String imgUrl;
  final String? title;
  final String? desc;
  final Widget? redirect;

  const CCarouselItem({
    required this.imgUrl,
    this.title,
    this.desc,
    this.redirect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (redirect != null) {
          context.navigate((context) => redirect!);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(
          adaptiveWidthSize(context, 15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(
              adaptiveWidthSize(context, 15),
            ),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: imgUrl,
                errorWidget: (context, url, error) => Icon(Icons.error),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                fit: BoxFit.cover,
                width: adaptiveWidthSize(context, 1000),
                height: adaptiveWidthSize(context, double.infinity),
              ),
              if (title != null || desc != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(
                      adaptiveWidthSize(context, 15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: adaptiveWidthSize(context, 30),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (desc != null)
                          Text(
                            desc!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: adaptiveWidthSize(context, 22.5),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
