import 'package:sscconnect/components/image.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

import 'dart:math';

/// Creates an array of circular images stacked over each other
class StackedImage extends StatelessWidget {
  /// List of image urls
  final List<String> imageList;

  /// Image radius for the circular image
  final double? imageRadius;

  /// Count of the number of images to be shown
  final int? imageCount;

  /// Total count will be used to determine the number of circular images
  /// to be shown along with showing the remaining count in an additional
  /// circle
  final int totalCount;

  /// Optional field to set the circular image border width
  final double? imageBorderWidth;

  /// Optional field to set the color of circular image border
  final Color? imageBorderColor;

  /// Optional field to set the color of circular extra count
  final Color? extraCountBorderColor;

  /// The text style to apply if there is any extra count to be shown
  final TextStyle extraCountTextStyle;

  /// Set the background color of the circle
  final Color backgroundColor;

  /// Enum to define the image source.
  ///
  /// Describes type of the image source being sent in [imageList]
  ///
  /// Possible values:
  ///  * Asset
  ///  * Network
  ///  * File
  final ImageSource? imageSource;

  /// Custom widget list passed to render circular images
  final List<Widget> children;

  /// Radius for the circular image to applied when [children] is passed
  final double? widgetRadius;

  /// Count of the number of widget to be shown as circular images when [children]
  /// is passed
  final int? widgetCount;

  /// Optional field to set the circular border width when [children] is passed
  final double? widgetBorderWidth;

  /// Optional field to set the color of circular border when [children] is passed
  final Color? widgetBorderColor;

  /// List of `ImageProvider`
  final List<ImageProvider> providers;

  /// To show the remaining count if the provided list size is less than [totalCount]
  final bool showTotalCount;

  /// Creates a image stack widget.
  ///
  /// The [imageList] and [totalCount] parameters are required.
  StackedImage({
    Key? key,
    required this.imageList,
    this.imageRadius = 25,
    this.imageCount = 3,
    required this.totalCount,
    this.imageBorderWidth = 2,
    this.imageBorderColor = Colors.grey,
    this.imageSource = ImageSource.network,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.extraCountBorderColor,
    this.backgroundColor = Colors.white,
  })  : children = [],
        providers = [],
        widgetBorderColor = null,
        widgetBorderWidth = null,
        widgetCount = null,
        widgetRadius = null,
        super(key: key);

  /// Creates a image stack widget by passing list of custom widgets.
  ///
  /// The [children] and [totalCount] parameters are required.
  StackedImage.widgets({
    Key? key,
    required this.children,
    this.widgetRadius = 25,
    this.widgetCount = 3,
    required this.totalCount,
    this.widgetBorderWidth = 2,
    Color this.widgetBorderColor = Colors.grey,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.extraCountBorderColor,
    this.backgroundColor = Colors.white,
  })  : imageList = [],
        providers = [],
        imageBorderColor = widgetBorderColor,
        imageBorderWidth = widgetBorderWidth,
        imageCount = widgetCount,
        imageRadius = widgetRadius,
        imageSource = null,
        super(key: key);

  /// Creates an image stack by passing list of `ImageProvider`.
  ///
  /// The [providers] and [totalCount] parameters are required.
  StackedImage.providers({
    Key? key,
    required this.providers,
    this.imageRadius = 25,
    this.imageCount = 3,
    required this.totalCount,
    this.imageBorderWidth = 2,
    this.imageBorderColor = Colors.grey,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.extraCountBorderColor,
    this.backgroundColor = Colors.white,
  })  : imageList = [],
        children = [],
        widgetBorderColor = null,
        widgetBorderWidth = null,
        widgetCount = null,
        widgetRadius = null,
        imageSource = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List items = List.from(imageList)
      ..addAll(children)
      ..addAll(providers);
    int size = min(
      children.isNotEmpty ? widgetCount! : imageCount!,
      items.length,
    );
    List<Padding> widgetList = items
        .sublist(0, size)
        .asMap()
        .map(
          (index, value) => MapEntry(
            index,
            Padding(
              padding: EdgeInsets.only(left: 0.7 * imageRadius! * index),
              child: circularItem(value),
            ),
          ),
        )
        .values
        .toList()
        .reversed
        .toList();
    TextStyle extraFS = extraCountTextStyle.copyWith(
      fontSize: adaptiveWidthSize(context, 25),
    );

    return Row(
      children: [
        if (widgetList.isNotEmpty)
          Stack(
            clipBehavior: Clip.none,
            children: widgetList,
          ),
        if (showTotalCount && totalCount - widgetList.length > 0)
          Container(
            width: adaptiveWidthSize(context, 50),
            height: adaptiveWidthSize(context, 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                imageRadius! - imageBorderWidth!,
              ),
              border: Border.all(
                color: extraCountBorderColor ?? imageBorderColor!,
                width: adaptiveWidthSize(context, imageBorderWidth!),
              ),
              color: backgroundColor,
            ),
            child: Center(
              child: Text(
                "+${totalCount - widgetList.length}",
                textAlign: TextAlign.center,
                style: extraFS,
              ),
            ),
          ),
      ],
    );
  }

  Widget circularItem(dynamic item) {
    if (item is ImageProvider) {
      return circularProviders(item);
    } else if (item is Widget) {
      return circularWidget(item);
    } else if (item is String) {
      return CImage(
        imgUrl: item,
        width: 50,
        height: 50,
        radius: 50,
        placeholder: Image.asset(
          'assets/images/user-placeholder.jpeg',
        ).image,
      );
    }

    return SizedBox();
  }

  circularWidget(Widget widget) {
    return Container(
      height: widgetRadius,
      width: widgetRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: widgetBorderColor!,
          width: widgetBorderWidth!,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widgetRadius!),
        child: widget,
      ),
    );
  }

  Widget circularImage(String imageUrl) {
    return Container(
      height: imageRadius,
      width: imageRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: imageBorderColor!,
          width: imageBorderWidth!,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget circularProviders(ImageProvider imageProvider) {
    return Container(
      height: imageRadius,
      width: imageRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: imageBorderColor!,
          width: imageBorderWidth!,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  imageProvider(imageUrl) {
    if (imageSource == ImageSource.asset) {
      return AssetImage(imageUrl);
    } else if (imageSource == ImageSource.file) {
      return FileImage(imageUrl);
    }
    return NetworkImage(imageUrl);
  }
}

enum ImageSource { asset, network, file }
