import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:water_quality_app/begin.dart';
import 'package:water_quality_app/home.dart';
import 'package:water_quality_app/map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:water_quality_app/firebase.dart' as firebase;

class ResultsPage extends StatefulWidget {
  final List<Color> testColors;
  final List<double> results;

  const ResultsPage(
      {super.key, required this.testColors, required this.results});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  // initial values for minerals
  // final String _totalAlkValue = "";
  // final String _sodiumChlorideValue = "";
  // final String _flourideValue = "";
  // final String _zincValue = "";
  // final String _sulfateValue = "";
  // final String _nitriteValue = "";
  // final String _nitrateValue = "";
  // final String _mercuryValue = "";
  // final String _totalChlorineValue = "";
  // final String _manganeseValue = "";
  // final String _leadValue = "";
  // final String _copperValue = "";
  // final String _ironValue = "";
  // final String _hydrogenSulfideValue = "";
  // final String _hardnessValue = "";
  // final String _pHValue = "";

  // THIS DOES NOT RECOGNIZE THE DIRECTORY FOR SOME REASON
  // declare all values using rgb generator functions for each of the minerals tested
  // _ResultsPageState() {
  //   compareTestToSampleToGetValue(
  //           'assets/Varify Color Samples/TotalAlk_Colors', widget.testColors[0])
  //       .then((val) => setState(() {
  //             _totalAlkValue = val!;
  //           }));
  // }

  // current names for each mineral
  List<String> namesList = [
    "pH",
    "Hardness",
    "Hydrogen Sulfide",
    "Iron",
    "Copper",
    "Lead",
    "Manganese",
    "Total Chlorine",
    "Mercury",
    "Nitrate",
    "Nitrite",
    "Sulfate",
    "Zinc",
    "Flouride",
    "Sodium Chloride",
    "Total Alkalinity"
  ];

  List<List<double>> acceptableLimits = [
    [6.5, 8.5],
    [0, 425],
    [0, 0],
    [0, 0.3],
    [0, 1.0],
    [0, 15.0],
    [0, 0.1],
    [0, 3.0],
    [0, 0.002],
    [0, 10.0],
    [0, 1.0],
    [0, 200.0],
    [0, 5.0],
    [0, 4.0],
    [0, 250.0],
    [40.0, 180.0]
  ];

  final firebase.Firestore _firestore = firebase.Firestore();

  // displays a different color flag based on if
  // the mineral is reaching dangerous levels
  flagCheck(double upperbound, double lowerbound, double value) {
    if (upperbound < value) {
      return const Color.fromARGB(255, 248, 18, 2);
    }
    if (value < lowerbound) {
      return const Color.fromARGB(255, 162, 30, 20);
    } else {
      return Colors.green;
    }
  }

  // text style
  final TextStyle textstyle2 = GoogleFonts.oswald(
      fontSize: 14,
      textStyle: const TextStyle(color: Colors.black, letterSpacing: .5));

  // column filler widget
  Widget columnFiller = const SizedBox(
    width: 50,
    height: 5,
  );

  // style the elevated buttons
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.teal);

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
        backgroundColor: Colors.black,
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "RESULTS",
                style: TextStyle(
                    color: Color.fromARGB(255, 49, 227, 209),
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
          ]),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 190,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            namesList[index],
                            style: textstyle2,
                          ),
                        ),
                        Icon(
                          Icons.square,
                          color: widget.testColors[index],
                        ),
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.results[index].toString(),
                            style: textstyle2,
                          ),
                        ),
                        Icon(Icons.flag,
                            color: flagCheck(
                                acceptableLimits[index][1],
                                acceptableLimits[index][0],
                                widget.results[index]))
                      ],
                    ),
                  );
                }),
          ),
          columnFiller,
          const SizedBox(height: 20),
          Center(
            // buttons for adding data to database,
            // adding your location to the map,
            // and returning to home page
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    child: Text(
                      "Add to Database",
                      style: textstyle2,
                    ),
                    onPressed: () {
                      _firestore.addToCollections(
                          widget.results[0],
                          widget.results[1],
                          widget.results[2],
                          widget.results[3],
                          widget.results[4],
                          widget.results[5],
                          widget.results[6],
                          widget.results[7],
                          widget.results[8],
                          widget.results[9],
                          widget.results[10],
                          widget.results[11],
                          widget.results[12],
                          widget.results[13]);
                    },
                  ),
                ),
                columnFiller,
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    child: Text(
                      "Plot your Location",
                      style: textstyle2,
                    ),
                    onPressed: () async {
                      getUserCurrentLocation().then(
                        (value) async {
                          debugPrint("${value.latitude} ${value.longitude}");
                          //add location to database
                          _firestore.addLocationToCollections(
                              GeoPoint(value.latitude, value.longitude));
                          // marker added for current users location
                          // MARKER LIST CURRENTLY RESETS WHEN APP IS CLOSED
                          markerList.add(
                            Marker(
                              markerId:
                                  MarkerId((markerList.length + 1).toString()),
                              position: LatLng(value.latitude, value.longitude),
                              infoWindow: const InfoWindow(
                                title: 'Current Location',
                              ),
                            ),
                          );
                        },
                      );
                      // go to home page after plot
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          )).then((value) => setState(() {}));
                      //adds the location to files in database
                    },
                  ),
                ),
                columnFiller,
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    child: Text(
                      "Return to Home Page",
                      style: textstyle2,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Front(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
