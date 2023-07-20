import 'package:flutter/material.dart';
import 'package:water_quality_app/widgets/camera.dart';

class CameraInstructionPage extends StatelessWidget {
  CameraInstructionPage({super.key});

  // style elevated button
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
      //textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Color.fromRGBO(
          123, 231, 96, 1)); // I want to make this button stand out

  // style cards for listview
  final EdgeInsets margin = const EdgeInsets.symmetric(vertical: 10);
  final TextStyle textstyle =
      const TextStyle(fontSize: 20, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(24, 137, 230, 1),
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
                text: "camera instructions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    //fontWeight: FontWeight.w700,
                    fontFamily: "Comfortaa")),
          ]),
        ),
      ),
      // to scroll through page
      body: Column(
        children: <Widget>[
          // instructions
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ListTile(
                // this tile needs to stand out
                title: Text("Note: TAKE PICTURES USING A DARK BACKGROUND",
                    style: textstyle),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Image(
                  image: AssetImage("assets/icons/one.png"),
                ),
                title: Text("Use the camera in a VERTICAL ORIENTATION",
                    style: textstyle),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Image(
                  image: AssetImage("assets/icons/two.png"),
                ),
                title: Text(
                    "Lineup the water test strip within the border of the overlay",
                    style: textstyle),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Image(
                  image: AssetImage("assets/icons/three.png"),
                ),
                title: Text(
                    "IMPORTANT!!! Put the white part of the test strip at the very top of the image preview",
                    style: textstyle),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Image(
                  image: AssetImage("assets/icons/four.png"),
                ),
                title: Text(
                    "Make sure to use a DARK background (preferably black)",
                    style: textstyle),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
              child: Column(
                  //height: 100.0,
                  //width: 18.0,
                  children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromRGBO(24, 137, 230, 1),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    key: const Key('cameraButton'),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    icon: Icon(Icons.photo_camera),
                    iconSize: 100,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "open camera",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: "Comfortaa"),
                )
              ])),
        ],
      ),
    );
  }
}
