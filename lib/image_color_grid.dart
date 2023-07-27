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
  List<double> resultValues = [];

  late File image;
  late String path;

  @override
  void initState() {
    super.initState();
    image = widget.image;
    path = widget.image.path;
  }

  Future<void> scanColors(String path) async {
    ColorDetectionResult results = await ColorStripDetector.detectColors(path);

    if (results.exitCode == 0) {
      for (ColorOutput result in results.colors) {
        colors.add(Color.fromARGB(255, result.red, result.green, result.blue));
        resultValues.add(result.value);
      }
    } else {
      for (ColorOutput _ in results.colors) {
        colors.add(Colors.red);
        resultValues.add(-1);
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
            Image.file(image),
            ElevatedButton(
              child: const Text("View Results"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ResultsPage(testColors: colors, results: resultValues),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Scan image"),
              onPressed: () async {
                await scanColors(path);
                setState(
                  () {
                    image = File(path);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
