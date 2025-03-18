import 'package:flutter/material.dart';

class CalculadoraChris extends StatefulWidget {
  @override
  _CalculadoraChrisState createState() => _CalculadoraChrisState();
}

class _CalculadoraChrisState extends State<CalculadoraChris> {
  //Declaracion de variables
  String resultado = "0";
  String _resultado = "";
  double numero1 = 0;
  double numero2 = 0;
  String operador = "";

  //Funcion clear o limpiar
  void limpiar() {
    _resultado = "0";
    numero1 = 0;
    numero2 = 0;
    operador = "";
  }

  //Presiona un boton
  void presionarBoton(String textoBoton) {
    //Control para limpiar
    if (textoBoton == "C") {
      limpiar();
    }
    //Control para verificar el operador
    else if (["+", "-", "/", "x"].contains(textoBoton)) {
      numero1 = double.parse(resultado);
      operador = textoBoton;
      _resultado = "0";
    }

    //Control para realizar la operacion
    else if (textoBoton == "=") {
      numero2 = double.parse(resultado);
      switch (operador) {
        case "+":
          _resultado = (numero1 + numero2).toString();
          break;
        case "-":
          _resultado = (numero1 - numero2).toString();
          break;
        case "x":
          _resultado = (numero1 * numero2).toString();
          break;
        case "/":
          _resultado = (numero1 / numero2).toString();
          break;
      }

      //limpiar los datos guardados
      numero1 = 0;
      numero2 = 0;
      operador = "";
    } else {
      // Si el resultado es "0", reemplazamos por el número en lugar de concatenarlo
      if (_resultado == "0") {
        _resultado = textoBoton;
      } else {
        _resultado += textoBoton;
      }
    }

    //Actualizar el estado de la pantalla
    setState(() {
      resultado = _resultado;
    });
  }

  Widget construirBoton(String textoBoton) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(24.0),
          foregroundColor: Colors.white, // Color del texto
          backgroundColor: Colors.blue[500],
        ),
        child: Text(
          textoBoton,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => presionarBoton(textoBoton),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CalculadoraChris"),
        centerTitle: true,
        backgroundColor: Colors.blue[500],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              resultado,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Column(
            children: [
              Row(
                children: [
                  construirBoton("7"),
                  construirBoton("8"),
                  construirBoton("9"),
                  construirBoton("/"),
                ],
              ),
              Row(
                children: [
                  construirBoton("4"),
                  construirBoton("5"),
                  construirBoton("6"),
                  construirBoton("x"),
                ],
              ),
              Row(
                children: [
                  construirBoton("1"),
                  construirBoton("2"),
                  construirBoton("3"),
                  construirBoton("-"),
                ],
              ),
              Row(
                children: [
                  construirBoton("."),
                  construirBoton("0"),
                  construirBoton("="),
                  construirBoton("+"),
                ],
              ),
              Row(
                children: [construirBoton("C")],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
