import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color.fromARGB(255, 245, 247, 249),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: adaptiveWidthSize(context, 15),
                  horizontal: adaptiveHeightSize(context, 10),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      width: adaptiveWidthSize(context, 2.5),
                      color: Colors.blueGrey.withAlpha(0x22),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: adaptiveHeightSize(context, 30),
                          child: Image.asset("assets/images/icon.png"),
                        ),
                      ],
                    ),
                    Positioned(
                      top: adaptiveWidthSize(context, 5),
                      left: adaptiveWidthSize(context, 5),
                      child: GestureDetector(
                        onTap: () {
                          context.goBack();
                        },
                        child: Icon(
                          Icons.close,
                          size: adaptiveWidthSize(context, 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(
                  adaptiveWidthSize(context, 20),
                ),
                child: CCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: adaptiveWidthSize(context, 10),
                        ),
                        child: Text(
                          "Andrew Russel Garfield",
                          style: TextStyle(
                            fontSize: adaptiveWidthSize(context, 30),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: adaptiveWidthSize(context, 10),
                        ),
                        child: Text(
                          "202208001",
                          style: TextStyle(
                            fontSize: adaptiveWidthSize(context, 25),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: adaptiveWidthSize(context, 25),
                          bottom: adaptiveWidthSize(context, 15),
                        ),
                        child: CSeparator(
                          dashed: true,
                          dashedCount: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          adaptiveWidthSize(context, 75),
                        ),
                        child: QrImageView(
                          data: "202208001",
                          version: QrVersions.min,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
