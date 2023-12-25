import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/screens/booking-form.dart';
import 'package:sscconnect/screens/transaction-detail.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  ScrollController? controller;
  bool showFloatingButton = true;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller != null) {
      if (controller!.position.extentAfter < 10) {
        setState(() {
          showFloatingButton = false;
        });
      } else {
        setState(() {
          showFloatingButton = true;
        });
      }
    }
  }

  Widget badgeStatus(String status) {
    Color? color = Color(0xFF009ef7);

    if (status != "Done") {
      color = Colors.blue[700]!;
    } else {
      color = Colors.teal;
    }

    return CBadge(
      label: status,
      statusColor: Colors.white,
      bgColor: color,
      borderColor: color,
    );
  }

  Widget item({
    required String title,
    required String desc,
    bool isDone = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: adaptiveWidthSize(context, 15),
        vertical: adaptiveWidthSize(context, 5),
      ),
      child: GestureDetector(
        onTap: () {
          context.showBottomSheet(
            (context) => TransactionDetail(
              isDone: isDone,
              shippingNumber: title,
              desc: desc,
            ),
          );
        },
        child: CCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: adaptiveWidthSize(context, 15),
                    ),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      size: adaptiveWidthSize(context, 35),
                      color: Colors.black87,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: adaptiveWidthSize(context, 25),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: adaptiveWidthSize(context, 5),
                        ),
                      ),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: adaptiveWidthSize(context, 22.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: adaptiveWidthSize(context, 5),
                    ),
                    child: Icon(
                      Icons.expand_more,
                      size: adaptiveWidthSize(context, 30),
                    ),
                  ),
                  badgeStatus(isDone ? "Done" : "On Delivery"),
                ],
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
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: adaptiveWidthSize(context, 5),
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
                      "Shipping Transactions",
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
                    child: CSeparator(),
                  ),
                  Expanded(
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      children: [
                        item(
                          title: "IDV903632599933",
                          desc: "Cikini - Gondangdia",
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Kramat Jati - Cileunyi",
                          isDone: true,
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Tasikmalaya - Sao Paulo",
                          isDone: true,
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Menteng - Puerto Rico",
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Menteng - Purwokerto",
                          isDone: true,
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Pochinki - Sanhok",
                          isDone: true,
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Grogol - Georgopol",
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Miramar - Paradise",
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Sonovska - Rozhok",
                          isDone: true,
                        ),
                        item(
                          title: "IDV903632599933",
                          desc: "Land of Dawn - Bekasi",
                        ),
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
                    context.navigate((context) => BookingForm());
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
