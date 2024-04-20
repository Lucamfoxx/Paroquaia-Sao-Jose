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
              MenuButton('Catequese de 6 a 11 anos', '/inscricoes_catequese_infantil'), // 
              MenuButton('Catequese de 12 a 17 anos', '/inscricoes_catequese_jovem'), // 
              MenuButton('Catequese Adultos', '/inscricoes_catequese'), // Botão para inscrições de catequese
              MenuButton('Batismo', '/inscricoes_batismo'),
              MenuButton('Preparações e Batismos', '/preparacaobatismo'), // Botão para inscrições de batismo
              MenuButton('Casamento', '/inscricoes_casamento'),
              MenuButton('Dizimista', '/dizimista'), // Botão para inscrições de casamento
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
        color: Color.fromARGB(255, 220, 219, 214),
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
