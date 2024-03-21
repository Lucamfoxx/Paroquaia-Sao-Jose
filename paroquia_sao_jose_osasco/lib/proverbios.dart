import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ProverbiosPage extends StatefulWidget {
  final int proverbioNumber;

  const ProverbiosPage({Key? key, required this.proverbioNumber}) : super(key: key);

  @override
  _ProverbiosPageState createState() => _ProverbiosPageState();
}

class _ProverbiosPageState extends State<ProverbiosPage> {
  late Future<String> _futureProverbio;
  double _fontSize = 18.0;
  late int _currentProverbioNumber;

  @override
  void initState() {
    super.initState();
    _currentProverbioNumber = widget.proverbioNumber;
    _futureProverbio = _carregarProverbio(widget.proverbioNumber);
  }

  Future<String> _carregarProverbio(int proverbioNumber) async {
    return await rootBundle.loadString('assets/biblia/Testamentos/proverbio_$proverbioNumber.txt');
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

  void _proxProverbio() {
    setState(() {
      _currentProverbioNumber = (_currentProverbioNumber % 31) + 1;
      _futureProverbio = _carregarProverbio(_currentProverbioNumber);
    });
  }

  void _proverbioAnterior() {
    setState(() {
      _currentProverbioNumber = (_currentProverbioNumber - 2) % 31 + 1;
      _futureProverbio = _carregarProverbio(_currentProverbioNumber);
    });
  }

  void _selecionarProverbio(int numeroProverbio) {
    setState(() {
      _currentProverbioNumber = numeroProverbio;
      _futureProverbio = _carregarProverbio(numeroProverbio);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provérbio $_currentProverbioNumber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _proverbioAnterior,
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
            onPressed: _proxProverbio,
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
                future: _futureProverbio,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Erro ao carregar o provérbio.'),
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
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i <= 31; i++)
                IconButton(
                  onPressed: () {
                    _selecionarProverbio(i);
                  },
                  icon: Text(
                    i.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageRouteFade extends PageRouteBuilder {
  final Widget page;

  PageRouteFade({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
