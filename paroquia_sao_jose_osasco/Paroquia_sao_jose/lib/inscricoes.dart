import 'package:flutter/material.dart';

class InscricoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscrições'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuButton('Dizimista', '/dizimista'),
              MenuButton('Catequese/1° Eucaristia de 6 a 11 anos',
                  '/inscricoes_catequese_infantil'), //
              MenuButton('Catequese/Crisma de 12 a 17 anos',
                  '/inscricoes_catequese_jovem'), //
              MenuButton('Catequese Adultos',
                  '/inscricoes_catequese'), // Botão para inscrições de catequese
              MenuButton('Batismo até 6 anos', '/inscricoes_batismo'),
              MenuButton(
                  'Batismo apartir de 6 anos', '/inscricoes_batismo_adult'),
              MenuButton('Preparações e Batismos', '/preparacaobatismo'),
              // Botão para inscrições de batismo
              MenuButton('Casamento', '/inscricoes_casamento'),
              // Botão para inscrições de casamento
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;
  final String route;

  MenuButton(this.text, this.route);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 148, 203, 252),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
