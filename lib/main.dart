import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

// Author Name: GABRIEL MACHADO VIOLANTE
// Date: 23/09/2022
// Turma: 303
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _userData = "";
  String _infoText = "Insert your data";
  TextEditingController volumeController = TextEditingController();

  void _calculate() {
    setState(() {
      double volume = double.parse(volumeController.text);
      String typeOfPerson = double.parse(heightController.text) / 100.0;

      _infoText = "Foi";
    });

  }

  void _resetFields() {
    _formKey = GlobalKey<FormState>();
    _userData = "";
    volumeController.text = "";
    setState(() {
      _infoText = "Insert your Data";

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Caffeine Check'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () { _resetFields(); },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.coffee_rounded,
                  size: 120.0,
                  color: Colors.brown,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      child: Text("Select who you are"),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text("Healthy Adult"),
                      value: "Healthy Adult",
                    ),
                    DropdownMenuItem(
                      child: Text("Children"),
                      value: "Children",
                    ),
                    DropdownMenuItem(
                      child: Text("Pregnant or Lactating"),
                      value: "Pregnant or Lactating",
                    ),
                    DropdownMenuItem(
                      child: Text("Caffeine Sensitive"),
                      value: "Caffeine Sensitive",
                    ),
                  ],
                  isExpanded: true,
                  style: const TextStyle(color: Colors.brown, fontSize: 20),
                  iconEnabledColor: Colors.brown,
                  value: _userData,
                  onChanged: (String? value) {
                    if (value is String) {
                      setState(() {
                        _userData = value;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Ammount of Coffe (ml)',
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 20)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.brown, fontSize: 20.0),
                    controller: volumeController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Insert a valid volume";
                      }

                      if (double.parse(value.toString()) > 4000) {
                        return "You didn't drink that much coffe";
                      }

                      if (double.parse(value.toString()) < 0) {
                        return "You can't drink negative coffe";
                      }

                      if (num.tryParse(value.toString()) == null) {
                        return "Insert a valid volume";
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 100.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.brown!],
                      [Colors.brown!]
                    ],
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Espresso', 'Brewed'],
                    radiusStyle: true,
                    onToggle: (index) {
                      print('switched to: $index');
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calculate();
                    },
                    child: Text('Check'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
