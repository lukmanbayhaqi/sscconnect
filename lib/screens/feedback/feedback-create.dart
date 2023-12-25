import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/components/form-input-attachment.dart';
import 'package:sscconnect/components/form-input-time-slider.dart';
import 'package:sscconnect/states/global.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class FeedbackCreate extends StatefulWidget {
  const FeedbackCreate({super.key});

  @override
  State<FeedbackCreate> createState() => _FeedbackCreateState();
}

class _FeedbackCreateState extends State<FeedbackCreate> {
  GlobalState get globalStateRead => context.read<GlobalState>();

  String? subject;
  String? date;
  String? time;
  String? description;
  List<String> attachments = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CAppBar(
          title: "Feedback Form",
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: adaptiveWidthSize(context, 15),
            bottom: adaptiveWidthSize(context, 25),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: adaptiveWidthSize(context, 25),
          ),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                    child: CFormInput(
                      label: "Date",
                      inputType: CInputType.dateSlider,
                      defaultValue: date,
                      maxDate: DateTime.now(),
                      onChange: (v) {
                        setState(() {
                          date = v;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: adaptiveWidthSize(context, 10),
                    ),
                  ),
                  Expanded(
                    child: CFormInputTimeSlider(
                      label: "Time",
                      defaultValue: time,
                      use24hFormat: false,
                      maxDate: DateTime.now(),
                      onChange: (v) {
                        setState(() {
                          time = v;
                        });
                      },
                    ),
                  ),
                ],
              ),
              CFormInput(
                label: "Subject",
                defaultValue: subject,
                onChange: (v) {
                  subject = v;
                },
              ),
              CFormInput(
                label: "Description",
                inputType: CInputType.textArea,
                defaultValue: description,
                onChange: (v) {
                  description = v;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Text(
                      "Attachment",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xdd253e57),
                      ),
                    ),
                  ),
                  FormInputAttachment(
                    pathList: attachments,
                    isMultiple: true,
                    onChange: (v) {
                      setState(() {
                        attachments = v;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: adaptiveWidthSize(context, 35),
                  bottom: adaptiveWidthSize(context, 10),
                ),
                child: CButton(
                  "Submit",
                  onPressed: () {
                    globalStateRead.setShowToast(
                      text: "Feedback submitted",
                    );

                    context.goBack();
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
