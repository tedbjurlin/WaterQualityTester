import 'package:flutter/material.dart';
import 'package:water_quality_app/home.dart';

class FrontPage extends StatelessWidget {
  FrontPage({super.key});
        @override
        Widget build(BuildContext context) {
          return MaterialApp(
            home: Front(),
        );
        }
}
class Front extends StatefulWidget {
  const Front ({Key? key}) : super(key: key);
 
  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
   String _buttonText = "Test My Water";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Quality Tester"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Text(
                  "Water Testing Made Easy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize: 30
                  ),
                  ),
            ),
            TextButton(
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.cyan,
                  elevation: 2,
                  backgroundColor: Colors.white
                  ),
              child: Text(
                _buttonText,
                style: const TextStyle(fontSize: 20),
              ),
            ),
  
          ],
      ),
      ),
    );
  }
}
