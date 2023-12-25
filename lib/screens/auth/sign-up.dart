import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/states/global.dart';
import 'package:flutter/material.dart';
import 'package:sscconnect/utils/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalState get globalState => context.read<GlobalState>();

  String resetCode = "";
  String newPassword = "";
  String confirmNewPassword = "";
  Map<String, List<String>> errors = {};

  Future onSubmit() async {
    setState(() {
      errors = {};
    });

    Map args = ModalRoute.of(context)!.settings.arguments as Map;

    if (args["resetCode"] != null) {
      resetCode = args["resetCode"];
    }

    globalState.setLoading(true);

    Map payload = {
      "NewPassword": newPassword,
      "ConfirmNewPassword": confirmNewPassword,
    };

    ApiResponse response = await httpPost(
      context,
      "/api/auth/v1/password-reset?code=$resetCode",
      data: payload,
    );

    globalState.setLoading(false);

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Success change password!",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: adaptiveWidthSize(context, 35),
                ),
              ),
            ],
          ),
        ),
      );

      context.pushPermanent("sign-in");
    }

    if (response.isInvalid) {
      setState(() {
        errors = response.getErrors();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Create Account",
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.all(
            adaptiveWidthSize(context, 30),
          ),
          child: ListView(
            children: [
              CFormInput(
                label: "Full Name",
                onChange: (v) {},
              ),
              CFormInput(
                label: "Username",
                onChange: (v) {},
              ),
              CFormInput(
                label: "Email",
                onChange: (v) {},
              ),
              CFormInput(
                label: "Password",
                inputType: CInputType.password,
                onChange: (v) {
                  newPassword = v;
                },
              ),
              CFormInput(
                label: "Confirm Password",
                inputType: CInputType.password,
                onChange: (v) {
                  confirmNewPassword = v;
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: adaptiveWidthSize(context, 20),
                  bottom: adaptiveWidthSize(context, 40),
                ),
                child: CButton(
                  "Create Account",
                  onPressed: () {},
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.pushPermanent("sign-in");
                },
                child: Text(
                  "Back to Sign In page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: adaptiveWidthSize(context, 25),
                    color: primaryColor,
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
