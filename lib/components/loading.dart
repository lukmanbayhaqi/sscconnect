import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum CLoadingSize {
  small,
  medium,
  large,
  custom,
}

enum CLoadingType {
  threeBounce,
  wave,
  fadingCircle,
}

class Loading extends StatelessWidget {
  final String? loaderText;
  final CLoadingSize size;
  final CLoadingType type;
  final Color? color;
  final double? customSize;

  const Loading({
    this.loaderText,
    this.size = CLoadingSize.large,
    this.type = CLoadingType.wave,
    this.color = primaryColor,
    this.customSize,
    Key? key,
  }) : super(key: key);

  Widget loadingBuilder(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            adaptiveWidthSize(context, 50),
          ),
        ),
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double loaderSize = 100;

    if (size == CLoadingSize.medium) {
      loaderSize = 75;
    } else if (size == CLoadingSize.small) {
      loaderSize = 45;
    } else if (size == CLoadingSize.custom && customSize != null) {
      loaderSize = customSize!;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (type == CLoadingType.fadingCircle)
          SpinKitFadingCircle(
            itemBuilder: loadingBuilder,
            size: adaptiveWidthSize(context, loaderSize),
          ),
        if (type == CLoadingType.threeBounce)
          SpinKitThreeBounce(
            itemBuilder: loadingBuilder,
            size: adaptiveWidthSize(context, loaderSize),
          ),
        if (type == CLoadingType.wave)
          SpinKitWave(
            itemBuilder: loadingBuilder,
            size: adaptiveWidthSize(context, loaderSize),
          ),
        if (loaderText != null)
          Padding(
            padding: EdgeInsets.only(
              top: adaptiveWidthSize(context, 20),
            ),
            child: Text(
              loaderText!,
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 30),
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
      ],
    );
  }
}
