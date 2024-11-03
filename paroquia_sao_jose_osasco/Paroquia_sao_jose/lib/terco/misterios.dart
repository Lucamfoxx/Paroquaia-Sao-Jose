import 'package:flutter/material.dart';

class MisteriosPage extends StatelessWidget {
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
                "Mistérios do Terço",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildMisterioCategory(
                title: "Mistérios Gozosos (Segunda e Sábado)",
                misterios: [
                  _buildMisterioItem("A Anunciação do Anjo a Maria",
                      "O anjo entrou onde ela estava e disse: ‘Alegre-se, cheia de graça! O Senhor está com você!’ (Lucas 1:28)"),
                  _buildMisterioItem("A Visita de Maria a Isabel",
                      "Logo que Isabel ouviu a saudação de Maria, a criança saltou no seu ventre, e Isabel ficou cheia do Espírito Santo. (Lucas 1:41)"),
                  _buildMisterioItem("O Nascimento de Jesus em Belém",
                      "Ela deu à luz o seu filho primogênito. Envolveu-o em panos e o colocou numa manjedoura, porque não havia lugar para eles na hospedaria. (Lucas 2:7)"),
                  _buildMisterioItem("A Apresentação de Jesus no Templo",
                      "Simeão tomou-o nos braços e louvou a Deus, dizendo: ‘Agora, Senhor, conforme a tua promessa, podes despedir em paz o teu servo’. (Lucas 2:28-29)"),
                  _buildMisterioItem("O Encontro de Jesus no Templo entre os Doutores",
                      "Depois de três dias o encontraram no templo, sentado entre os mestres, ouvindo-os e fazendo-lhes perguntas. (Lucas 2:46)"),
                ],
              ),
              _buildMisterioCategory(
                title: "Mistérios Dolorosos (Terça e Sexta)",
                misterios: [
                  _buildMisterioItem("A Agonia de Jesus no Horto das Oliveiras",
                      "E, cheio de angústia, orava mais intensamente; e o seu suor era como gotas de sangue que caíam no chão. (Lucas 22:44)"),
                  _buildMisterioItem("A Flagelação de Jesus",
                      "Pilatos mandou então que Jesus fosse açoitado. (João 19:1)"),
                  _buildMisterioItem("A Coroação de Espinhos",
                      "Os soldados teceram uma coroa de espinhos e a puseram na sua cabeça, vestiram-no com um manto de púrpura. (João 19:2)"),
                  _buildMisterioItem("Jesus Carrega a Cruz para o Calvário",
                      "Ele mesmo carregou a sua cruz e saiu para o lugar chamado Caveira (que em aramaico se chama Gólgota). (João 19:17)"),
                  _buildMisterioItem("A Crucificação e Morte de Jesus",
                      "Então Jesus clamou em alta voz: ‘Pai, nas tuas mãos entrego o meu espírito’. Tendo dito isso, expirou. (Lucas 23:46)"),
                ],
              ),
              _buildMisterioCategory(
                title: "Mistérios Gloriosos (Quarta e Domingo)",
                misterios: [
                  _buildMisterioItem("A Ressurreição de Jesus",
                      "Por que estais procurando entre os mortos aquele que está vivo? Ele não está aqui; ressuscitou. (Lucas 24:5-6)"),
                  _buildMisterioItem("A Ascensão de Jesus ao Céu",
                      "E aconteceu que, enquanto os abençoava, separou-se deles e foi elevado ao céu. (Lucas 24:51)"),
                  _buildMisterioItem("A Descida do Espírito Santo sobre os Apóstolos",
                      "E todos ficaram cheios do Espírito Santo e começaram a falar noutras línguas, conforme o Espírito lhes concedia que falassem. (Atos 2:4)"),
                  _buildMisterioItem("A Assunção de Nossa Senhora ao Céu",
                      "Agora uma grande voz no céu proclamou: ‘Agora veio a salvação, o poder e o reino do nosso Deus, e a autoridade do seu Cristo’. (Apocalipse 12:10)"),
                  _buildMisterioItem("A Coroação de Maria como Rainha do Céu e da Terra",
                      "Uma grande maravilha apareceu no céu: uma mulher vestida do sol, com a lua debaixo dos seus pés, e uma coroa de doze estrelas sobre sua cabeça. (Apocalipse 12:1)"),
                ],
              ),
              _buildMisterioCategory(
                title: "Mistérios Luminosos (Quinta-feira)",
                misterios: [
                  _buildMisterioItem("O Batismo de Jesus no Rio Jordão",
                      "Assim que Jesus foi batizado, saiu da água. Naquele momento o céu se abriu, e ele viu o Espírito de Deus descendo como pomba e pousando sobre ele. Então uma voz dos céus disse: ‘Este é o meu Filho amado, em quem me agrado’. (Mateus 3:16-17)"),
                  _buildMisterioItem("A Auto-revelação de Jesus nas Bodas de Caná",
                      "Este sinal miraculoso, em Caná da Galileia, foi o primeiro que Jesus realizou. Com isso ele manifestou a sua glória, e os seus discípulos creram nele. (João 2:11)"),
                  _buildMisterioItem("O Anúncio do Reino de Deus e o Chamado à Conversão",
                      "O tempo é chegado. O Reino de Deus está próximo. Arrependam-se e creiam nas boas-novas! (Marcos 1:15)"),
                  _buildMisterioItem("A Transfiguração de Jesus",
                      "Ali ele foi transfigurado diante deles. Sua face brilhou como o sol, e as suas roupas se tornaram brancas como a luz. (Mateus 17:2)"),
                  _buildMisterioItem("A Instituição da Eucaristia",
                      "Enquanto comiam, Jesus tomou o pão, deu graças, partiu-o e o deu aos seus discípulos, dizendo: ‘Tomem e comam; isto é o meu corpo’. (Mateus 26:26)"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMisterioCategory({required String title, required List<Widget> misterios}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...misterios,
      ],
    );
  }

  Widget _buildMisterioItem(String title, String description) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(description, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}