import 'package:flutter/material.dart';
import 'package:water_quality_app/pages/camera_instructions.dart';
import 'package:water_quality_app/pages/test_strip_instructions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // home navigator for all pages
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: SourceDescriptionPage(),
    );
  }
}

class SourceDescriptionPage extends StatefulWidget {
  const SourceDescriptionPage({Key? key}) : super(key: key);
  @override
  _SourceDescriptionPageState createState() => _SourceDescriptionPageState();
}

class _SourceDescriptionPageState extends State<SourceDescriptionPage> {
  // style elevated button
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
      //textStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Color.fromRGBO(
          123, 231, 96, 1)); // I want to make this button stand out

  var _formKey;
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();

  // style cards for listview
  final EdgeInsets margin = const EdgeInsets.symmetric(vertical: 10);
  final TextStyle textstyle = const TextStyle(
      fontSize: 20, fontStyle: FontStyle.italic, fontFamily: "Sans");

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Drinking Water"), value: "DW"),
      DropdownMenuItem(child: Text("Pond Water"), value: "Pond"),
      DropdownMenuItem(child: Text("Surface Water"), value: "SW"),
      DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffB6D6CC),
            title: Text("Water Source Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Comfortaa"))),

        // to scroll through page
        body: Center(
            child: Column(children: [
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

                  // DropDown Box
                  Text(
                    "Select what type of water source this is",
                    style: TextStyle(fontSize: 20, fontFamily: "Comfortaa"),
                  ), // disclaimer should go here about how we are only testing drinking water standards
                  SizedBox(height: 20),
                  Form(
                      key: _dropdownFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Color(0xffF9D5B4),
                              ),
                              validator: (value) => value == null
                                  ? "Select a water source"
                                  : null,
                              dropdownColor: Color(0xffF9D5B4),
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: dropdownItems),

                          SizedBox(
                            height: 20,
                          ),

                          // Description of water
                          Text(
                            "Describe where you got the water sample from (ie from a sink in your basement vs kitchen...)",
                            style: TextStyle(
                                fontSize: 20, fontFamily: "Comfortaa"),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Source Type',
                              labelText: 'Enter water source type',
                            ),
                          ),

                          const SizedBox(height: 20),

                          // NEXT BUTTON
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
                                    padding: EdgeInsets.all(10),
                                    color: Colors.black,
                                    icon: Icon(Icons.arrow_forward),
                                    iconSize: 100,
                                    onPressed: () {
                                      if (_dropdownFormKey.currentState!
                                          .validate()) {
                                        // check to make sure there is an input
                                        if (selectedValue != "DW") {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text("Disclaimer",
                                                  style: TextStyle(
                                                      fontFamily: "Comfortaa")),
                                              content: const Text(
                                                  "This only tests water for EPA drinking water standards",
                                                  style: TextStyle(
                                                      fontFamily: "Sans")),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WaterInstructionPage(),
                                                      ),
                                                    );
                                                    // then go to the next page
                                                  },
                                                  child: Container(
                                                    color: Color(0xffB6D6CC),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: const Text("OKAY",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Comfortaa",
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } // check to see if it is drinking water
                                        // then add alert dialog box and move on, else move on

                                        else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WaterInstructionPage(),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "next",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: "Comfortaa"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ]))
                        ],
                      ))
                ],
              ))
        ])));
  }
}
