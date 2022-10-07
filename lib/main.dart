import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

// Author Name: GABRIEL MACHADO VIOLANTE
// Date: 07/10/2022
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
  String _rendaMensa = "";
  String _statusMae = "";
  String _infoText = "Insira suas informações";
  int _matriculado = 0;
  int _vacinado = 0;
  int _auxilio = 0;
  int _filhos = 0;
  TextEditingController quantidadeFilhos = TextEditingController();

  void _calculate() {
    setState(() {
      _filhos = int.parse(quantidadeFilhos.text);
      _auxilio = 0;

      if (quantidadeFilhos.text == "0" || _matriculado == 0 || _vacinado == 0 || _rendaMensa == "Acima de 2 salários mínimos") {
        _infoText = "Não possui direito à auxílio";
        return;
      }
      else if (_statusMae == "Sim") {
        _auxilio += 600;
      }

      _matriculado = 0;
      _vacinado = 0;

      if ( _rendaMensa == "Abaixo de 2 salários mínimos") {
        if (_filhos >= 3) {
          _auxilio += 3636;
          _infoText = "Você possui direito a um auxílio de $_auxilio";
          return;
        }
        else if (_filhos <= 2) {
          _auxilio += 1818;
          _infoText = "Você possui direito a um auxílio de $_auxilio";
        }
      }
      else if ( _rendaMensa == "Abaixo de 1 salário mínimo") {
        if (_filhos >= 3) {
          _auxilio += 3636;
          _infoText = "Você possui direito a um auxílio de $_auxilio";
          return;
        }
        else if(_filhos <= 2) {
          _auxilio += 3030;
          _infoText = "Você possui direito a um auxílio de $_auxilio";
          return;
        }
      }


    });

  }

  void _resetFields() {
    _formKey = GlobalKey<FormState>();
    _rendaMensa = "";
    _statusMae = "";
    quantidadeFilhos.text = "";
    setState(() {
      _infoText = "Insira suas informações";

    });
  }

  void _resetFieldsExceptResult() {
    _formKey = GlobalKey<FormState>();
    _rendaMensa = "";
    _statusMae = "";
    quantidadeFilhos.text = "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ysolutions - Calculadora de Auxílio'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.family_restroom_outlined,
                  size: 120.0,
                  color: Colors.deepPurple,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      child: Text("Selecione o montante da renda mensal familiar"),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text("Abaixo de 2 salários mínimos"),
                      value: "Abaixo de 2 salários mínimos",
                    ),
                    DropdownMenuItem(
                      child: Text("Abaixo de 1 salário mínimo"),
                      value: "Abaixo de 1 salário mínimo",
                    ),
                    DropdownMenuItem(
                      child: Text("Acima de 2 salários mínimos"),
                      value: "Acima de 2 salários mínimos",
                    ),
                  ],
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  iconEnabledColor: Colors.deepPurple,
                  value: _rendaMensa,

                  validator: (value){
                    if (value.toString().isEmpty) {
                      return "Selecione alguma renda";
                    }
                    if (value.toString() == "") {
                      return "Selecione alguma renda";
                    }
                  },

                  onChanged: (String? value) {
                    if (value is String) {
                      setState(() {
                        _rendaMensa = value;
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
                        labelText: 'Quantidade de filhos',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),

                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20.0),

                    controller: quantidadeFilhos,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Insira a quantidade.";
                      }

                      if (double.parse(value.toString()) < 0) {
                        return "Número negativo";
                      }

                      if (num.tryParse(value.toString()) == null) {
                        return "Insira a quantidade";
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 130.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.deepPurple!],
                      [Colors.deepPurple!]
                    ],
                    inactiveBgColor: Colors.black,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Não matriculado', 'Matriculado'],
                    radiusStyle: true,

                    onToggle: (index) {
                      if(index == 0){
                        _matriculado = 0;
                      }
                      if (index == 1){
                        _matriculado = 1;
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 130.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.deepPurple!],
                      [Colors.deepPurple!]
                    ],
                    inactiveBgColor: Colors.black,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Não vacinado', 'Vacinado'],
                    radiusStyle: true,
                    onToggle: (index) {
                      if(index == 0){
                        _vacinado = 0;
                      }
                      if (index == 1){
                        _vacinado = 1;
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(
                      child: Text("Você é uma mãe solteira?"),
                      value: "",
                    ),
                    DropdownMenuItem(
                      child: Text("Sim"),
                      value: "Sim",
                    ),
                    DropdownMenuItem(
                      child: Text("Não"),
                      value: "Não",
                    ),
                  ],
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  iconEnabledColor: Colors.deepPurple,
                  value: _statusMae,

                  validator: (value){
                    if (value.toString().isEmpty) {
                      return "Seleciona alguma opção";
                    }
                    if (value.toString() == "") {
                      return "Selecione alguma opção";
                    }
                  },

                  onChanged: (String? value) {
                    if (value is String) {
                      setState(() {
                        _statusMae = value;
                      });
                    }
                  },
                ),
              )

              ,Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) _calculate(); _resetFieldsExceptResult();
                    },
                    child: Text('Calcular'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
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
