import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../../Styles/Colors.dart';

class showImage extends StatefulWidget {
  final imageURL;
  final imageFile;
  const showImage({this.imageURL, this.imageFile, super.key});

  @override
  State<showImage> createState() => _showImageState();
}

class _showImageState extends State<showImage> {
  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    super.initState();
    controller = TransformationController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (widget.imageFile == null && widget.imageURL != null) {
      final uri = Uri.parse(widget.imageURL);
      final res = await http.get(uri);
      final bytes = res.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image.jpg';
      File(path).writeAsBytesSync(bytes);
      Share.shareXFiles([XFile(path)]);
    } else {
      Share.shareXFiles([XFile(widget.imageFile)]);
    }
    sharePositionOrigin:
    box!.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backwardsCompatibility: true,
            actions: [
              IconButton(
                  onPressed: () => share(context),
                  icon: const Icon(
                    Icons.share,
                  ))
            ],
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: GestureDetector(
              onDoubleTapDown: ((details) => tapDownDetails = details),
              onDoubleTap: () {
                final position = tapDownDetails!.localPosition;
                final double scale = 3;
                final x = -position.dx * (scale - 1);
                final y = -position.dy * (scale - 1);
                final zoomed = Matrix4.identity()
                  ..translate(x, y)
                  ..scale(scale);
    
                final value =
                    controller.value.isIdentity() ? zoomed : Matrix4.identity();
                controller.value = value;
              },
              // onVerticalDragStart: (details) => Navigator.of(context).pop(),
              // onVerticalDragCancel: ,
              // dragStartBehavior: DragStartBehavior.down,
              // child: Expanded(
              // child: Center(
              // height: size.height,
              // width: size.width,
              child: InteractiveViewer(
                // onInteractionStart: (details) {
                // (details) => Navigator.of(context).pop();
                // },
                constrained: true,
                alignPanAxis: true,
                transformationController: controller,
                // boundaryMargin: EdgeInsets.symmetric(vertical: 20),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                panEnabled: true,
                scaleEnabled: true,
                minScale: 0.5,
                maxScale: 10,
                child: Center(
                  child: SizedBox(
                    width: size.width,
                    child: widget.imageFile != null
                        ? Image.file(
                            widget.imageFile,
                            fit: BoxFit.contain,
                            errorBuilder: (context, url, error) => const Center(
                                child: Text(
                              "Картинка недоступна.\n Возможно нет картинки",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                          )
                        : Image.network(widget.imageURL,
                            fit: BoxFit.contain,
                            errorBuilder: (context, url, error) => const Center(
                                    child: Text(
                                  "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                )),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.blue,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ));
                            }),
                  ),
                ),
                // ),
              ),
              // ),
            ),
          )),
    );
  }
}
