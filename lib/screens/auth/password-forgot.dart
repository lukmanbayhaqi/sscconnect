import 'package:sscconnect/screens/auth/input-otp.dart';
import 'package:sscconnect/states/states.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sscconnect/components/components.dart';

class PasswordForgot extends StatefulWidget {
  const PasswordForgot({Key? key}) : super(key: key);

  @override
  PasswordForgotState createState() => PasswordForgotState();
}

class PasswordForgotState extends State<PasswordForgot> {
  GlobalState get globalState => context.read<GlobalState>();

  String email = "";
  String? errorMessage;

  void onSubmit() async {
    globalState.setLoading(true);

    setState(() {
      errorMessage = null;
    });

    ApiResponse response = await httpPost(
      context,
      "/api/auth/v1/password-forgot?email=$email",
      data: {},
    );

    globalState.setLoading(false);

    if (response.isSuccess) {
      context.navigate(
        (context) => InputOTP(email: email),
      );
    } else {
      setState(() {
        errorMessage = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Forgot Password",
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.all(
            adaptiveWidthSize(context, 25),
          ),
          child: ListView(
            children: [
              if (errorMessage != null)
                Container(
                  margin: EdgeInsets.only(
                    bottom: adaptiveWidthSize(context, 30),
                  ),
                  child: CAlert(
                    title: "Reset Password Failed",
                    description: "Invalid Email Address!",
                    type: CAlertType.warning,
                  ),
                ),
              CFormInput(
                label: "Email Address",
                inputType: CInputType.text,
                onChange: (v) {
                  email = v;
                },
              ),
              Container(
                margin: EdgeInsets.only(
                  top: adaptiveWidthSize(context, 25),
                ),
                child: CButton(
                  "Reset Password",
                  onPressed: () {
                    onSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
