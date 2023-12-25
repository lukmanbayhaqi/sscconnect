import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class CSeparator extends StatelessWidget {
  final int? dashedCount;
  final bool? dashed;

  const CSeparator({
    this.dashedCount,
    this.dashed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (dashed == true && dashedCount != null) {
      return Row(
        children: List.generate(
          150 ~/ dashedCount!,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.grey[400],
              height: 1,
            ),
          ),
        ),
      );
    }

    return Container(
      height: adaptiveWidthSize(context, 2.5),
      margin: EdgeInsets.symmetric(
        vertical: adaptiveWidthSize(context, 10),
      ),
      padding: EdgeInsets.all(
        adaptiveWidthSize(context, 10),
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withAlpha(0x22),
      ),
    );
  }
}
