import 'package:sscconnect/components/full-screen-page.dart';
import 'package:flutter/material.dart';

class ImageFullScreenWrapperWidget extends StatelessWidget {
  final Image thumbnail;
  final List<Map<String, String>> files;

  const ImageFullScreenWrapperWidget({
    required this.thumbnail,
    required this.files,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.white,
            pageBuilder: (BuildContext context, _, __) {
              return FullScreenPage(
                files: files,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: thumbnail.image,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
