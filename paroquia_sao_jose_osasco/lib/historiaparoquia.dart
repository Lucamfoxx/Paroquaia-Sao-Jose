import 'package:flutter/material.dart';

class HistoriaParoquiaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('História da Paróquia'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0), // Cantos arredondados
          boxShadow: [ // Adicionando uma sombra
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // Altere o deslocamento vertical conforme necessário
            ),
          ],
        ),
        margin: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleWithImage(
                    'Paróquia São José (Vila São José)',
                    '''
No início da década de 1950, foi doado para a Igreja o terreno de 1672 m² pelo Dr. Junqueira de Aquino, dono de uma gleba de terra em Osasco. A primeira missa realizada no terreno ocorreu por volta de 1952, celebrada pelo Pe. Domingos Tonini– CRL, pároco da Igreja dos Remédios. No dia 15 de agosto de 1954, ocorreu a bênção da primeira capela construída no terreno e dedicada a São José. Até o ano de 1967, a comunidade estava ligada a Paróquia N. Sra. dos Remédios. Foi quando chegaram os padres jesuítas americanos (Pe. Jack Vessels, primeiramente, Pe. Edgar e Pe. Eduardo Dougherty posteriormente) para atender os bairros da Vila São José, Jardim Mutinga e Vila Ayrosa.

Em dezembro de 1967 foi instalada, pelo arcebispo de São Paulo, o Cardeal Dom Agnelo Rossi, a paróquia amovível de São José. Depois de um ano e meio, em 02 de março de 1969, foi definitivamente confirmada e criada a Paróquia São José, que compreendia os bairros vila São José, Vila Ayrosa, Jardim Mutinga e parte do Jardim Marieta. Foi nomeado como primeiro pároco o Pe. Jack Vessels, permanecendo até o ano de 1975. De 1975 até 1977 foi pároco o Pe. Edgar. Em 1978 o Pe. Jack reassumiu como pároco, permanecendo até os jesuítas entregarem a paróquia a Dom Francisco Manuel Vieira, bispo da então Região Osasco, da Arquidiocese de São Paulo. 

Por essa época Dom Francisco demonstrou interesse de construir no terreno da Igreja um Seminário, para formar os futuros padres daquela região. O Seminário São José foi construído e sua inauguração se deu no dia 25 de março de 1980. Neste dia assumiu como Reitor do Seminário, o Pe. Martin Segú, e como Pároco da Paróquia São José, o Pe. Aurélio, que também seria vice-reitor do seminário. Em 1985, assumiu como pároco o Pe. André Zamit. Em 1989, São João Paulo II criou a Diocese de Osasco, desmembrada da Arquidiocese de São Paulo, e assume como primeiro Bispo, Dom Francisco Manuel Vieira. No ano de 1993, o Pe. José Maria Falco, foi designado para assumir as funções de Pároco, sendo também reitor do Seminário São José. Durante o ano de 1995 e 1996 moraram na antiga casa paroquial os Padres Pio e Mario da Congregação de Jesus Sacerdote, que também auxiliavam nas celebrações dos sacramentos na Comunidade Paroquial. Em outubro de 2002, Dom Ercílio Turco, segundo bispo diocesano a época, nomeou como pároco, o Pe. Marcos Antônio Funchal. 

Foi realizada a reforma da Igreja São Francisco de Assis (2004-2005), construção da Igreja São João Batista (2006-2015), construção do Centro de Pastoral N. Sra. de Fátima (2007-2011). No ano de 2012, em Assembleia, a Paróquia definiu que seria mais adequado a demolição total da Igreja Matriz, e a construção de um novo templo, no mesmo espaço, ampliando a sua capacidade de acomodação de fiéis em mais de 100%. Em maio de 2014, a Igreja Matriz foi transferida para o Centro de Pastoral, e iniciou-se as obras da nova Igreja Matriz, projeto tão sonhado por toda a paróquia. No dia 07 de setembro de 2014, Dom João Bosco Barbosa de Sousa, 3° bispo diocesano, abençoou a pedra fundamental da nova Igreja, que representou uma grande alegria. Com muitos esforços e empenho de todos, no dia 19 de março de 2016, foi celebrada a primeira missa na Nova Igreja Matriz ainda sem acabamento. Em 2018, foi inaugurado o Colégio São José da Divina Providência, instituição de Ensino Infantil, Fundamental e Médio, alicerçado nos princípios de uma Escola Católica confessional. No ano de 2019, celebrou-se o Jubileu do Cinquentenário da criação da paróquia.

A Paróquia São José, celebra seu passado de esforços e conquistas, com vistas ao futuro, buscando continuar seu trabalho evangelizador nesta querida cidade, nutrindo a fé, a esperança e a caridade, celebrando os sacramentos que nos unem de maneira mais perfeita a Nosso Senhor e anunciando o Evangelho de Cristo, que dá verdadeira consciência e liberdade aos filhos de Deus.

 

Pe. Carlos Augusto Andrade 
''',
                    'assets/imagens/imagemsj_1.jpg', // Caminho da imagem 1
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildImageSlider(), // Adiciona o slider de imagens abaixo das informações
          ],
        ),
      ),
    );
  }

  Widget _buildTitleWithImage(String title, String text, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Ajuste o tamanho e a negrito do título
        ),
        SizedBox(height: 10),
        Image.asset(
          imagePath,
          width: double.infinity, // Expandir a imagem até as laterais da tela
          fit: BoxFit.cover, // Ajustar a imagem para cobrir todo o espaço disponível
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildImageItem('assets/imagens/imagemsj_1.jpg'),
          _buildImageItem('assets/imagens/imagemsj_2.jpg'),
          _buildImageItem('assets/imagens/imagemsj_3.jpg'),
          _buildImageItem('assets/imagens/imagemsj_4.jpg'),
          _buildImageItem('assets/imagens/imagemsj_5.jpg'),
          _buildImageItem('assets/imagens/imagemsj_6.jpg'),
          _buildImageItem('assets/imagens/imagemsj_7.jpg'),
          _buildImageItem('assets/imagens/imagemsj_8.jpg'),
          _buildImageItem('assets/imagens/imagemsj_9.jpg'),
          _buildImageItem('assets/imagens/imagemsj_10.jpg'),
          _buildImageItem('assets/imagens/imagemsj_11.jpg'),
        ],
      ),
    );
  }

  Widget _buildImageItem(String imagePath) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0), // Cantos arredondados
        child: Image.asset(
          imagePath,
          width: 300,
          height: 200,
          fit: BoxFit.cover, // Ajustar a imagem para cobrir todo o espaço disponível
        ),
      ),
    );
  }
}

