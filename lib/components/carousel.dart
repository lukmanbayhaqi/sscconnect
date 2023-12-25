import 'package:sscconnect/components/carousel-item.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CCarousel extends StatefulWidget {
  final List<CCarouselItem> items;
  final bool showIndex;

  const CCarousel({
    required this.items,
    this.showIndex = true,
    super.key,
  });

  @override
  State<CCarousel> createState() => _CCarouselState();
}

class _CCarouselState extends State<CCarousel> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.items,
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: widget.items.length > 1 ? true : false,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(
                () {
                  current = index;
                },
              );
            },
          ),
        ),
        if (widget.showIndex)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.map(
              (e) {
                int index = widget.items.indexOf(e);

                return Container(
                  width: adaptiveWidthSize(context, 10),
                  height: adaptiveWidthSize(context, 10),
                  margin: EdgeInsets.symmetric(
                    vertical: adaptiveWidthSize(context, 10),
                    horizontal: adaptiveWidthSize(context, 5),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              },
            ).toList(),
          ),
      ],
    );
  }
}
