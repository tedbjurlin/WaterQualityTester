import 'package:flutter/material.dart';
import 'package:water_quality_app/widgets/camera.dart';

class CameraInstructionPage extends StatelessWidget {
  CameraInstructionPage({super.key});

  // style elevated button
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
      //textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: const Color.fromRGBO(
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
            backgroundColor: const Color(0xffB6D6CC),
            title: const Text("camera instructions",
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
            const SizedBox(
              height: 20,
            ),
            Container(
                color: const Color(0xffDDCFD9),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text("camera instructions",
                            style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontSize: 20,
                                fontWeight: FontWeight.w700))),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      // this tile needs to stand out
                      title: Text("Note: TAKE PICTURES USING A DARK BACKGROUND",
                          style: textstyle),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff1889e6),
                        child: Text(
                          "1",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text("Use the camera in a VERTICAL ORIENTATION",
                          style: textstyle),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff1889e6),
                        child: Text(
                          "2",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                          "Lineup the water test strip within the border of the overlay",
                          style: textstyle),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff1889e6),
                        child: Text(
                          "3",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                          "IMPORTANT!!! Put the white part of the test strip at the very top of the image preview",
                          style: textstyle),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xff1889e6),
                        child: Text(
                          "4",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                          "Make sure to use a DARK background (preferably black)",
                          style: textstyle),
                    ),
                    const SizedBox(
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
                      padding: const EdgeInsets.all(10),
                      color: Colors.black,
                      icon: const Icon(Icons.camera_alt),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CameraPage(),
                            ),
                            (route) => false);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "open camera",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "Comfortaa"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ])),
          ],
        ));
  }
}
