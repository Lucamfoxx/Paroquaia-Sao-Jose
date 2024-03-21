import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class SalmoPage extends StatefulWidget {
  final int salmoNumber;

  const SalmoPage({Key? key, required this.salmoNumber}) : super(key: key);

  @override
  _SalmoPageState createState() => _SalmoPageState();
}

class _SalmoPageState extends State<SalmoPage> {
  late Future<String> _futureSalmo;
  double _fontSize = 18.0;
  late int _currentSalmoNumber;

  @override
  void initState() {
    super.initState();
    _currentSalmoNumber = widget.salmoNumber;
    _futureSalmo = _carregarSalmo(widget.salmoNumber);
  }

  Future<String> _carregarSalmo(int salmoNumber) async {
    return await rootBundle.loadString('assets/biblia/Testamentos/Salmos_$salmoNumber.txt');
  }

  void _aumentarFonte() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _diminuirFonte() {
    setState(() {
      _fontSize = (_fontSize - 2.0).clamp(12.0, 48.0);
    });
  }

  void _proxSalmo() {
    setState(() {
      _currentSalmoNumber = (_currentSalmoNumber % 150) + 1;
      _futureSalmo = _carregarSalmo(_currentSalmoNumber);
    });
  }

  void _salmoAnterior() {
    setState(() {
      _currentSalmoNumber = (_currentSalmoNumber - 2) % 150 + 1;
      _futureSalmo = _carregarSalmo(_currentSalmoNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salmo $_currentSalmoNumber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _salmoAnterior,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _aumentarFonte,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _diminuirFonte,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _proxSalmo,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: _futureSalmo,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erro ao carregar o salmo.'),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          snapshot.data!,
                          style: TextStyle(fontSize: _fontSize),
                          textAlign: TextAlign.left,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
