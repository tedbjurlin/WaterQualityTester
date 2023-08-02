// This is the Navigation Bar

import 'package:flutter/material.dart';

import 'package:water_quality_app/pages/camera_instructions.dart';
import 'package:water_quality_app/pages/source_description.dart';
import 'package:water_quality_app/pages/test_strip_instructions.dart';
import 'package:water_quality_app/widgets/camera.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // home navigator for all pages
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: const Navigate(),
    );
  }
}

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

// all pages for navigation
class _NavigateState extends State<Navigate> {
  int _selectedIndex = 0;
  // options for page widgets
  static final List<Widget> _widgetOptions = <Widget>[
    const SourceDescriptionPage(),
    WaterInstructionPage(),
    CameraInstructionPage(),
    const CameraPage(),
  ];

  // update the index selected
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // display widget from _widgetoptions list
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff074F57),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(key: Key('descicon'), Icons.integration_instructions),
            label: 'description',
          ),
          BottomNavigationBarItem(
            // Home Page
            icon:
                Icon(key: Key('teststripicon'), Icons.integration_instructions),
            label: 'water strip',
          ),

          BottomNavigationBarItem(
            icon: Icon(key: Key('cameraicon'), Icons.integration_instructions),
            label: 'camera instr',
          ),
          BottomNavigationBarItem(
            // Camera Page
            icon: Icon(key: Key('iconcamera'), Icons.camera),
            label: 'camera',
          ),

          /*
          // EPA Standards Page
          BottomNavigationBarItem(
            icon: Icon(key: Key('iconwater'), Icons.water),
            label: 'EPA Standards',
          ),*/

          /*
          BottomNavigationBarItem(
            // Map Page
            icon: Icon(key: Key('iconmap'), Icons.map),
            label: 'Map',
          ), */
          //BottomNavigationBarItem(
          //icon: Icon(Icons.question_mark), label: 'Results')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: const Color.fromARGB(255, 75, 128, 116),
        onTap: _onItemTapped,
      ),
    );
  }
}
