import 'package:flutter/material.dart';

class SacramentosPage extends StatefulWidget {
  @override
  _SacramentosPageState createState() => _SacramentosPageState();
}

class _SacramentosPageState extends State<SacramentosPage> {
  double _fontSize = 16.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 2.0) {
        _fontSize -= 2.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sacramentos'),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildExpansiveButton(
              '1 - Batismo',
              _buildBatismoText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '2 - Crisma ou Confirmação',
              _buildCrismaText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '3 - Eucaristia',
              _buildEucaristiaText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '4 - Reconciliação ou Penitência',
              _buildReconciliacaoText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '5 - Unção dos enfermos',
              _buildUncaoText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '6 - Ordem',
              _buildOrdemText(),
            ),
            SizedBox(height: 20),
            _buildExpansiveButton(
              '7 - Matrimônio',
              _buildMatrimonioText(),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildExpansiveButton(String title, Widget text) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Definindo a cor do título para preto
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTextStyle(
            style: TextStyle(fontSize: _fontSize, color: Colors.black), // Definindo a cor do texto para preto
            child: text,
          ),
        ),
      ],
    ),
  );
}


  Widget _buildBatismoText() {
    return Text(
      // Texto do Batismo
      'O Batismo é entendido como o sacramento que abre as portas da vida cristã ao batizado, incorporando-o à comunidade católica, ao grande Corpo Místico de Cristo, que é a Igreja em si. Este ritual de iniciação cristã é feito normalmente com água sobre o batizando, através de imersão,efusão ou aspersão. Ou, utilizando outras palavras do Compêndio do Catecismo da Igreja Católica, "o rito essencial deste sacramento consiste em imergir na água o candidato ou em derramar a água sobre a sua cabeça, enquanto é invocado o Nome do Pai e do Filho e do Espírito Santo". O Baptismo significa imergir "na morte de Cristo e ressurgir com Ele como nova criatura" .\n\n'
      'O Batismo perdoa o pecado original e todos os pecados pessoais e as penas devidas ao pecado. Possibilita aos batizados a participação na vida trinitária de Deus mediante a graça santificante e a incorporação em Cristo e na Igreja. Confere também as virtudes teologais e os dons do Espírito Santo. Uma vez batizado, o cristão é para sempre um filho de Deus e um membro inalienável da Igreja e também pertence para sempre a Cristo .\n\n'
      'Embora o Batismo seja fundamental para a salvação, os catecúmenos, todos aqueles que morrem por causa da fé (Batismo de sangue), [...] todos os que sob o impulso da graça, sem conhecer Cristo e a Igreja, procuram sinceramente a Deus e se esforçam por cumprir a sua vontade (Batismo de desejo), conseguem obter a salvação sem serem batizados porque, segundo a doutrina da Igreja Católica, Cristo morreu para a salvação de todos. Quanto às crianças mortas sem serem batizadas, a Igreja na sua liturgia confia-as à misericórdia de Deus, que é ilimitada e infinita .\n\n'
      'Na Igreja Católica, o Batismo é dado tanto às crianças como aos convertidos adultos que não tenham sido antes batizados validamente (o batismo da maior parte das igrejas cristãs é considerado válido pela Igreja Católica visto que se considera que o efeito chega diretamente de Deus independentemente da fé pessoal, embora não da intenção, do sacerdote).\n\n'
      'Mas, a Igreja Católica insiste no batismo às crianças porque "tendo nascido com o pecado original, elas têm necessidade de ser libertadas do poder do Maligno e de ser transferidas para o reino da liberdade dos filhos de Deus" . Por essa razão, a Igreja recomenda os seus fiéis a fazerem tudo para evitar que uma pessoa não batizada venha a morrer em sua presença sem a graça do batismo. Assim, embora o sacramento deva ser ministrado por um sacerdote, diante de um enfermo não batizado, qualquer pessoa pode e deve batizá-lo, dizendo "Eu te batizo, em nome do Pai, do Filho e do Espírito Santo", enquanto que, com o polegar da mão direita, desenha uma cruz sobre a testa, a boca e o peito do enfermo .\n\n'
      'O fato de que o batismo seja geralmente ministrado a crianças recém-nascidas, que, por isso, não estão entrando na vida cristã por vontade própria, explica que se requeira a estas pessoas a recepção de um outro sacramento, a Crisma, quando cheguem a uma idade em que tenham discernimento e capacidade intelectual suficiente para professarem conscientemente a sua fé e decidirem se querem ou não permanecer na Igreja Católica. Se sim, então estarão, neste caso, confirmando a decisão que os seus pais ou responsáveis fizeram em seu nome no dia do seu batismo. Entretanto, como este sacramento imprime caráter, quem recebeu o batismo, independente de que o confirme ou não através do sacramento do Crisma ou Confirmação, estará batizado para sempre.\n\n'
      'Na Igreja Católica, o sacramento do batismo tem vários símbolos, mas existem quatro principais, que são eles: água, óleo, veste branca e a vela. Cada um representa um mistério na vida do batizado. Além desses símbolos (que são os principais) o rito romano ainda estabelece o sal, mas este símbolo só é usado conforme as orientações pastorais das Igrejas particulares.\n\n'
      'Vejamos os significados dos símbolos:\n\n'
      '- Água: Representa a passagem da vida "pagã" para uma "nova vida". Ela tem o fator de purificação, lavando-nos do pecado original.\n\n'
      '- Óleo: Representa a fortaleza do Espírito Santo. Antigamente, os lutadores usavam o óleo antes das lutas para deixarem seus músculos rígidos e assim poderem vencer. Na nova vida adquirida pelo batismo ele tem a mesma função, revestir o batizado para as lutas cotidianas contra as ciladas do maligno.\n\n'
      '- Veste branca: Representa a nova vida adquirida pelo batismo. Quando tomamos banho vestimos uma roupa limpa, no batismo não seria diferente. Somos lavados na água e vestidos de uma nova vida.\n\n'
      '- Vela: Tem dois significados: o Espírito Santo e o dom da fé. Pelo batismo somos revestidos de muitas graças e a principal é o Espírito Santo, pois seremos unidos a Deus como filhos para sermos santificados e esta santificação é realizada através do Espírito Santo. A fé é um dom fundamental para nossa vida, é através dela que reconhecemos Deus e por ela recebemos as suas graças.',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildCrismaText() {
    return Text(
      // Texto do Crisma
      'Confirmação do Batismo ou Crisma o batizado reafirma sua fé em Cristo, sendo ungido durante a cerimônia, recebendo os sete dons do Espírito Santo. A unção é feita pelo Bispo ou padre autorizado, com óleo abençoado na quinta-feira da Semana Santa.\n\n'
      'É um sacramento instituído para dar oportunidade a uma pessoa - que foi batizada por decisão alheia e que tem, perante a Igreja, compromissos assumidos por outras pessoas em seu nome diante da pia batismal – de confirmar o desejo de ser membro da família cristã dentro da Igreja Católica e de reafirmar aqueles compromissos, depois de atingir a “idade da razão”.\n\n'
      'Simplificadamente, a cerimônia consiste na renovação das “promessas do batismo”, mediante perguntas do Bispo, que em geral a preside, feitas em voz alta e do mesmo modo respondidas pelo crismando perante a comunidade.\n\n'
      'Como o batismo, o Crisma também imprime caráter, podendo ser ministrado apenas uma vez a cada pessoa.\n\n'
      'Por ser um ato de afirmação de compromissos, a pessoa pode jamais receber o crisma ou, indo participar da cerimônia, deixar de confirmar esses compromissos.\n\n'
      'De qualquer modo, quem não foi crismado ou quem se recusou a renovar os compromissos do batismo, pode fazê-lo em qualquer tempo.\n\n'
      'O Crisma é, portanto, um sacramento dependente, complementar ao batismo, já que não tem qualquer significação se ministrado a quem não tenha sido batizado.\n\n',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildEucaristiaText() {
    return Text(
      // Texto da Eucaristia
      'É a celebração em memória de Cristo, recordando a santa ceia, a paixão e a ressurreição, em que o Cristão recebe a hóstia consagrada.\n\n'
      'É o sacramento culminante, que dá aos fieis a oportunidade de receber e ingerir fisicamente o que consideram como sendo o corpo de Jesus Cristo, em que se transformou o pão consagrado pelo sacerdote, assim como o vinho se transforma no Seu sangue.\n\n'
      'No sacramento da Eucaristia, a hóstia consagrada (o pão) é distribuída aos fiéis, que a colocam na boca e ingerem lenta e respeitosamente.\n\n'
      'Para receber a hóstia, o fiel deve estar em “estado de graça”, ou seja, deve ter antes confessado os seus pecados e recebido o perdão divino através do sacramento da Confissão ou Penitência.\n\n'
      'A consagração não faz parte do sacramento da eucaristia. É um rito precedente e separado. É um ato que só os sacerdotes têm o poder de praticar.\n\n'
      'A Igreja Católica sustenta que, quando o sacerdote pronuncia as palavras rituais “Isto é o meu corpo” em relação pão e “Isto é o meu sangue” em relação vinho, acontece um fenômeno chamado transubstanciação, ou seja, a substância material que constitui o pão se converte no corpo de Cristo e a que constitui o vinho se transmuda no Seu sangue.\n\n'
      'O pão transubstanciado é distribuído aos fiéis que, ao ingerirem a hóstia estão ingerindo o corpo de Cristo. A Eucaristia é considerada o sacramento da ação de graças, na acepção da palavra original grega εὐχαριστία (transc. "eukharistia").',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildReconciliacaoText() {
    return Text(
      // Texto da Reconciliação
      'É a confissão dos pecados a um sacerdote, que aplica a penitência para, uma vez cumprida, propiciar a reconciliação com Cristo. Por outras palavras, é o sacramento que dá ao cristão católico a oportunidade de reconhecer as suas faltas e, se delas estiver arrependido, ser perdoado por Deus.\n\n'
      'O reconhecimento das faltas é a sua confissão a um sacerdote, que pode ouví-la em nome de Deus e conceder àquele fiel o Seu perdão.\n\n'
      'Do ponto de vista formal, o confessante se ajoelha perante um sacerdote, o confessor, e a ele declara que pecou, que deseja confessar o que fez e pedir a Deus que perdoe os seus pecados.\n\n'
      'Após ouvi-lo, cabe ao sacerdote oferecer as suas palavras de conselho, de censura, de orientação e conforto ao penitente, recomendando a penitência a ser cumprida.\n\n'
      'O confessado deve rezar a oração denominada Ato de Contrição, após o que o sacerdote profere as palavras do perdão e abençoa o penitente, que se retira para cumprir a penitência que lhe foi prescrita.\n\n'
      'A Igreja Católica considera o sacramento da penitência um ato purificador, que deve ser praticado antes da Eucaristia, para que esta seja recebida com a alma limpa pelo perdão dos pecados. Mas, entende-se também que esse efeito purificador é salutar, sendo benéfico para o espírito cada vez que é praticado.\n\n'
      'Um dos mais rígidos deveres impostos ao sacerdote pela Igreja é o segredo da confissão.\n\n'
      'O sacerdote é rigorosamente e totalmente proibido de revelar o que ouve dos fiéis no confessionário. O descumprimento desse dever é considerado um dos maiores e mais graves pecados que um sacerdote pode cometer e o sujeita a penalidades severíssimas impostas pela Igreja.',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildUncaoText() {
    return Text(
      // Texto da Unção dos enfermos
      'A Unção dos enfermos é o sacramento pelo qual o sacerdote reza e unge os enfermos para estimular-lhes a cura mediante a fé, ouve deles os arrependimentos e promove-lhes o perdão de Deus. Este sacramento Pode ser dado a qualquer pessoa que se encontra em estado de enfermidade, e não somente a pessoas que estão em estado de falecer a qualquer momento.',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildOrdemText() {
    return Text(
      // Texto da Ordem
      'O sacramento da ordem concede a autoridade para exercer funções e ministérios eclesiásticos que se referem ao culto de Deus e à salvação das almas. É dividido em três graus:\n\n'
      'O Episcopado: Confere a plenitude da ordem e torna o candidato legítimo sucessor dos apóstolos e lhe é confiado os ofícios de ensinar, santificar e reger.\n\n'
      'O Presbiterado: Configura o candidato ao Cristo sacerdote e bom pastor.É capaz de agir em nome de Cristo cabeça e ministrar o culto divino.\n\n'
      'O Diaconato: Confere ao candidato a ordem para o serviço na Igreja, através do culto divino, da pregação, da orientação e sobretudo, na caridade.',
      style: TextStyle(fontSize: _fontSize),
    );
  }

  Widget _buildMatrimonioText() {
    return Text(
      // Texto do Matrimônio
      'O sacramento que, estabelecendo e santificando a união entre um homem e uma mulher, funda uma nova família cristã. Matrimônio é o casamento entre homem e mulher, celebrado na Igreja e santificado na indissolubilidade e na fidelidade;\n\n'
      'É um dos sacramentos que imprimem caráter, embora de forma distinta do batismo, do crisma e da ordem. Estes três últimos deixam no fiel que o recebe uma marca indelével que o acompanha por toda a eternidade. Quem foi batizado ou crismado, quem foi ordenado sacerdote terá essa condição independente de qualquer coisa, inclusive de que decida depois converter-se a outro credo religioso ou abandonar o sacerdócio.\n\n'
      'O matrimônio imprime caráter sobre o casal, sobre o conjunto que os dois nubentes passaram a formar, e é, por isso, doutrinariamente indissolúvel. O caráter impresso pelo matrimônio se dissolve com a morte de um dos cônjuges. É um sacramento necessário para a formação de uma família cristã.\n\n'
      'A teologia católica apresenta o casamento como sinal do amor de Cristo para com a Igreja, definindo-o também como "ícone da união de Cristo com a Igreja".\n\n'
      'Quem recebe o sacramento do matrimônio (que se confere mutuamente pelo próprio consentimento expresso em público) confere-se mutuamente este sacramento.\n\n'
      'O rito de casamento exige uma série de formalidades. Entre estas, a declaração de nulidade do casamento anterior, caso um dos noivos tenha sido casado anteriormente.',
      style: TextStyle(fontSize: _fontSize),
    );
  }
}
