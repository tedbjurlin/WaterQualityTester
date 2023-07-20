import 'dart:io';
import 'package:flutter/material.dart';

import 'package:water_quality_app/results.dart';
import 'package:water_test_scanner/water_test_scanning.dart';

// RGB class storing all RGB information from image file
class RGBImageCheckPage extends StatefulWidget {
  // image from camera
  final File image;

  const RGBImageCheckPage({super.key, required this.image});

  @override
  State<RGBImageCheckPage> createState() => _RGBImageCheckPageState();
}

class _RGBImageCheckPageState extends State<RGBImageCheckPage> {
  List<Color> colors = [];

  @override
  void initState() {
    super.initState();
    scanColors(widget.image);
  }

  void scanColors(File image) async {
    ColorDetectionResult results =
        await ColorStripDetector.detectColors(image.path);

    if (results.exitCode == 0) {
      for (ColorOutput result in results.colors) {
        colors.add(Color.fromARGB(255, result.red, result.blue, result.green));
      }
    } else {
      for (ColorOutput _ in results.colors) {
        colors.add(Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // See results from image
            ElevatedButton(
              child: const Text("View Results"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(testColors: colors),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
