import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/screens/components/input-custom.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: CAppBar(
          title: "Booking Form",
        ),
        body: Container(
          margin: EdgeInsets.only(
            bottom: adaptiveWidthSize(context, 5),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: adaptiveWidthSize(context, 30),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInput(
                        label: "Perusahaan Penerima",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInput(
                        label: "Perusahaan Warehouse",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInput(
                        label: "Alamat",
                        inputType: CInputType.textArea,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInputSelect(
                        label: "Area",
                        text: "20 Fit Container",
                        builder: (BuildContext context) => InputCustom(
                          label: "Area",
                          inputList: [
                            "20 Fit Container",
                          ],
                          onSelect: (String payload) {},
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInput(
                        label: "Jenis Pesanan",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: adaptiveWidthSize(context, 10),
                      ),
                      child: CFormInput(
                        label: "Jumlah Pesanan",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: adaptiveWidthSize(context, 10),
                  bottom: adaptiveWidthSize(context, 30),
                ),
                child: CButton(
                  "Proceed Booking",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
