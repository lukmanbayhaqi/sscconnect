import 'dart:io';

import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:sscconnect/screens/main.dart';
import 'package:sscconnect/screens/auth/sign-in.dart';
import 'package:sscconnect/screens/splash.dart';
import 'package:sscconnect/states/states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
    debug: true,
  );

  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load(
    'assets/ca/lets-encrypt-r3.pem',
  );

  SecurityContext.defaultContext.setTrustedCertificatesBytes(
    data.buffer.asUint8List(),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyAppState>()!.restartApp();
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  GlobalState get globalStateWatch => context.watch<GlobalState>();
  GlobalState get globalStateRead => context.read<GlobalState>();

  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();

    // disable rotate phone
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  Widget get loader => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          color: Colors.white.withOpacity(.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Loading(
                type: CLoadingType.fadingCircle,
                size: CLoadingSize.large,
              ),
            ],
          ),
        ),
      );

  Widget toast(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: adaptiveWidthSize(context, 25),
          bottom: adaptiveWidthSize(context, 50),
          right: adaptiveWidthSize(context, 35),
          left: adaptiveWidthSize(context, 35),
        ),
        decoration: BoxDecoration(
          color: globalStateWatch.colorToast,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: adaptiveWidthSize(context, 30),
                ),
                child: Text(
                  globalStateWatch.textToast,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                globalStateRead.setShowToast(show: false);
              },
              child: Icon(
                Icons.close,
                size: adaptiveWidthSize(context, 40),
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSPConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        fontFamily: "Poppins",
      ),
      home: SplashScreen(),
      builder: (context, content) {
        return Stack(
          children: [
            content ?? SizedBox(),
            globalStateWatch.isLoading ? loader : SizedBox(),
            globalStateWatch.isShowToast ? toast(context) : SizedBox(),
          ],
        );
      },
      routes: <String, WidgetBuilder>{
        'splash': (_) => SplashScreen(),
        'sign-in': (_) => SignInScreen(),
        'main': (_) => MainScreen(),
      },
    );
  }
}
