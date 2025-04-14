import 'package:flutter/material.dart';

class JoguinhosQuizzesPage extends StatelessWidget {
  const JoguinhosQuizzesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joguinhos e Quizzes Bíblicos'),
      ),
      body: const Center(
        child: Text(
          'Página dos Joguinhos e Quizzes Bíblicos\n\n'
          'Aqui serão disponibilizados quizzes, jogos de memória e desafios bíblicos para testar o conhecimento dos fiéis. '
          'Conteúdo em construção...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
