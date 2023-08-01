import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'package:water_quality_app/pages/image_color_grid.dart';
import 'package:water_quality_app/main.dart';
import 'package:water_test_scanner/water_test_scanning.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

abstract class FrameHandler<T> {
  abstract StreamController<T> detectionResultStreamController;

  Future<void> detect(Uint8List image, int imageWidth, int imageHeight,
      Uint8List key, int keyWidth, int keyHeight, bool isYUV);
}

Uint8List concatenatePlanes(List<Plane> planes) {
  final WriteBuffer allBytes = WriteBuffer();
  for (var plane in planes) {
    allBytes.putUint8List(plane.bytes);
  }
  return allBytes.done().buffer.asUint8List();
}

class OpenCvFramesHandler extends FrameHandler<ColorDetectionResult> {
  @override
  StreamController<ColorDetectionResult> detectionResultStreamController;

  OpenCvFramesHandler(this.detectionResultStreamController);

  @override
  Future<void> detect(Uint8List image, int imageWidth, int imageHeight,
      Uint8List key, int keyWidth, int keyHeight, bool isYUV) async {
    final ColorDetectionResult result = await ColorStripDetector.detectColors(
        image, imageWidth, imageHeight, key, keyWidth, keyHeight, isYUV);
    detectionResultStreamController.add(result);
  }
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  bool _isCameraInitialized = false;
  bool _isDetecting = false;
  late Uint8List keyList;
  final OpenCvFramesHandler detectHandler =
      OpenCvFramesHandler(StreamController<ColorDetectionResult>());
  late Image image;
  late StreamSubscription<ColorDetectionResult> subscription;
  bool _isImageInitialized = false;

  void callFrameDetection(CameraImage image) async {
    _isDetecting = true;
    Uint8List bytes = concatenatePlanes(image.planes);
    print(bytes.lengthInBytes);
    print(image.format.group);
    await detectHandler.detect(bytes, image.width, image.height, keyList, 160,
        710, image.format.group == ImageFormatGroup.yuv420);
    print('finished');
    _isDetecting = false;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    // previous camera controller
    final previousCameraController = controller;

    // instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      subscription =
          detectHandler.detectionResultStreamController.stream.listen((data) {
        setState(() {
          print('listen');
          print(data.image);
          print(data.image.width);
          print(data.image.height);
          image = data.image;
          _isImageInitialized = true;
        });
      });
      final ByteData keyBytes =
          await rootBundle.load('assets/colorkeyasset.png');
      keyList = keyBytes.buffer.asUint8List();
      await cameraController.initialize().then((_) {
        setState(() {
          _isCameraInitialized = controller!.value.isInitialized;
        });
        if (!mounted) {
          return;
        }
        cameraController.startImageStream((image) {
          if (!_isDetecting && mounted) {
            callFrameDetection(image);
            print('detected');
          }
        });
      });
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffB6D6CC),
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "camera",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Comfortaa")),
          ]),
        ),
      ),
      body: Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          Positioned.fill(
            // if camera is initialized then give preview
            child: _isCameraInitialized
                ? AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: _isImageInitialized
                        ? image
                        : CameraPreview(controller!))
                : Container(),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              // overlay border image
              child: Image.asset('assets/camera/two_vert_lines.png'),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.large(
      //   backgroundColor: Color(0xffB6D6CC),
      //   onPressed: () async {
      //     // take the picture in a try / catch block
      //     try {
      //       if (_isCameraInitialized) {
      //         // turn off flash (affects light vs dark colors)
      //         controller!.setFlashMode(FlashMode.off);
      //         // take a picture and get the XFile as File
      //         XFile imageXFile = await controller!.takePicture();
      //         File imageFile = File(imageXFile.path);

      //         if (!mounted) return;

      //         // If the picture was taken, display with results
      //         await Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) => RGBImageCheckPage(
      //               image: imageFile,
      //             ),
      //           ),
      //         );
      //       }
      //     } catch (e) {
      //       // log the error to the console, if error occurs
      //       debugPrint(e.toString());
      //     }
      //   },
      //   child: const Icon(Icons.camera_alt),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
