import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/screens/feedback/feedback-create.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool showFloatingButton = true;

  Widget rsvLabel({
    String? left,
    String? right,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left ?? right ?? "",
          style: TextStyle(
            fontSize: adaptiveWidthSize(context, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (left != null)
          Text(
            right ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 20),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget rsvItem({
    String? left,
    String? right,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            left ?? right ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 22.5),
            ),
          ),
        ),
        if (right != null)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: adaptiveWidthSize(context, 5),
              ),
              child: Text(
                right,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 22.5),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget feedbackItem({
    required String shippingNumber,
    required String subject,
    required String desc,
  }) {
    Widget padVer = Padding(
      padding: EdgeInsets.symmetric(
        vertical: adaptiveWidthSize(context, 5),
      ),
    );
    Color color = Colors.blue[700]!;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: adaptiveWidthSize(context, 10),
      ),
      child: GestureDetector(
        onTap: () {},
        child: CCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      shippingNumber,
                      style: TextStyle(
                        fontSize: adaptiveWidthSize(context, 27.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: adaptiveWidthSize(context, 5),
                    ),
                    child: CBadge(
                      label: "SUBMITTED",
                      statusColor: Colors.white,
                      bgColor: color,
                      borderColor: color,
                    ),
                  ),
                ],
              ),
              padVer,
              rsvLabel(
                left: "Subject",
                right: "Created At",
              ),
              rsvItem(
                left: subject,
                right: DateTime.now().toFormattedDate(),
              ),
              padVer,
              rsvLabel(
                left: "Description",
              ),
              rsvItem(
                left: desc,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: adaptiveWidthSize(context, 15),
              bottom: adaptiveWidthSize(context, 25),
              left: adaptiveWidthSize(context, 30),
              right: adaptiveWidthSize(context, 30),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 247, 249),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: adaptiveWidthSize(context, 15),
                    horizontal: adaptiveWidthSize(context, 25),
                  ),
                  child: Text(
                    "Feedback History",
                    style: TextStyle(
                      fontSize: adaptiveWidthSize(context, 37.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: adaptiveWidthSize(context, 5),
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      feedbackItem(
                        shippingNumber: "IDV903632599933",
                        subject: "Kebersihan",
                        desc: "Lantai Container masih basah dan kurang bersih.",
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showFloatingButton)
            Positioned(
              bottom: adaptiveWidthSize(context, 50),
              right: adaptiveWidthSize(context, 40),
              child: CButtonIcon(
                Icons.add,
                onPressed: () {
                  context.navigate((context) => FeedbackCreate());
                },
              ),
            ),
        ],
      ),
    );
  }
}
