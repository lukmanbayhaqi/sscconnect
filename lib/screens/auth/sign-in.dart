import 'package:sscconnect/screens/auth/password-forgot.dart';
import 'package:sscconnect/screens/auth/sign-up.dart';
import 'package:sscconnect/states/global.dart';
import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
  });

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  GlobalState get globalStateRead => context.read<GlobalState>();

  String username = "";
  String password = "";

  bool isLoading = false;
  Map<String, List<String>> errors = {};

  FocusNode fnUsername = FocusNode();
  FocusNode fnPassword = FocusNode();

  Future signIn() async {
    context.pushPermanent("main");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: adaptiveWidthSize(context, 50),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: SizedBox(
                      width: adaptiveWidthSize(context, 200),
                      child: Image.asset("assets/images/icon.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: adaptiveWidthSize(context, 25),
                      bottom: adaptiveWidthSize(context, 25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "SSPConnect",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: adaptiveWidthSize(context, 40),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (errors["Error"] != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: adaptiveWidthSize(context, 30),
                      ),
                      child: CAlert(
                        title: "Authentication Failed!",
                        description: errors["Error"]![0],
                        type: CAlertType.warning,
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: adaptiveWidthSize(context, 10),
                      bottom: adaptiveWidthSize(context, 15),
                    ),
                    child: FormLabel(
                      label: "Email",
                    ),
                  ),
                  TextField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeee9e2),
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: adaptiveWidthSize(context, 35),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.01),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.01),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: adaptiveWidthSize(context, 30),
                    ),
                    onChanged: (text) {
                      username = text;
                    },
                    controller: TextEditingController()..text = username,
                    focusNode: fnUsername,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: adaptiveWidthSize(context, 35),
                      bottom: adaptiveWidthSize(context, 15),
                      left: adaptiveWidthSize(context, 10),
                    ),
                    child: FormLabel(
                      label: "Password",
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffeee9e2),
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: adaptiveWidthSize(context, 35),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.01),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(.01),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: adaptiveWidthSize(context, 30),
                    ),
                    onChanged: (text) {
                      password = text;
                    },
                    obscureText: true,
                    controller: TextEditingController()..text = password,
                    focusNode: fnPassword,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(
                      vertical: adaptiveWidthSize(context, 30),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.navigate((context) => PasswordForgot());
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: adaptiveWidthSize(context, 27.5),
                        ),
                      ),
                    ),
                  ),
                  CButton(
                    "Continue",
                    onPressed: () {
                      signIn();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: adaptiveWidthSize(context, 10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Doesn't have account?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: adaptiveWidthSize(context, 25),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.navigate(
                            (context) => SignUp(),
                          );
                        },
                        child: Text(
                          " Create an account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: adaptiveWidthSize(context, 25),
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: adaptiveWidthSize(context, 25),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
