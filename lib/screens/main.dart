import 'package:sscconnect/screens/account/index.dart';
import 'package:sscconnect/screens/feedback/index.dart';
import 'package:sscconnect/screens/qr-scan.dart';
import 'package:sscconnect/screens/transaction/index.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int? mainIndex;

  const MainScreen({
    this.mainIndex,
    super.key,
  });

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  BottomNavigationBarItem buttonTabItem(String label, IconData icon) =>
      BottomNavigationBarItem(
        label: label,
        icon: Icon(
          icon,
          size: adaptiveWidthSize(context, 40),
        ),
        activeIcon: Icon(
          icon,
          color: primaryColor,
          size: adaptiveWidthSize(context, 40),
        ),
      );

  List<Widget> get pageList => [
        TransactionScreen(),
        FeedbackScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    String greetings = "";

    if ((today.hour >= 0 && today.hour <= 11)) {
      greetings = "Good Morning";
    } else if ((today.hour >= 12 && today.hour <= 17)) {
      greetings = "Good Afternoon";
    } else if ((today.hour >= 18 && today.hour <= 23)) {
      greetings = "Good Evening";
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
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
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.navigate(
                              (_) => AccountScreen(),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: adaptiveWidthSize(context, 10),
                              left: adaptiveWidthSize(context, 10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  greetings,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: adaptiveWidthSize(context, 15),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Andrew",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: adaptiveWidthSize(context, 20),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.navigate((context) => QrScan());
                          },
                          child: Icon(
                            Icons.qr_code_outlined,
                            size: adaptiveWidthSize(context, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: pageList[currentIndex],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: primaryColor,
        selectedLabelStyle: TextStyle(
          color: primaryColor,
          fontSize: adaptiveWidthSize(context, 25),
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: adaptiveWidthSize(context, 25),
        ),
        currentIndex: currentIndex,
        onTap: (idx) {
          setState(() {
            currentIndex = idx;
          });
        },
        items: [
          buttonTabItem("Transaction", Icons.local_shipping_outlined),
          buttonTabItem("Feedback", Icons.comment_bank_outlined),
        ],
      ),
    );
  }
}
