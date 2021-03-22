import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final kmController = TextEditingController();
  final priceController = TextEditingController();
  final averageController = TextEditingController();
  double result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Custos de Viagem"),
      ),
      floatingActionButton: createFloatingButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          createTextField(kmController, "Distância", "Km ", TextInputType.number),
          createTextField(priceController, "Preço Combustível", "R\$ ", TextInputType.number),
          createTextField(averageController, "Média Consumo", "Km/L ", TextInputType.number),
        ],
      )
    );
  }

  void calcule() {
    try {
      double kmValue = double.parse(kmController.text);
      double priceValue = double.parse(priceController.text);
      double averageValue = double.parse(averageController.text);
      double necessaryFuel = kmValue / averageValue;
      result = necessaryFuel * priceValue;
      showMessage(context, "Resultado", "O custo para a viagem é de R\$ " + result.toStringAsFixed(2));
    } catch (e) {
      showMessage(context, 'Atenção!', 'Você deve informar todos os campos corretamente!');
    }
  }

  Widget createFloatingButton() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      child: Icon(Icons.attach_money_outlined, color: Colors.white, size: 40,),
      onPressed: calcule
    );
  }

  Widget createTextField(TextEditingController ctx, String label, String prefix, TextInputType ktype) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: ctx,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
            prefixText: prefix,
            prefixStyle: TextStyle(color: Colors.blue, fontSize: 26)
        ),
        style: TextStyle(color: Colors.blue, fontSize: 32),
        keyboardType: ktype,
      ),
    );
  }

  void showMessage(BuildContext ctx, String title, String message) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
              TextButton(
                  onPressed: () {
                    _closeActualWindow(ctx);
                  },
                  child: Text("Ok")
              ),
            ],
          );
        }
    );
  }

  void _closeActualWindow(BuildContext context) {
    Navigator.pop(context);
  }
}

