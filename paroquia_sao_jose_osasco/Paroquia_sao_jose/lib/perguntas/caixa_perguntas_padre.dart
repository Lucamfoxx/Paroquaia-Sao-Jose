// caixa_perguntas_padre.dart
import 'package:flutter/material.dart';
import 'perguntas_form.dart';

class CaixaPerguntasPadrePage extends StatelessWidget {
  const CaixaPerguntasPadrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas para o Padre'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pública'),
              Tab(text: 'Confidencial'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PublicPerguntaForm(),
            ConfidencialPerguntaForm(),
          ],
        ),
      ),
    );
  }
}
