import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:sscconnect/components/components.dart';

import 'package:sscconnect/utils/utils.dart';

class TakePhoto extends StatefulWidget {
  final int? cameraIndex;
  final String title;
  final ValueChanged<String?> onCameraCaptured;

  const TakePhoto({
    Key? key,
    required this.onCameraCaptured,
    this.cameraIndex,
    this.title = "Take a Photo",
  }) : super(key: key);

  @override
  TakePhotoState createState() => TakePhotoState();
}

class TakePhotoState extends State<TakePhoto> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  int idxCamera = 0;
  bool flashCamera = false;

  XFile? image;

  @override
  void initState() {
    super.initState();

    if (widget.cameraIndex != null) {
      idxCamera = widget.cameraIndex!;
    }

    setTimeout(200, init);
  }

  void init() async {
    cameras = await availableCameras();

    if (cameras == null) return;

    if (cameras!.isEmpty) return;

    controller = CameraController(
      cameras![idxCamera],
      ResolutionPreset.medium,
    );

    if (controller == null) return;

    controller?.initialize().then((_) {
      if (!mounted) return;

      controller?.setFlashMode(flashCamera ? FlashMode.torch : FlashMode.off);
      controller?.lockCaptureOrientation();

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget content() {
    if (image != null) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(File(image?.path ?? "")),
        ),
      );
    }

    if (controller == null) {
      return Center(
        child: Text("Initializing Camera"),
      );
    }

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CameraPreview(controller!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: adaptiveWidthSize(context, 15),
            ),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: adaptiveWidthSize(context, 42.5),
                  color: textColor1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: content(),
          ),
          if (image != null)
            Container(
              margin: EdgeInsets.all(
                adaptiveWidthSize(context, 25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CButtonIcon(
                    Icons.delete_outline,
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    },
                    color: Colors.redAccent,
                  ),
                  CButtonIcon(
                    Icons.done,
                    onPressed: () {
                      widget.onCameraCaptured(image?.path);
                      context.goBack();
                    },
                    color: Colors.green,
                  )
                ],
              ),
            )
          else
            Container(
              margin: EdgeInsets.all(
                adaptiveWidthSize(context, 25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CButtonIcon(
                    flashCamera ? Icons.flash_on : Icons.flash_off,
                    onPressed: () {
                      setState(() {
                        flashCamera = !flashCamera;
                      });

                      controller?.setFlashMode(
                          flashCamera ? FlashMode.torch : FlashMode.off);
                    },
                  ),
                  CButtonIcon(
                    Icons.photo_camera,
                    onPressed: () async {
                      image = await controller?.takePicture();

                      setState(() {});
                    },
                  ),
                  CButtonIcon(
                    Icons.flip_camera_ios,
                    onPressed: () {
                      if (idxCamera == 0) {
                        idxCamera = 1;
                      } else {
                        idxCamera = 0;
                      }

                      setState(() {});

                      init();
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
