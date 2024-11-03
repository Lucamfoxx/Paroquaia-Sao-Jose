import 'package:flutter/material.dart';

class ComoRezarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Como Rezar o Terço",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "Introdução",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "O Terço é uma prática de oração na tradição católica que visa meditar sobre eventos significativos na vida de Jesus Cristo e de Maria. "
                "Ele é composto por cinco conjuntos de orações chamados mistérios, que contemplam temas específicos. "
                "Para cada mistério, rezamos uma série de orações que ajudam na reflexão e na conexão espiritual.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Estrutura do Terço",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Abaixo está a estrutura básica para rezar o Terço:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Início do Terço",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "1. Faça o Sinal da Cruz e recite o \"Creio em Deus Pai\", reafirmando a fé.\n"
                "2. Reze um Pai Nosso, pedindo que a vontade de Deus seja feita.\n"
                "3. Em seguida, reze três Ave-Marias em honra à Santíssima Trindade.\n"
                "4. Termine a introdução com o Glória ao Pai, louvando a Santíssima Trindade.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Estrutura de Cada Mistério",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Após as orações iniciais, entre na sequência dos cinco mistérios, seguindo o mesmo padrão para cada um:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                "1. Anuncie o mistério e mentalize o tema específico para reflexão.\n"
                "2. Reze um Pai Nosso.\n"
                "3. Reze dez Ave-Marias, meditando no mistério anunciado.\n"
                "4. Conclua com o Glória ao Pai, louvando a Santíssima Trindade.\n"
                "5. (Opcional) Adicione a Oração de Fátima: \"Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu e socorrei principalmente as que mais precisarem de vossa misericórdia.\"",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Encerramento do Terço",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Após completar os cinco mistérios, encerre o Terço com a oração do Salve Rainha, pedindo a intercessão da Virgem Maria.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "Salve Rainha",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Salve, Rainha, Mãe de misericórdia,\n"
                "vida, doçura e esperança nossa, salve!\n"
                "A vós bradamos, os degredados filhos de Eva.\n"
                "A vós suspiramos, gemendo e chorando neste vale de lágrimas.\n\n"
                "Eia, pois, advogada nossa,\n"
                "esses vossos olhos misericordiosos a nós volvei.\n"
                "E depois deste desterro, mostrai-nos Jesus,\n"
                "bendito fruto do vosso ventre.\n\n"
                "Ó clemente, ó piedosa, ó doce sempre Virgem Maria.\n\n"
                "Rogai por nós, Santa Mãe de Deus,\n"
                "para que sejamos dignos das promessas de Cristo.\nAmém.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "Oração Final",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Ó Deus, cujo Filho Unigênito, por sua vida, morte e ressurreição, nos conquistou o prêmio da salvação eterna, concedei-nos, nós vos pedimos, que, meditando os mistérios do Santo Rosário da bem-aventurada Virgem Maria, imitemos o que contêm e alcancemos o que prometem. Por Cristo nosso Senhor. Amém.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
