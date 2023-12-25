import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionDetail extends StatefulWidget {
  final bool isDone;
  final String shippingNumber;
  final String desc;

  const TransactionDetail({
    required this.isDone,
    required this.shippingNumber,
    required this.desc,
    super.key,
  });

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  Widget rsvLabel({
    String? left,
    String? right,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left ?? right ?? "",
          style: TextStyle(
            fontSize: adaptiveWidthSize(context, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (left != null)
          Text(
            right ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 20),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget rsvItem({
    String? left,
    String? right,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            left ?? right ?? "",
            style: TextStyle(
              fontSize: adaptiveWidthSize(context, 22.5),
            ),
          ),
        ),
        if (left != null)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: adaptiveWidthSize(context, 5),
              ),
              child: Text(
                right ?? "",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 22.5),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget padVer = Padding(
      padding: EdgeInsets.symmetric(
        vertical: adaptiveWidthSize(context, 5),
      ),
    );

    Color color = primaryColor;

    if (!widget.isDone) {
      color = Colors.blue[700]!;
    } else {
      color = Colors.teal;
    }

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          top: adaptiveWidthSize(context, 25),
          bottom: adaptiveWidthSize(context, 75),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: adaptiveWidthSize(context, 15),
                right: adaptiveWidthSize(context, 25),
                bottom: adaptiveWidthSize(context, 10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: adaptiveWidthSize(context, 40),
                    ),
                  ),
                  CBadge(
                    label: widget.isDone ? "Done" : "On Delivery",
                    statusColor: Colors.white,
                    bgColor: color,
                    borderColor: color,
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                widget.shippingNumber,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 27.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.desc,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 22.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CSeparator(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: adaptiveWidthSize(context, 25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  padVer,
                  rsvLabel(
                    left: "Pengirim",
                    right: "Penerima",
                  ),
                  rsvItem(
                    left: "PT Indofood",
                    right: "PT Siantar Top",
                  ),
                  padVer,
                  rsvLabel(
                    left: "Alamat",
                    right: "Alamat",
                  ),
                  rsvItem(
                    left:
                        "Agung Karya V No.5, RT.6/RW.14, Papanggo, Kec. Tj. Priok, Jkt Utara, Daerah Khusus Ibukota Jakarta 14340",
                    right:
                        "Jl. Cipendawa Lama No.7, RT.04/RW.07, Bojong Menteng, Kec. Rawalumbu, Kota Bks, Jawa Barat 17117",
                  ),
                  padVer,
                  rsvLabel(
                    left: "Jumlah",
                    right: "Jenis Barang",
                  ),
                  rsvItem(
                    left: "1 Container Fit",
                    right: "Bahan Baku Makanan",
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
