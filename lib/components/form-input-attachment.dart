import 'dart:io' as file01;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:sscconnect/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class FormInputAttachment extends StatefulWidget {
  final ValueChanged onChange;
  final bool isMultiple;
  final List<String>? pathList;

  const FormInputAttachment({
    required this.onChange,
    required this.isMultiple,
    this.pathList,
    super.key,
  });

  @override
  State<FormInputAttachment> createState() => _FormInputAttachmentState();
}

class _FormInputAttachmentState extends State<FormInputAttachment> {
  List<String> filePathList = [];
  String? fileDelete;

  @override
  void initState() {
    super.initState();

    if (widget.pathList != null) {
      if (widget.pathList!.isNotEmpty) {
        setState(() {
          filePathList = widget.pathList!;
        });
      }
    }
  }

  String renamePathFile(String filePath) {
    List<String> fileType = filePath.split(".");

    String dir = path.dirname(filePath);
    File renamePath = File(filePath);

    return renamePath
        .renameSync(
          path.join(
            dir,
            "SSCConnect-Image-${DateTime.now().toString().split(" ").join("-")}.${fileType.last}",
          ),
        )
        .path;
  }

  Future galleryTap() async {
    final XFile? result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (result == null) {
      return;
    }

    String resultPath = result.path;
    File compress = await compressFile(File(resultPath));

    resultPath = renamePathFile(compress.path);

    if (widget.isMultiple) {
      filePathList.insert(0, resultPath);
    } else {
      filePathList = [resultPath];
    }

    widget.onChange(filePathList);

    setState(() {});
    context.goBack();
  }

  void cameraTap() {
    context.goBack();
    context.showBottomSheet(
      (context) => TakePhoto(
        cameraIndex: 0,
        onCameraCaptured: (String? filePath) {
          if (filePath != null) {
            String resultPath = renamePathFile(filePath);

            if (widget.isMultiple) {
              filePathList.insert(0, resultPath);
            } else {
              filePathList = [resultPath];
            }

            widget.onChange(filePathList);

            setState(() {});
          }
        },
      ),
    );
  }

  Future fileTap() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) {
      return;
    }

    if (widget.isMultiple) {
      filePathList.insert(0, result.paths[0]!);
    } else {
      filePathList = [result.paths[0]!];
    }

    widget.onChange(filePathList);

    setState(() {});
    context.goBack();
  }

  Widget buttonIcon(
    Function() onTap,
    IconData icon,
    String text,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CButtonIcon(icon, onPressed: onTap),
          Padding(
            padding: EdgeInsets.only(
              top: adaptiveWidthSize(context, 5),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 30),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fileSourceWidget() {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: adaptiveWidthSize(context, 40),
            bottom: adaptiveWidthSize(context, 15),
          ),
          child: Center(
            child: Text(
              "Add attachment via",
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 35),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        CSeparator(),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: adaptiveWidthSize(context, 35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonIcon(cameraTap, Icons.photo_camera, "Camera"),
              buttonIcon(galleryTap, Icons.collections, "Gallery"),
              buttonIcon(fileTap, Icons.folder, "File"),
            ],
          ),
        ),
      ],
    );
  }

  Widget addWidget() {
    return Container(
      margin: EdgeInsets.all(2),
      width: adaptiveWidthSize(context, 110),
      height: adaptiveWidthSize(context, 150),
      child: GestureDetector(
        onTap: () {
          context.showBottomSheet((context) => fileSourceWidget());
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(.3),
          ),
          child: Center(
            child: Icon(
              Feather.plus,
              size: adaptiveWidthSize(context, 40),
            ),
          ),
        ),
      ),
    );
  }

  Widget item(String path) {
    file01.File file = file01.File(path);
    Image thumbnail = Image.asset("assets/images/file.png");

    // File file = File(item[]);
    // String basename = basename(file.path);

    if (path.split(".").last == "pdf") {
      thumbnail = Image.asset("assets/images/pdf.png");
    } else if (path.split(".").last == "xlsx") {
      thumbnail = Image.asset("assets/images/xlsx.png");
    } else if (path.split(".").last == "docx" ||
        path.split(".").last == "doc") {
      thumbnail = Image.asset("assets/images/docx.png");
    } else {
      thumbnail = Image.file(file);
    }

    return Container(
      margin: EdgeInsets.all(2),
      width: adaptiveWidthSize(context, 110),
      height: adaptiveWidthSize(context, 150),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: thumbnail.image,
            opacity: fileDelete == path ? 0.5 : 1,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey //.withAlpha(9),
          ),
      child: fileDelete == path
          ? Center(
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!path.split('/').last.contains("image_picker") &&
                    !path.split('/').last.contains("CAP"))
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.black.withOpacity(.3), //.withAlpha(9),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      path.split('/').last,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  )
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          addWidget(),
          ...filePathList
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    if (fileDelete == null) {
                      String findItem =
                          filePathList.firstWhere((el) => el == e);

                      fileDelete = findItem;
                      setState(() {});

                      setTimeout(3000, () {
                        fileDelete = null;
                        setState(() {});
                      });
                    } else {
                      filePathList.removeWhere((el) => el == e);
                      fileDelete = null;

                      setState(() {});
                    }
                  },
                  child: item(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 50,
  );

  return compressedFile;
}
