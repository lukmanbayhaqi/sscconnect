import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/states/states.dart';

import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InputOTP extends StatefulWidget {
  final String email;

  const InputOTP({
    required this.email,
    super.key,
  });

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class _InputOTPState extends State<InputOTP> {
  GlobalState get globalState => context.read<GlobalState>();

  String? resetCode;
  String otpInput = "";
  String? errorMessage;
  String infoMsg = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      infoMsg = "We've send OTP number to ${widget.email}";
    });
  }

  void validateOTP() async {
    if (otpInput.length < 6) {
      setState(() {
        errorMessage = "Please input 6 digits OTP Number";
      });

      return;
    }

    globalState.setLoading(true);

    ApiResponse response = await httpGet(
      context,
      "/api/auth/v1/password-reset-code?email=${widget.email}&otpNumber=$otpInput",
    );

    globalState.setLoading(false);

    if (response.isSuccess) {
      resetCode = response.data.toString();

      Navigator.of(context).pushNamedAndRemoveUntil(
        "password-reset",
        (route) => false,
        arguments: {
          "resetCode": resetCode,
        },
      );
    } else {
      setState(() {
        errorMessage = "Invalid OTP Number";
      });
    }
  }

  void resendOtp(BuildContext context) async {
    globalState.setLoading(true);

    ApiResponse response = await httpPost(
      context,
      "/api/auth/v1/password-forgot?email=${widget.email}",
    );

    globalState.setLoading(false);

    if (response.isSuccess) {
      setState(() {
        infoMsg = "We've send again OTP number to ${widget.email}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        title: "Insert OTP Number",
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: adaptiveWidthSize(context, 20),
            horizontal: adaptiveWidthSize(context, 30),
          ),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: adaptiveWidthSize(context, 50),
                ),
                child: CAlert(
                  title: infoMsg,
                ),
              ),
              TextField(
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "OTP Number",
                  hintStyle: TextStyle(
                    fontSize: adaptiveWidthSize(context, 40),
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: adaptiveWidthSize(context, 1.5),
                      color: primaryColor,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    bottom: adaptiveWidthSize(context, 10),
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (String text) {
                  otpInput = text;

                  if (otpInput.length == 6) {
                    setState(() {
                      errorMessage = null;
                    });
                  }
                },
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 50),
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
              if (errorMessage != null)
                Container(
                  margin: EdgeInsets.only(
                    top: adaptiveWidthSize(context, 15),
                  ),
                  child: Center(
                    child: FormError(
                      errorMessage: errorMessage,
                      fontSize: 25,
                    ),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(
                  bottom: adaptiveWidthSize(context, 35),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: adaptiveWidthSize(context, 30),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn't receive OTP number? ",
                        style: TextStyle(
                          color: textColor1,
                          fontSize: adaptiveWidthSize(context, 27.5),
                        ),
                      ),
                      TextSpan(
                        text: " Resend OTP",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: adaptiveWidthSize(context, 27.5),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            resendOtp(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              CButton(
                "Submit",
                onPressed: () {
                  validateOTP();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
