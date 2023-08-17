import 'package:flutter/material.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({super.key});

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {

  final _unitController = TextEditingController(); // to control user input throughout the program

  num userInput = 0.0; // used num to be type safe in case of int double Type conflicts

  // default screen
  String _fromUnit = "millimeter";
  String _toUnit = "centimeter";
  num resultMessage = 0.1;

  // List for dropdown widget
  final List<String> unitsList = [
    "millimeter",
    "centimeter",
    "inch",
    "foot",
    "meter",
    "decimeter",
    "decameter",
    "kilometer"
  ];

  // map with units as key and numbers as their values
  final Map<String, num> measuresScale = {
    "millimeter": 0,
    "centimeter": 1,
    "inch": 2,
    "foot": 3,
    "meter": 4,
    "decimeter": 5,
    "decameter": 6,
    "kilometer": 7
  };

  // used dynamic type because it can implicitly store any value at runtime
  dynamic formulas = {
    0: [1, 0.1, 0.0393, 0.00328, 0.001, 0.01, 0.0001, 0.000001],
    1: [10, 1, 0.393, 0.0328, 0.01, 0.1, 0.001, 0.00001],
    2: [25.4, 2.54, 1, 0.0833, 0.0254, 0.254, 0.00254, 0.000025],
    3: [304.8, 30.48, 12, 1, 0.3048, 3.048, 0.03048, 0.00030],
    4: [1000, 100, 39.370, 3.280, 1, 10, 0.1, 0.001],
    5: [100, 10, 3.937, 0.328, 0.1, 1, 0.01, 0.0001],
    6: [10000, 1000, 393.7007, 32.808, 10, 100, 1, 0.01],
    7: [1000000, 100000, 39370.0787, 3280.839, 1000, 10000, 100, 1]
  };

  void convert(String unit, String from, String to) {
    // getting values with reference to the key
    num nFrom = measuresScale[from]!;
    debugPrint(nFrom.toString());

    // getting values with reference to the key
    num nTo = measuresScale[to]!;
    debugPrint(nTo.toString());

    // using key it gets the number which should be used for conversion purpose
    num multi = formulas[nFrom][nTo];

    //conversion
    var afterConversion = num.parse(unit) * multi;
    debugPrint(afterConversion.toString());

    // storing converted value to resultMessage
    setState(() {
      resultMessage = num.parse(afterConversion.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        // app bar widget
        appBar: AppBar(
          title: const Text("Unit Converter App"),
          backgroundColor: Colors.blue,
        ),
        // app bar ends

        backgroundColor: Colors.white54,

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
            child: Column(
              children: <Widget>[
                const Text("Units", style: TextStyle(
                    fontSize: 40
                ),
                ),

                const Text("Converter", style: TextStyle(
                    fontSize: 40
                ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: TextField(
                        controller: _unitController,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),

                        cursorColor: Colors.white,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white54,
                          hintText: "Write the value to convert",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),

                            borderSide: const BorderSide(width: 3,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("From: ", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlue
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              items: unitsList.map((String value) {
                                return DropdownMenuItem(value: value,
                                    child: Center(
                                      child: Text(value, style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black
                                      ),),
                                    ));
                              }).toList(),

                              value: _fromUnit,
                              isExpanded: true,
                              dropdownColor: Colors.lightBlueAccent,
                              style: const TextStyle(
                                  fontSize: 15
                              ),

                              hint: const Text("Choose the unit",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black
                                ),),

                              onChanged: (value) {
                                setState(() {
                                  _fromUnit = value!;
                                });
                                debugPrint(_fromUnit);
                              }
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text("To: ", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 30),

                      child: Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.lightBlue
                        ),

                        child: DropdownButtonHideUnderline(
                          child: _dropDownMenu(),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: TextButton(
                        onPressed: () {
                          convert(_unitController.text, _fromUnit, _toUnit);
                        },
                        child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.8),
                              color: Colors.redAccent,
                            ),
                            alignment: Alignment.center,
                            child: const Text("Convert",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),)
                        ),
                      ),
                    ),


                    Text("$resultMessage",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontSize: 40
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _dropDownMenu() =>
      DropdownButton(
      value: _toUnit,
      isExpanded: true,
      dropdownColor: Colors.lightBlueAccent,
      style: const TextStyle(fontSize: 15),
      hint: const Text(
        "Choose the unit",
        style: TextStyle(
            fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black),
      ),
      items: unitsList.map((String value) {
        return DropdownMenuItem(
            value: value,
            child: Center(
              child: Text(
                value,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _toUnit = value!;
        });
        debugPrint(_toUnit);
      });
}





