import 'package:flutter/material.dart';
import 'dart:async'; // Para o cronômetro da fila

void main() => runApp(MaterialApp(
      home: HospitalHome(),
      debugShowCheckedModeBanner: false,
    ));

class HospitalHome extends StatefulWidget {
  @override
  _HospitalHomeState createState() => _HospitalHomeState();
}

class _HospitalHomeState extends State<HospitalHome> {
  bool fezCheckIn = false;
  int posicaoNaFila = 5;
  Timer? _timer;

  // Função que simula a fila andando
  void iniciarFila() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (posicaoNaFila > 1) {
        setState(() {
          posicaoNaFila--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HealthApp - Hospital'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Olá, Paciente!', 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            
            // CARD DA FILA VIRTUAL
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: fezCheckIn ? Colors.green[50] : Colors.blue[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: fezCheckIn ? Colors.green : Colors.blueAccent),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        fezCheckIn ? Icons.check_circle : Icons.timer, 
                        size: 40, 
                        color: fezCheckIn ? Colors.green : Colors.blueAccent
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sua Fila Virtual', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(fezCheckIn 
                            ? 'Você é o $posicaoNaFilaº da fila' 
                            : 'Aguardando Check-in'),
                        ],
                      )
                    ],
                  ),
                  if (fezCheckIn) ...[
                    SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: 1 - (posicaoNaFila / 5), // Barra enche conforme a fila anda
                      backgroundColor: Colors.white,
                      color: Colors.green,
                    ),
                  ]
                ],
              ),
            ),
            
            SizedBox(height: 30),

            // BOTÃO DE CHECK-IN
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: fezCheckIn ? null : () {
                  setState(() {
                    fezCheckIn = true;
                  });
                  iniciarFila(); // Começa a diminuir a fila
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: Text(fezCheckIn ? 'Check-in Realizado' : 'Fazer Check-in Online'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Limpa o timer quando fechar o app
    super.dispose();
  }
}