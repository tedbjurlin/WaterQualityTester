import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:water_test_scanner/water_test_scanning.dart';

import 'package:water_quality_app/objects/chemical_standard.dart'
    show epaStandards;
import 'package:water_quality_app/pages/source_description.dart';
import 'package:water_quality_app/widgets/chemical_result_listing.dart';

import '../objects/app_state.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.results, required this.waterType, required this.waterInfo});

  final String waterType;
  final String waterInfo;
  final ColorDetectionResult results;

  static const resultsPageTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Comfortaa',
  );

  Widget resultsPageButton(
          {required String text, required Function() onPressed}) =>
      Container(
        width: 185,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: resultsPageTextStyle,
          ),
        ),
      );

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR $error");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 214, 204),
        leading: IconButton(
          iconSize: 32,
          icon: const Icon(Icons.home_outlined),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const SourceDescriptionPage()),
            (route) => false,
          ),
        ),
        title: const Text(
          'results',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 10),
            child: Column(
              children: [
                Text(
                  'Click on each tile in the list to learn more',
                  style: resultsPageTextStyle,
                ),
                Text(
                  'about the parameters being measured.',
                  style: resultsPageTextStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 16,
              itemBuilder: (context, index) => ChemicalResultListing(
                standard: epaStandards[index],
                result: results.colors[index],
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 7, 79, 87),
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                const Spacer(),
                Consumer<AppState>(builder: (context, appState, child) {
                  return resultsPageButton(
                    text: 'add to database',
                    onPressed: () async {
                      Position loc = await appState.getCurrentPosition();
                      appState.addStrip(results, loc, waterType, DateTime.now());
                    },
                  );
                }),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
