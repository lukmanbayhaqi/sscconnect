import 'package:sscconnect/components/full-screen-page.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

class CImage extends StatelessWidget {
  final String imgUrl;
  final ImageProvider<Object>? placeholder;
  final double width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final bool? enableFullScreen;

  const CImage({
    required this.imgUrl,
    this.placeholder,
    required this.width,
    this.height,
    this.radius,
    this.fit,
    this.enableFullScreen = false,
    super.key,
  });

  Widget builder(
    BuildContext context, {
    ImageProvider<Object>? imgProvider,
  }) {
    return Container(
      width: adaptiveWidthSize(context, width),
      height: height != null ? adaptiveWidthSize(context, height!) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          adaptiveWidthSize(context, radius ?? 0),
        ),
        image: DecorationImage(
          image: imgProvider ?? Image.asset("assets/images/file.png").image,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imgUrl.contains("svg")) {
      return Container(
        margin: EdgeInsets.only(
          left: adaptiveWidthSize(context, 5),
        ),
        width: adaptiveWidthSize(context, width),
        height: height != null ? adaptiveWidthSize(context, height!) : null,
        child: ScalableImageWidget.fromSISource(
          si: ScalableImageSource.fromSvgHttpUrl(
            Uri.parse(imgUrl),
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (_, imageProvider) => GestureDetector(
        onTap: enableFullScreen!
            ? () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    barrierColor: Colors.white,
                    pageBuilder: (BuildContext context, _, __) {
                      return FullScreenPage(
                        readOnly: true,
                        files: [
                          {
                            "url": "",
                            "imgUrl": imgUrl,
                            "fileType": "image/png",
                            "fileName": "Bimasena_${DateTime.now()}",
                          },
                        ],
                      );
                    },
                  ),
                );
              }
            : null,
        child: builder(
          context,
          imgProvider: imageProvider,
        ),
      ),
      placeholder: (_, __) => builder(
        context,
        imgProvider: placeholder,
      ),
      errorWidget: (_, __, ___) => builder(
        context,
        imgProvider: placeholder,
      ),
    );
  }
}
