import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatefulWidget {
  final String fileName;
  final String url;

  const PdfViewer({
    Key? key,
    required this.fileName,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PDFDocument? doc;

  @override
  void initState() {
    setTimeout(200, init);

    super.initState();
  }

  void init() async {
    doc = await PDFDocument.fromURL(widget.url);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return doc != null ? PDFViewer(document: doc!) : SizedBox();
  }
}
