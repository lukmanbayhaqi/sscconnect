import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/models/attachment.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';

class AttachmentFile extends StatefulWidget {
  final List<Attachment> attachmentList;

  const AttachmentFile({
    required this.attachmentList,
    super.key,
  });

  @override
  State<AttachmentFile> createState() => _AttachmentFileState();
}

class _AttachmentFileState extends State<AttachmentFile> {
  Widget child = Image.asset("assets/images/file.png");

  @override
  void initState() {
    super.initState();

    setTimeout(200, init);
  }

  void init() {
    String thumbnailStr = "";
    Image? thumbnail;
    List<Map<String, String>> files = [];

    if (widget.attachmentList.length == 1) {
      Attachment attachment = widget.attachmentList[0];
      Map<String, String> file = {
        "url": "",
        "imgUrl":
            "https://www.iconpacks.net/icons/2/free-file-icon-1453-thumb.png",
        "fileType": attachment.fileType ?? "",
        "fileName": attachment.fileName ?? "sscconnect_${DateTime.now()}",
      };

      if (attachment.fileType != null) {
        if (attachment.fileType!.contains("image")) {
          String realImageUrl = urlFor(
            "/attachment/view?id=${attachment.id}&key=${attachment.key}",
          );

          thumbnailStr = urlFor(
            "/attachment/thumbnail?id=${attachment.id}&key=${attachment.key}",
          );
          file["url"] = realImageUrl;
          file["imgUrl"] = realImageUrl;
        } else if (attachment.fileType!.contains("pdf")) {
          thumbnail = Image.asset("assets/images/pdf.png");

          file["url"] = urlFor(
              "/attachment/view?id=${attachment.id}&key=${attachment.key}");
          file["imgUrl"] =
              "https://cdn-icons-png.flaticon.com/512/337/337946.png";
        } else {
          file["url"] = urlFor(
              "/attachment/download?id=${attachment.id}&key=${attachment.key}");
        }

        files = [file];
      }
    } else if (widget.attachmentList.length > 1) {
      thumbnail = Image.asset("assets/images/multiple-file.png");

      for (Attachment attachment in widget.attachmentList) {
        Map<String, String> file = {};

        file["fileName"] =
            attachment.fileName ?? "sscconnect_${DateTime.now()}";
        file["fileType"] = attachment.fileType ?? "image";
        file["imgUrl"] =
            "https://www.iconpacks.net/icons/2/free-file-icon-1453-thumb.png";

        if (attachment.fileType!.contains("image")) {
          String path = urlFor(
            "/attachment/view?id=${attachment.id}&key=${attachment.key}",
          );

          file["url"] = path;
          file["imgUrl"] = path;
        } else {
          file["url"] = urlFor(
            "/attachment/download?id=${attachment.id}&key=${attachment.key}",
          );
        }

        files.add(file);
      }
    }

    if (files.isNotEmpty) {
      child = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierColor: Colors.white,
              pageBuilder: (BuildContext context, _, __) {
                return FullScreenPage(
                  files: files,
                );
              },
            ),
          );
        },
        child: CImage(
          imgUrl: thumbnailStr,
          placeholder: thumbnail?.image,
          width: 65,
          radius: 10,
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: adaptiveWidthSize(context, 10),
      ),
      width: adaptiveWidthSize(context, 70),
      height: adaptiveWidthSize(context, 85),
      child: child,
    );
  }
}
