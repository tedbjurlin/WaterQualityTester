import 'package:flutter/material.dart';
import 'package:water_quality_app/pages/camera_instructions.dart';

class WaterInstructionPage extends StatelessWidget {
  WaterInstructionPage({super.key});

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
            title: const Text("Testing Strip Instructions",
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
                color: const Color(0xffF9D5B4),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                      child: Text("water test strip instructions",
                          style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 20,
                              fontWeight: FontWeight.w700))),
                  const SizedBox(
                    height: 20,
                  ),
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
                      title: Text("Remove one test strip from package",
                          style: textstyle)),
                  const SizedBox(
                    height: 20,
                  ),
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
                          "Submerge test strip in water source or into a cup of water from the water source",
                          style: textstyle)),
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
                          "Within 60 seconds take a picture of test strip",
                          style: textstyle)),
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
                      title: Text("After 60 seconds dispose of test strip",
                          style: textstyle)),
                  const SizedBox(
                    height: 20,
                  ),
                ])),
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
                      key: const Key('nextButton'),
                      padding: const EdgeInsets.all(10),
                      color: Colors.black,
                      icon: const Icon(Icons.arrow_forward_outlined),
                      iconSize: 100,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraInstructionPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "next",
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
