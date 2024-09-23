import 'package:flutter/material.dart';

class NotasFinal extends StatefulWidget {
  const NotasFinal({super.key});

  @override
  State<NotasFinal> createState() => _NotasFinalState();
}

class _NotasFinalState extends State<NotasFinal> {
  final TextEditingController labController = TextEditingController();
  final TextEditingController primerAvanceController = TextEditingController();
  final TextEditingController segundoAvanceController = TextEditingController();
  final TextEditingController entregaFinalController = TextEditingController();

  double notaFinal = 0;
  String errorMessage = '';

  // Función para verificar que la nota est en el rango permitido (0 a 5)
  bool verificarNota(double nota) {
    return nota >= 0 && nota <= 5;
  }

  // Función para calcular la nota final
  void calcularNotaFinal() {
    setState(() {
      double lab = double.tryParse(labController.text) ?? -1;
      double primerAvance = double.tryParse(primerAvanceController.text) ?? -1;
      double segundoAvance = double.tryParse(segundoAvanceController.text) ?? -1;
      double entregaFinal = double.tryParse(entregaFinalController.text) ?? -1;

      if (!verificarNota(lab) || !verificarNota(primerAvance) || !verificarNota(segundoAvance) || !verificarNota(entregaFinal)) {
        errorMessage = 'Las notas deben estar entre 0 y 5.';
        notaFinal = 0;
        return;
      }

      double totalPorcentajes = lab * 0.6 + primerAvance * 0.1 + segundoAvance * 0.1 + entregaFinal * 0.2;

      if (totalPorcentajes <= 5.0) {
        notaFinal = totalPorcentajes;
        errorMessage = '';
      } else {
        errorMessage = 'La suma de los porcentajes no puede exceder el 100%.';
        notaFinal = 0;

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Nota Final'),
        leading: Image.asset('assets/images/calificaciones.png'),
        backgroundColor: Colors.deepPurpleAccent[100],
      ),
      body: SingleChildScrollView( // Solución: Permite que el contenido sea desplazable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingresa las notas de cada evaluación:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildTextField('Nota prácticas de laboratorio (60%)', labController),
            SizedBox(height: 10),
            _buildTextField('Nota primer avance (10%)', primerAvanceController),
            SizedBox(height: 10),
            _buildTextField('Nota segundo avance (10%)', segundoAvanceController),
            SizedBox(height: 10),
            _buildTextField('Nota entrega final (20%)', entregaFinalController),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: calcularNotaFinal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent[100],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Calcular Nota Final',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            if (notaFinal > 0)
              Center(
                child: Column(
                  children: [
                    Text(
                      'Nota final: ${notaFinal.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    if (notaFinal >= 2.95)
                      Image.asset('assets/images/nice.png', width: 250, height: 250)
                    else
                      Image.asset('assets/images/bad.png', width: 250, height: 250),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      inputFormatters: [
        // Añade input formatters si deseas restringir la entrada en tiempo real
      ],
    );
  }
}