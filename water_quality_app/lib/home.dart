import 'package:flutter/material.dart';
import 'package:water_quality_app/camera.dart';
import 'package:water_quality_app/instructions.dart';
import 'package:water_quality_app/map.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // home navigator for all pages
    return const MaterialApp(
      home: Navigate(),
    );
  }
}

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  int _selectedIndex = 1;
  static final List<Widget> _widgetOptions = <Widget>[
    const CameraPage(),
    const InstructionPage(),
    const MapPage()
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
      appBar: AppBar(title: const Text('Varify Water Tester')
          // add varify logo at some point potentially
          // SizedBox(child: Image.asset('assets/varify_logo.jpg', fit: BoxFit.contain)),
          ),
      body: Center(
        // display widget from _widgetoptions list
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // Camera Page
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            // Home Page
            icon: Icon(Icons.integration_instructions),
            label: 'Instructions',
          ),
          BottomNavigationBarItem(
            // Map Page
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
