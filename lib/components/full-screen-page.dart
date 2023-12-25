import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:sscconnect/components/components.dart';
import 'package:sscconnect/components/pdf-viewer.dart';
import 'package:sscconnect/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class FullScreenPage extends StatefulWidget {
  final List<Map<String, String>> files;
  final int? pageIdx;
  final String? title;
  final bool? readOnly;

  const FullScreenPage({
    required this.files,
    this.pageIdx,
    this.title,
    this.readOnly = false,
    super.key,
  });

  @override
  FullScreenPageState createState() => FullScreenPageState();
}

class FullScreenPageState extends State<FullScreenPage> {
  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  final ReceivePort _port = ReceivePort();
  // this will keep track of the current page index
  int pageIndex = 0;
  // this is your page controller, which controls the page transition
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();

    if (widget.pageIdx != null) {
      setTimeout(200, () {
        setState(() {
          pageIndex = widget.pageIdx!;
          _controller.jumpToPage(pageIndex);
        });
      });
    }

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];

      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "File downloaded",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');

    send!.send([id, status, progress]);
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (!widget.files.elementAt(pageIndex)["fileType"]!.contains("pdf")) {
      if (_transformationController.value != Matrix4.identity()) {
        _transformationController.value = Matrix4.identity();
      } else {
        final position = _doubleTapDetails!.localPosition;
        // For a 3x zoom
        _transformationController.value = Matrix4.identity()
          ..translate(-position.dx * 2, -position.dy * 2)
          ..scale(3.0);
        // Fox a 2x zoom
        // ..translate(-position.dx, -position.dy)
        // ..scale(2.0);
      }
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;

    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      // print("Cannot get download folder path");
    }

    return directory?.path;
  }

  Future downloadFile() async {
    String? response = await getDownloadPath();

    await FlutterDownloader.enqueue(
      url: widget.files[pageIndex]["url"].toString(),
      savedDir: response!,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
      saveInPublicStorage: true,
      fileName: widget.files[pageIndex]["fileName"].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CAppBar(
        widgetTitle: Column(
          children: [
            Text(
              widget.title ?? "",
              style: TextStyle(
                fontSize: adaptiveWidthSize(context, 30),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          if (widget.files.elementAt(pageIndex)["fileType"] != "" &&
              !widget.readOnly!)
            Padding(
              padding: EdgeInsets.only(
                top: adaptiveWidthSize(context, 5),
                right: adaptiveWidthSize(context, 10),
              ),
              child: IconButton(
                onPressed: () {
                  downloadFile();
                },
                icon: Icon(
                  Icons.download,
                  size: adaptiveWidthSize(context, 20),
                  color: secondaryColor,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: Center(
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: PageView.builder(
                      controller: _controller,
                      // here you can remove swipe gesture. UNCOMMENT IT
                      // physics:new NeverScrollableScrollPhysics()
                      onPageChanged: (index) {
                        // with each change updating the index of our variable too
                        setState(() => pageIndex = index);
                      },
                      itemCount: widget.files.length,
                      // building the view of our gallery
                      itemBuilder: (BuildContext context, int position) {
                        return widget.files
                                .elementAt(position)["fileType"]!
                                .contains("pdf")
                            ? PdfViewer(
                                url: widget.files
                                    .elementAt(position)["url"]
                                    .toString(),
                                fileName: widget.files
                                    .elementAt(position)["fileName"]
                                    .toString(),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: adaptiveWidthSize(context, 10),
                                ),
                                child: CImage(
                                  imgUrl: widget.files
                                      .elementAt(position)["imgUrl"]
                                      .toString(),
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  radius: 5,
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(adaptiveWidthSize(context, 5)),
          ),
          if (!widget.readOnly!)
            Expanded(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ...widget.files
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            int findIndex =
                                widget.files.indexWhere((el) => e == el);

                            _transformationController.value =
                                Matrix4.identity();

                            setState(() {
                              pageIndex = findIndex;
                            });

                            _controller.jumpToPage(findIndex);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: adaptiveWidthSize(context, 5),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: adaptiveWidthSize(context, 5),
                            ),
                            child: CImage(
                              imgUrl: e["imgUrl"] ?? "",
                              width: 100,
                              height: 100,
                              radius: 5,
                            ),
                          ),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: adaptiveWidthSize(context, 5),
            ),
          ),
        ],
      ),
    );
  }
}
