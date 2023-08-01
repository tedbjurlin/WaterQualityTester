import 'package:flutter/material.dart';
import 'package:water_quality_app/pages/test_strip_instructions.dart';
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
  final TextStyle textstyle = const TextStyle(
      fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "Sans");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffB6D6CC),
            title: Text("camera instructions",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Comfortaa"))),
        // to scroll through page
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                color: Color(0xffDDCFD9),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text("camera instructions",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 20,
                                fontWeight: FontWeight.w700))),
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
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text(
                          "1",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xff1889e6),
                      ),
                      title: Text("Use the camera in a VERTICAL ORIENTATION",
                          style: textstyle),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text(
                          "2",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xff1889e6),
                      ),
                      title: Text(
                          "Lineup the water test strip within the border of the overlay",
                          style: textstyle),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text(
                          "3",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xff1889e6),
                      ),
                      title: Text(
                          "IMPORTANT!!! Put the white part of the test strip at the very top of the image preview",
                          style: textstyle),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Text(
                          "4",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xff1889e6),
                      ),
                      title: Text(
                          "Make sure to use a DARK background (preferably black)",
                          style: textstyle),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            const SizedBox(height: 20),
            SizedBox(
                child: Column(
                    //height: 100.0,
                    //width: 18.0,
                    children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0xffB6D6CC),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      key: const Key('cameraButton'),
                      padding: EdgeInsets.all(10),
                      color: Colors.black,
                      icon: Icon(Icons.camera_alt),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ])),
          ],
        ));
  }
}
