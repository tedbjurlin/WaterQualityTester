import 'dart:io';
import 'package:flutter/material.dart';

import 'package:water_quality_app/pages/results.dart';
import 'package:water_test_scanner/water_test_scanning.dart';

// RGB class storing all RGB information from image file
class RGBImageCheckPage extends StatefulWidget {
  // image from camera
  final File image;

  const RGBImageCheckPage(
      {super.key, required this.image, required this.result});

  final ColorDetectionResult result;

  @override
  State<RGBImageCheckPage> createState() => _RGBImageCheckPageState();
}

class _RGBImageCheckPageState extends State<RGBImageCheckPage> {
  List<Color> colors = [];
  List<double> resultValues = [];

  @override
  void initState() {
    super.initState();
    if (widget.result.exitCode == 0) {
      for (ColorOutput result in widget.result.colors) {
        colors.add(Color.fromARGB(255, result.red, result.green, result.blue));
        resultValues.add(result.value);
      }
    } else {
      for (ColorOutput _ in widget.result.colors) {
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
            widget.result.image,
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
          ],
        ),
      ),
    );
  }
}
