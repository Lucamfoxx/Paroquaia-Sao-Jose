import 'package:flutter/material.dart';

class SaoJosePage extends StatefulWidget {
  @override
  _SaoJosePageState createState() => _SaoJosePageState();
}

class _SaoJosePageState extends State<SaoJosePage> {
  double _fontSize = 16.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize = _fontSize <= 2.0 ? 2.0 : _fontSize - 2.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('São José'),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
            tooltip: 'Diminuir Tamanho da Fonte',
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
            tooltip: 'Aumentar Tamanho da Fonte',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/sao_jose_logo.jpg', // Caminho para a imagem de São José
                    fit: BoxFit.fill, // Preenche toda a área disponível
                  ),
                  Text(
                    'São José',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'São José é conhecido como o pai terreno de Jesus Cristo e o esposo de Maria, a mãe de Jesus. Ele é reverenciado como um dos santos mais importantes na tradição cristã.',
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sua Vida',
                    style: TextStyle(
                      fontSize: _fontSize + 4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pouco se sabe sobre a vida de São José a partir dos relatos bíblicos. Ele era um carpinteiro em Nazaré e, de acordo com a tradição cristã, foi escolhido por Deus para ser o pai adotivo de Jesus e o guardião de sua família terrena.',
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Devoção e Legado',
                    style: TextStyle(
                      fontSize: _fontSize + 4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'São José é venerado como um modelo de humildade, obediência e cuidado paternal. Sua devoção é especialmente forte entre os católicos, que o invocam em momentos de necessidade, especialmente nas áreas da família, trabalho e proteção.',
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Mais sobre São José',
                    style: TextStyle(
                      fontSize: _fontSize + 4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Além de seu papel na vida de Jesus, São José é também considerado o padroeiro da Igreja Universal, dos trabalhadores, dos pais de família, dos carpinteiros e dos moribundos, entre outros.',
                    style: TextStyle(
                      fontSize: _fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
