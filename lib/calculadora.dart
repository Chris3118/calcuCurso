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
    else if (["+", "-", "/", "×"].contains(textoBoton)) {
      numero1 = double.parse(resultado);
      operador = textoBoton == "×" ? "x" : textoBoton;
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
          if (numero2 != 0) {
            _resultado = (numero1 / numero2).toString();
          } else {
            _resultado = "Error";
          }
          break;
      }

      // Formatear resultado para evitar decimales innecesarios
      if (_resultado != "Error") {
        double resultadoDouble = double.parse(_resultado);
        if (resultadoDouble == resultadoDouble.toInt()) {
          _resultado = resultadoDouble.toInt().toString();
        }
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

  // Función para determinar el color del botón según su tipo
  Color _getButtonColor(String textoBoton) {
    if (textoBoton == "C") {
      return Color(0xFFFF6B6B); // Rojo para clear
    } else if (["+", "-", "/", "×", "="].contains(textoBoton)) {
      return Color(0xFF4ECDC4); // Verde azulado para operadores
    } else {
      return Color(0xFF45B7D1); // Azul para números
    }
  }

  // Función para determinar el color del texto
  Color _getTextColor(String textoBoton) {
    return Colors.white;
  }

  Widget construirBoton(String textoBoton, {bool isWide = false}) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            backgroundColor: _getButtonColor(textoBoton),
            foregroundColor: _getTextColor(textoBoton),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Text(
            textoBoton,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => presionarBoton(textoBoton),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C3E50),
      appBar: AppBar(
        title: Text(
          "Calculadora Chris",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF34495E),
        elevation: 0,
      ),
      body: Column(
        children: [
          // CONTENEDOR DEL DISPLAY
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF34495E), Color(0xFF2C3E50)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      resultado,
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CONTENEDOR DE BOTONES
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF34495E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // PRIMERA FILA
                  Expanded(
                    child: Row(
                      children: [
                        construirBoton("C", isWide: true),
                        construirBoton("/"),
                        construirBoton("×"),
                      ],
                    ),
                  ),

                  // SEGUNDA FILA
                  Expanded(
                    child: Row(
                      children: [
                        construirBoton("7"),
                        construirBoton("8"),
                        construirBoton("9"),
                        construirBoton("-"),
                      ],
                    ),
                  ),

                  // TERCERA FILA
                  Expanded(
                    child: Row(
                      children: [
                        construirBoton("4"),
                        construirBoton("5"),
                        construirBoton("6"),
                        construirBoton("+"),
                      ],
                    ),
                  ),

                  // CUARTA FILA
                  Expanded(
                    child: Row(
                      children: [
                        construirBoton("1"),
                        construirBoton("2"),
                        construirBoton("3"),
                        construirBoton("="),
                      ],
                    ),
                  ),

                  // QUINTA FILA
                  Expanded(
                    child: Row(
                      children: [
                        construirBoton("0", isWide: true),
                        construirBoton("."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
