import 'package:flutter/material.dart';
import 'pedido_missas.dart'; // Importe a página pedido_missas.dart
import 'pedido_intencoes.dart'; // Importe a página pedido_intencoes.dart
import 'main.dart'; // Importe para acessar o widget MenuButton

class MissasIntencoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missas e Intenções'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Define a mesma margem em todos os lados dos botões
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuButton('Pedidos de Missas', '/pedido_missas'),
              MenuButton('Pedidos de Intenções', '/pedido_intencoes'),
            ],
          ),
        ),
      ),
    );
  }
}
