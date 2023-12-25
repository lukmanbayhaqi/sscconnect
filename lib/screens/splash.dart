import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    setTimeout(2000, init);
  }

  void init() async {
    context.pushPermanent("sign-in");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 300,
              alignment: Alignment.center,
              child: Image.asset("assets/images/icon.png"),
            ),
          ),
        ],
      ),
    );
  }
}
