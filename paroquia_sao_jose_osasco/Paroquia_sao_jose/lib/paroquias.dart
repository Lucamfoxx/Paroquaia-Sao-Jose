import 'package:flutter/material.dart';

class ParoquiasPage extends StatelessWidget {
  const ParoquiasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paróquias'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ParoquiaSetorTile(
                setor: 'Região Carapicuíba',
                paroquias: {
                  'Paróquia Cristo Ressuscitado': '''

Paróquia Cristo Ressuscitado
Av. Netuno, 468 – Jardim Novo Horizonte – CEP: 06341-420 – Carapicuíba / SP
Decreto de criação: 20/03/2006

Pároco: Padre Alexandre Douglas Crispim

Expediente Paroquial
Terça-feira a Sábado: das 8h às 12h e das 13h às 17h
Tel.: (11) 4186-6977
E-mail:  par.cristoressuscitado@outlook.com

''',
                  'Paróquia Nossa Senhora Aparecida | Carapicuíba': '''
Paróquia Nossa Senhora Aparecida | Carapicuíba
Av. Inocêncio Seráfico, 600 – Centro – CEP: 06320-290 – Carapicuíba / SP
Decreto de criação: 07/09/1952

Pároco: Padre Eduardo Gonçalves da Silva

Expediente Paroquial
Terça-feira a Sexta-feira: das 09h às 13h e das 14h às 19h
Sábado: das 08h às 13h
Tel.: (11) 4386-9894
E-mail:  nsaparecida600@gmail.com
 ''',
                  'Paróquia Nossa Senhora Aparecida e Sagrado Coração de Jesus':
                      '''
Paróquia Nossa Senhora Aparecida e Sagrado Coração de Jesus
Estrada Egílio Vitorello, 15 – Nova Carapicuíba – CEP: 06365-210 – Carapicuíba / SP
Decreto de criação: 12/09/2007

Pároco: Padre Othoniel Berilo Duprat

Expediente Paroquial
Terça-feira a Sexta-Feira: das 09h às 13h e das 14h às 18h
Sábado: das 09h às 13h e das 14h às 17h
Tel.: (11) 4189-2645 | Whatsapp: (11) 98663-5951
E-mail: paroquia.scj.2007@gmail.com
''',
                  'Paróquia Nossa Senhora das Graças': '''
Paróquia Nossa Senhora das Graças
Rua Nova Independência, 9 – Jardim Ana Estela – CEP: 06364-570 – Carapicuíba / SP
Decreto de criação: 13/02/2011

Pároco: Padre Luiz Rogério Gemi

Expediente Paroquial
Terça-feira a Sábado: das 08h às 12h e das 14h às 18h
Tel.: (11) 4169-0813  | Whatsapp: (11) 4169-0813
E-mail: matriznossasenhoradasgracas@gmail.com
''',
                  'Paróquia Santa Edwiges': '''
Paróquia Santa Edwiges
Estrada do Gopiuva, 1165 – Parque Jandaia – CEP: 06330-000 – Carapicuíba/SP
Decreto de criação: 10/10/2012 
Instalação: 15/10/2012

Pároco: Padre Ewerton Leandro Queiroz Silveira

Expediente Paroquial
Terça-feira a Sexta-feira: das 09h às 17h
Sábado: das 8h às 12h
Tel.: (11) 4189-2480
E-mail:   paroquiasantaedwiges.jandaia@gmail.com
''',
                  'Paróquia Santa Rita de Cássia': '''
Paróquia Santa Rita de Cássia
Av. Inocêncio Seráfico, 3.850 – Vila Dirce – CEP: 06380-021 – Carapicuíba / SP
Decreto de criação: 04/03/1988 
Instalação: 02/04/1988

Pároco: Padre Alexandre Pessoa Garcia

Expediente Paroquial
Segunda-feira a Sábado: das 8h às 19h
Tel.: (11) 4187-3426
E-mail: secretaria@santaritaparoquia.com.br
''',
                  'Paróquia Santo Antônio | Vila Caldas': '''
Paróquia Santo Antônio | Vila Caldas
Rua Venceslau Brás, 106 – Vila Caldas – CEP: 06310-080 – Carapicuíba / SP
Decreto de criação: 17/08/1966

Pároco: Padre Henrique Souza Da Silva

Vigário paroquial: Padre Sérgio Luiz de Medeiros

Expediente Paroquial
Terça-feira a Sábado: das 8h às 17h
Tel.: (11) 4184-4828
E-mail:  psantonio_caldas@hotmail.com
''',
                  'Paróquia São Francisco de Assis': '''
Paróquia São Francisco de Assis
Rua Franca, 198 – Cidade Ariston – CEP: 06396-250 – Carapicuíba / SP
Decreto de criação: 01/09/2001

Pároco: Padre Raimundo Nonato Alves

Vigário Paroquial: Padre Vitor Mateus Kano

Expediente Paroquial
Terça-feira a Sábado: das 8h às 12h e das 13h às 17h
Tel.: (11) 4181-4090
Email: par.sf.assis@gmail.com

 
''',
                  'Paróquia São José': '''
Paróquia São José
Av. Amália, 12 – Vila Cretti – CEP: 06386-430 – Carapicuíba / SP
Decreto de criação: 14/02/2014 
Instalação: 19/03/2014

Pároco: Padre Valmirar Santos Almeida

Expediente Paroquial
Terça-feira a Sexta-feira: das 8h às 17h
Sábado: das 8h às 12h
Tel.: (11) 4184-9305
E-mail:  sj-92@diocesedeosasco.com.br
Site: paroquiasaojosecarapicuiba.com
''',
                  'Paróquia São Lucas Evangelista': '''
Paróquia São Lucas Evangelista
Av. Inocêncio Seráfico, 2450A – Vila Silva Ribeiro – CEP: 06380-021 – Carapicuíba / SP
Decreto de criação: 20/09/1971

Pároco: Padre Nilso Aparecido da Motta

Vigário Paroquial: Padre Jefferson Bezerra de Almeida

Expediente Paroquial
Terça-feira a Sexta-Feira: das 9h às 17h30
Sábado: das 9h às 12h30 e das 13h30 às 17h30
Tel.: (11) 4188-1827
E-mail: secretariasaolucas18@gmail.com
Site: www.paroquiasaolucas.com.br
''',
                  'Paróquia São Paulo Apóstolo': '''
Paróquia São Paulo Apóstolo
Rua Rio Branco, 38 – COHAB II – CEP: 06326-030 – Carapicuíba / SP
Decreto de criação: 27/10/2000

Pároco: Padre Ricardo Rodrigues dos Santos

Expediente Paroquial
Terça-feira a Sábado: das 08h e às 12h e das 14h às 18h
Tel.: (11) 4184-1203 | Whatsapp: (11) 4184-1203
Email: secretaria@pspa.com.br
''',
                  'Paróquia São Pedro Apóstolo': '''
Paróquia São Pedro Apóstolo
Praça São Pedro, 126 – Vila Sul Americana – CEP: 06397-070 – Carapicuíba / SP
Decreto de criação: 16/11/1971

Pároco: Padre Rafael Ferreira de Santana

Expediente Paroquial
Terça-feira a Sexta-Feira: 08h às 12h e das 13h às 17h
Sábado: das 9h às 16h
Tel.: (11) 4374-0771 | Whatsapp: (11) 4374-0771
E-mail: paroquiasaopedroapostolo@hotmail.com
''',
                  'Paróquia São Pedro e São Paulo': '''
Paróquia São Pedro e São Paulo
Estrada Ernestina Vieira, 150 – Jd. Leopoldina – CEP: 06382-260 – Carapicuíba / SP
Decreto de criação: 15/06/2012 
Instalação: 30/06/2012

Pároco: Padre Carlos Eduardo Souza Roque

Vigário Paroquial: Padre Douglas Henrique Aparecido Augusto Oliveira

Expediente Paroquial
Terça-feira a Sábado: das 13h às 18h45
Tel.: (11) 4167-0264
E-mail: secretaria@saopedroesaopaulo.com.br
Site: www.saopedroesaopaulo.com.br
''',
                  'Paróquia São Roque': '''
Paróquia São Roque
Rua Adão Gonçalves da Costa, 178 – Vila Jussara – CEP: 06321-040 – Carapicuíba / SP
Decreto de criação: 01/09/1984

Administrador paroquial: Padre Luiz Rogério Gemi

Diácono transitório: Diácono Matheus Bravo Magalhães

Expediente Paroquial
Terça-feira a Sábado: das 08h30 às 13h e das 14h às 17h30
Tel.: (11) 4183-3741
E-mail: secretariapsr178@hotmail.com
Site: www.paroquiasaoroque.com.br
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Cotia',
                paroquias: {
                  'Paróquia Nossa Senhora Aparecida | Tijuco Preto': '''
Paróquia Nossa Senhora Aparecida | Tijuco Preto
Rua São Paulo das Missões, 235 – Tijuco Preto – CEP: 06730-000 – Vargem Grande Paulista / SP
Decreto de criação: 24/03/2011
Instalação: 31/05/2011

Pároco: Padre Valdivino Aparecido Gonçalves

Expediente Paroquial
Terça-feira: das 13h às 17h
Quarta-feira à Sábado: das 8h às 12h e das 13h às 17h
Tel.: (11) 4158-5834 / WhatsApp (11) 95585-9440
E-mail:  contato.nsaparecida@yahoo.com.br
''',
                  'Paróquia Nossa Senhora das Graças': '''
Paróquia Nossa Senhora das Graças
Praça da Matriz, 76 – Centro – CEP: 06730-000 – Vargem Grande Paulista / SP
Decreto de criação: 27/04/1979
Instalação: 28/04/1979

Pároco: Padre Reginaldo Machado Hilário

Vigário Paroquial: Padre Antônio Carlos de Souza

Expediente Paroquial
Segunda-feira a Sexta-feira: das 9h às 12h e das 13h às 18h
Sábado: das 9h às 13h
Tel.: (11) 4158-3013
E-mail:  igrejamatriz.nsgracas@gmail.com
''',
                  'Paróquia Nossa Senhora de Fátima': '''
Paróquia Nossa Senhora de Fátima
Rua dos Canários, 369 – Jardim Nova Coimbra – CEP: 06703-390 – Cotia / SP
Decreto de criação: 08/05/2009

Pároco: Padre Thiago Jordão da Silva

Vigário Paroquial: Padre Francisco das Chagas Lima Oliveira

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 13h às 17h30
Sábado: das 8h às 12h
Tel.: (11) 4614-4781
E-mail:  pnsf2009@hotmail.com
''',
                  'Paróquia Nossa Senhora do Carmo e São Cristóvão': '''
Paróquia Nossa Senhora do Carmo e São Cristóvão
Av. Nossa Senhora do Carmo, s/nº – Bairro do Carmo Messias – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 16/03/2010

Pároco: Padre Gilmar Raimundo de Santana

Expediente Paroquial
Segunda-feira a Sexta-feira: das 7h às 12h e das 13h às 16h
Tel.: (15) 3394-1401
E-mail:  paroquiacarmocrist@hotmail.com
''',
                  'Paróquia Nossa Senhora do Monte Serrate': '''
Paróquia Nossa Senhora do Monte Serrate
Rua Senador Feijó, 12 – Centro – CEP: 06700-075 – Cotia / SP
Decreto de criação: 27/08/1713

Pároco: Padre Mauro Ferreira

Vigário Paroquial: Padre Everaldo Felix da Silva

Expediente Paroquial
Terça-feira a Sábado: Das 9h às 18h
Tel.: (11) 4703-2180 
E-mail:  secretaria.serrate@outlook.com.br
''',
                  'Paróquia Nossa Senhora do Rosário de Fátima': '''
Paróquia Nossa Senhora do Rosário de Fátima
Rua Joaquim Pires Godinho, 13 – Água Espraiada – CEP: 06727-350 – Cotia / SP
Decreto de criação: 19/08/2015
Instalação: 01/09/2015

Pároco: Padre Douglas Dias de Melo

Expediente Paroquial
Terça-feira a Sexta-feira: das 14h às 19h
Sábado: das 9h às 13h
Tel.: (11) 4242-6203
E-mail:  paroquia.nsrosariofatima@gmail.com
''',
                  'Paróquia Nossa Senhora Imaculada Conceição': '''
Paróquia Nossa Senhora Imaculada Conceição
Rua José Manoel de Oliveira, 105 – Centro – Caucaia do Alto – CEP: 06727-187 – Cotia / SP
Decreto de criação: 08/12/1979

Pároco: Padre José Maria Falco

Vigário Paroquial: Padre Luiz Gonzaga de Santana

Diácono Transitório: Diácono Henrique de Marins Monteiro
Expediente Paroquial
Terça-feira a Sexta-feira: das 07h às 16h
Sábado: das 08h às 12h
Tel.: (11) 4611-5732
E-mail: nsic_41@diocesedeosasco.com.br
''',
                  'Paróquia Santa Cruz e Nossa Senhora das Dores': '''
Paróquia Santa Cruz e Nossa Senhora das Dores
Rua Balão Mágico, 1606 – Jardim do Rio Cotia – CEP: 06715-780 – Cotia / SP
Decreto de criação: 19/02/2013
Instalação: 23/04/2013

Pároco: Padre Carlos Augusto de Andrade

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 13h e das 14h às 18h
Sábado: das 9h às 13h e das 14h às 17h
Tel.: (11) 4614-8302
E-mail:  p.santacruzcotia@yahoo.com.br
Site: www.paroquiasantacruznsdores.com.br
''',
                  'Paróquia Santo Antônio': '''
Paróquia Santo Antônio
Rua Santo Antônio, 486 – Granja Viana (Rod. Raposo Tavares, Km 24) – CEP: 06708-370 – Cotia / SP
Decreto de criação: 30/10/1957

Pároco: Padre Márcio Lopes Vieira, FDP

Vigário Paroquial: Padre Aparecido Pereira da Silva, FDP

Expediente Paroquial
Segunda-feira: 08h às 12h e das 13h às 17h
Terça-feira a Sexta-feira: das 08h às 12h e das 13h às 18h
Sábado: das 08h às 12h
Domingo: das 07h às 13h
Tel.: (11) 4702-0597 | Whatsapp: (11) 95777-6429
E-mail: secretaria@paroquiagranjaviana.com.br
Site: www.paroquiagranjaviana.com.br
''',
                  'Paróquia Santo Antônio de SantAnna Galvão': '''
Paróquia Santo Antônio de Sant’Anna Galvão
Av. Bela Vista, 139 – Jardim Bela Vista – CEP: 06730-000 – Vargem Grande Paulista / SP
Decreto de criação: 10/03/2008

Pároco: Padre Alexandre de Oliveira

Expediente Paroquial
Terça-feira a Sexta-Feira: das 13h às 18h
Sábado: das 8h às 13h
Tel.: (11) 4559-2648
E-mail: paroquiafreigalvao@hotmail.com.br
Site: www.freigalvaovgp.com.br

 
''',
                  'Paróquia Santo Antônio e Nossa Senhora do Carmo': '''
Paróquia Santo Antônio e Nossa Senhora do Carmo
Rua Santa Cruz, 100 – Vila Santo Antônio do Portão – CEP: 06716-735 – Cotia / SP
Decreto de criação: 03/01/2003
Instalação: 09/02/2003

Pároco: Padre Severino Ferreira da Silva

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 13h às 16h30
Sábado: das 09h às 12h
Tel.: (11) 4614-1562
E-mail: matrizportao@hotmail.com
''',
                  'Paróquia São Benedito': '''
Paróquia São Benedito
Rua dos Coqueirais, 838 – Jardim Petrópolis – CEP: 06719-460 – Cotia / SP
Decreto de criação: 07/10/2016

Pároco: Pe. Franklin Bruno Costa

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 13h às 17h30
Sábado: das 9h às 12h
Tel.: (11) 4551-8801
E-mail:  areapastoralbenedito@gmail.com
''',
                  'Paróquia São Pio X': '''
Paróquia São Pio X
Estrada do Morro Grande, 138 – Jardim Atalaia – CEP: 06700-650 – Cotia / SP
Decreto de criação: 15/04/2009
Instalação: 21/04/2009

Pároco: Padre Marcelo Pereira da Silva

Expediente Paroquial
Terça-feira a Sexta-feira: das 11h às 17h
Sábado: das 09h às 15h
Tel.: (11) 4616-6868
E-mail: secretaria@paroquiasaopiox.com
Site: www.paroquiasaopiox.com
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Bonfim',
                paroquias: {
                  'Paróquia Cristo Rei': '''
Paróquia Cristo Rei
Rua Cristo Rei, 500 – Jardim Baronesa – CEP: 06263-000 – Osasco / SP
Decreto de criação: 02/01/2006

Pároco: Padre Emilson Aparecido Ferreira

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 14h às 19h
Sábado: das 8h às 12h e das 14h às 18h
Tel.: (11) 3686-9993
E-mail:  matrizcristorei33@gmail.com
''',
                  'Paróquia Nossa Senhora Aparecida | Helena Maria': '''
Paróquia Nossa Senhora Aparecida | Helena Maria
Rua Professor Sud Menucci, 70 – Jardim Helena Maria – CEP: 06250-250 – Osasco / SP
Decreto de criação: 24/02/1969

Pároco: Padre Sebastião dos Reis Miranda

Vigário Paroquial: Padre Xavier Cutajar

Expediente Paroquial
Terça-feira a Sexta-feira: das 14h às 19h
Sábado: das 8h às 12h30 e das 14h às 19h
Tel.: (11) 4237-3795
E-mail: pnsahm@gmail.com
''',
                  'Paróquia Nossa Senhora Aparecida | Jardim Piratininga': '''
Paróquia Nossa Senhora Aparecida | Jardim Piratininga
Rua General Labatut, 19 – Jardim Piratininga – CEP: 06233-060 – Osasco / SP
Decreto de criação: 09/09/1966

Pároco: Padre Fernando de Moraes Ribeiro

Vigário Paroquial: Padre Marco Aurélio Cassiano de Andrade

Expediente Paroquial
Terça-feira a Sexta-feira: das 14h às 18h
Sábado: das 8h às 12h e das 14h às 16h
Tel.: (11) 3687-8088
E-mail:  paroquiansapiratininga@uol.com.br
''',
                  'Paróquia Nossa Senhora Aparecida | Vila Piauí': '''
Paróquia Nossa Senhora Aparecida | Vila Piauí
Rua Nilva, 324 – Vila Piauí – CEP: 05109-170 – São Paulo / SP
Decreto de criação: 18/12/1967

Pároco: Padre Rafael Smocovitz dos Santos, CRL

Vigário paroquial: Padre Daniel Nogueira de Assis

Vigário paroquial: Padre Deolindo de Almeida Tenório, CRL

Expediente Paroquial
Segunda-feira: das 13h às 17h
Terça-feira a Sexta-feira: das 8h às 12h e das 13h às 17h
Sábado: das 8h às 12h
Tel.: (11) 3621-6957 / (11) 2574-3179
E-mail:  nsaparecida_vpiaui@hotmail.com
''',
                  'Paróquia Nossa Senhora do Rosário de Fátima': '''
Paróquia Nossa Senhora do Rosário de Fátima
Rua Amador Bueno, 596 – Jardim Piratininga – CEP: 06230-100 – Osasco / SP
Decreto de criação: 10/01/2013
Instalação: 10/03/2013

Administrador Paroquial: Padre Fernando de Moraes Ribeiro

Expediente Paroquial
Terça-feira: das 13h30 às 18h
Quarta-feira a Sexta-feira: das 09h às 12h e das 13h às 17h
Sábado: das 09h às 12h
Tel.: (11) 3656-2659 | Whatsapp: (11) 93393-9154
E-mail:  nsrarosariodefatima@hotmail.com
''',
                  'Paróquia Nossa Senhora dos Remédios': '''
Paróquia Nossa Senhora dos Remédios
Rua Santa Erotildes, 483 – Vila dos Remédios CEP: 06298-060 – Osasco / SP
Decreto de criação: 16/07/1950

Pároco: Padre Edmilson Januário, CRL

Vigário Paroquial: Dom Bruno Giuliani, CRL
Vigário Paroquial: Padre Amauri Baggio, CRL
Vigário Paroquial: Padre Mário Tadeu Paulino, CRL
Vigário Paroquial: Padre Rogério Pires, CRL

Expediente Paroquial
Segunda-feira: das 14h às 18h
Terça-feira a Sexta-feira: das 8h às 12h e das 15h às 19h
Sábado: das 8h às 12h
Tel.: (11) 2640-2406
E-mail: secretaria@paroquiadosremedios.com
Site: www.paroquiadosremedios.com
''',
                  'Paróquia Santa Gema Galgani': '''
Paróquia Santa Gema Galgani
Rua Gabriel Seferian, 405 – Presidente Altino – CEP: 06210-060 – Osasco / SP
Decreto de criação: 29/06/1953

Pároco: Padre Edilson Pinto dos Santos

Expediente Paroquial
Terça-feira a Sábado: das 9h às 13h e das 14h às 18h
Tel.: (11) 3682-5633
E-mail:  paroquiasantagema@gmail.com
''',
                  'Paróquia Santa Teresinha do Menino Jesus': '''
Paróquia Santa Teresinha do Menino Jesus
Rua Doutor Rubens Rebouças de Carvalho, 200 – Portal D’Oeste I – CEP: 06263-210 – Osasco / SP
Decreto de criação: 27/02/2013
Instalação: 09/03/2013

Administrador Paroquial: Padre Rodrigo Sousa Carvalho

Expediente Paroquial
Terça-feira a Sábado: das 8h às 12h e das 13h às 17h
Tel.: (11) 3656-9697
E-mail:  santateresinhaosasco@gmail.com
''',
                  'Paróquia Santo Antônio de Pádua': '''
Paróquia Santo Antônio de Pádua
Rua Paúva, 526 – Vila Jaguara – CEP: 05116-001 – São Paulo / SP
Decreto de criação: 1962

Pároco: Padre Mário Pistor, CRL

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 14h às 18h
Sábado: das 9h às 12h e das 16h às 18h
Domingo: das 9h às 11h
Tel.: (11) 3625-1763
E-mail:  santoantoniojaguara@gmail.com
''',
                  'Paróquia São João Batista | Rochdale': '''
Paróquia São João Batista | Rochdale
Praça Professor Anésio Cabral, 355 – Rochdale – CEP: 06226-010 – Osasco / SP
Decreto de criação: 18/05/1969

Pároco: Padre Flávio Soares Lopes

Diácono Permanente: Diácono Marcelo Otávio Bruno

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 14h às 18h
Sábado: das 15h às 19h
Tel.: (11) 3686-2240 | Whatsapp: (11) 96323-4343
E-mail: paroquiasjbrochdale@hotmail.com
Facebook: Pascom PSJB Rochadale
''',
                  'Paróquia São José': '''
Paróquia São José
Rua Francisco Haro Alaminos, 80 – Vila São José – CEP: 06290-050 – Osasco / SP
Decreto de criação: 18/12/1967

Pároco: Padre Marcos Antônio Funchal

Vigário Paroquial: Padre Jonathan Paes Ferreira

Expediente Paroquial
Terça-feira a Sexta-Feira: das 08h às 12h e das 13h às 17h
Sábado: das 09h às 12h e das 14h às 18h
Tel.: (11) 3686-8961 | Whatsapp: (11) 98936-9413
E-mail:  secretaria@saojoseosasco.com.br
''',
                  'Paróquia São José Operário | Munhoz Júnior': '''
Paróquia São José Operário | Munhoz Júnior
Rua Piacatu, 477 – Munhoz Júnior – CEP: 06240-160 – Osasco / SP
Decreto de criação: 13/08/2000

Administrador Paroquial: Padre Fábio Rosário dos Santos

Vigário Paroquial: Padre Pedro Rodrigues

Expediente Paroquial
Terça-feira a Sábado: das 13h às 19h
Tel.: (11) 3603-1887 | Whatsapp: (11) 93235-8781
Whatsapp 93235-8781
E-mail:  psjomunhozjr@gmail.com
''',
                  'Paróquia Senhor do Bonfim': '''
Paróquia Senhor do Bonfim
Rua André Rovai, 332 – Bonfim – CEP: 06233-150 – Osasco / SP
Decreto de criação: 29/06/1953

Pároco: Padre Pedro Paulo Espírito Santo Queiroz, CJS 

Vigário Paroquial: Padre Adenilson de Oliveira, CJS

Expediente Paroquial

Terça-feira a Sexta-feira: das 13h30 às 19h30
Sábado: das 13h às 19h
Tel.: (11) 3681-9370
E-mail:   senhordobonfimosasco@gmail.com
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Santo Antônio',
                paroquias: {
                  'Catedral Santo Antônio': '''
Catedral Santo Antônio
Avenida Santo Antônio, 1.090 – Vila Osasco – CEP: 06086-060 – Osasco / SP
Decreto de criação da Paróquia Santo Antônio: 24 de agosto de 1930
Elevada a Catedral Diocesana: 15 de março de 1989

Pároco: Monsenhor Claudemir José dos Santos

Vigário Paroquial: Padre Vinícius Soares da Silva
Vigário Paroquial: Padre Robison José Silveira Fernandes
Vigário Paroquial: Padre Marcos Martiniano da Silva
Vigário Paroquial: Padre Juliano Pires Fernandes de Oliveira

Diácono Transitório: Diácono Adriano da Silva Oliveira

Expediente Paroquial
Todos os dias: das 8h às 19h30
Tel.: (11) 3681-8611
E-mail: seccatedraldeosasco@uol.com.br
Site: www.catedraldeosasco.com.br

 
''',
                  'Paróquia Bom Jesus Crucificado': '''
Paróquia Bom Jesus Crucificado
Rua Ananias de Almeida, 427 – Quitaúna – CEP: 06186-190 – Osasco / SP
Decreto de criação: 27/02/2018

Pároco: Padre Marcelo Fernandes de Lima

Expediente Paroquial
Terça-feira a Sábado: das 09h às 12h e das 14h às 18h
Tel.: (11) 3608-1647
E-mail:   paroquiabomjesusosasco@gmail.com
''',
                  'Paróquia Espírito Santo': '''
Paróquia Espírito Santo
Av. Horácio Lafer, 986 – Jardim das Flores – CEP: 06112-010 – Osasco / SP
Decreto de criação: 20/09/1971

Pároco: Padre Vagner João Pacheco de Moraes

Vigário Paroquial: Padre Samuel Elias Netto

Expediente Paroquial
Terça-feira a Sexta-feira: das 09h às 11h e das 14h às 19h
Sábado: das 08h às 11h e das 14h às 18h
Tel.: (11) 3682-3055
E-mail:  paroquiaes.osasco@gmail.com
''',
                  'Paróquia Nossa Senhora Aparecida | Jaguaribe': '''
Paróquia Nossa Senhora Aparecida | Jaguaribe
Rua Deodate Pereira Rezende, 78 – Jaguaribe – CEP: 06050-190 – Osasco / SP
Decreto de criação: 03/09/2012

Pároco: Padre Antônio Machado Ferreira

Expediente Paroquial
Terça-feira a Sexta-feira: das 9h às 12h e das 14h às 18h
Sábado: das 9h às 13h
Tel.: (11) 3691-6448
E-mail:  nossasenhora.jaguaribe@hotmail.com
''',
                  'Paróquia Nossa Senhora Imaculada Conceição': '''
Paróquia Nossa Senhora Imaculada Conceição
Rua Nossa Senhora Imaculada Conceição, 114 – Km 18 – CEP: 06190-100 – Osasco / SP
Decreto de criação: 29/06/1953

Pároco: Padre Odair José Rodrigues

Expediente Paroquial
Terça-feira a Sábado: das 14h às 20h
Tel.: (11) 3608-7111
E-mail: nsc-32@diocesedeosasco.com.br | paroquia.nsckm18osasco@outlook.com
''',
                  'Paróquia Sagrada Família': '''
Paróquia Sagrada Família
Rua Octávio Antônio Meneghesso, 207A – Vila Yara – CEP: 06028-140 – Osasco / SP
Decreto de criação: 29/06/1953

Pároco: Padre Cláudio Gabriel dos Santos

Vigário Paroquial: Padre Alexandre Santos de Jesus

Expediente Paroquial
Terça-feira a Sexta-feira: das 08h às 12h e das 13h às 17h
Sábado: das 08h às 12h e das 14h às 18h
Tel.: (11) 3699-3931
E-mail:  sagradafamilia.yara@gmail.com
''',
                  'Paróquia Santa Isabel e São Zacarias': '''
Paróquia Santa Isabel e São Zacarias
Rua Doutor Nilo Machado, 337 – Vila Isabel – CEP: 06180-060 – Osasco / SP
Decreto de criação: 19/08/1968
Instalação: 15/09/1968

Pároco: Padre Diego Martins Dos Santos

Diácono Transitório: Diácono Henrique dos Santos

Expediente Paroquial
Terça-feira a Sexta-feira: das 08h às 19h
Sábado: das 08h às 18h
Tel.: (11) 3681-2598
E-mail:  paroquiaisabel@gmail.com
''',
                  'Paróquia São Domingos “O Pregador”': '''
Paróquia São Domingos “O Pregador”
Av. Padre Vicente Melillo, 831 – Jardim Umuarama – CEP: 06036-013 – Osasco / SP
Decreto de criação: 30/09/1973

Pároco: Padre José Eduardo de Oliveira e Silva

Expediente Paroquial
Terça-feira a Sábado: das 13h às 19h
Tel.: (11) 3681-0333
E-mail: paroco.sao.domingos@gmail.com
Site: www.paroquiasaodomingos.org
''',
                  'Paróquia São Gabriel da Virgem Dolorosa': '''
Paróquia São Gabriel da Virgem Dolorosa
Rua Helena Barbosa Marcondes, 101 – Jardim Ypê – CEP: 06060-150 – Osasco / SP
Decreto de criação: 27/02/2000

Pároco: Padre Gilvan Leite de Araújo

Expediente Paroquial
Terça-feira a Sábado: das 08h às 11h30 e das 13h às 17h
Tel.: (11) 3691-2878
E-mail:  saogabrieldavirgem@gmail.com
''',
                  'Paróquia São Paulo da Cruz': '''
Paróquia São Paulo da Cruz
Rua Imperatriz, 119 – Jardim Santo Antônio – CEP: 06130-030 – Osasco / SP
Decreto de criação: 20/09/1971

Pároco: Padre Nivaldo Moisés Júnior

Vigário Paroquial: Padre Antônio Tadeu Domingues de Godoi

Diácono Transitório: Diácono Felipe Fleming Amorim

Expediente Paroquial
Terça-feira a Sábado: das 07h às 12h e das 13h30 às 17h
Tel.: (11) 3609-6976
E-mail:  paroquiaspc@yahoo.com.br
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região São José Operário',
                paroquias: {
                  'Paróquia Imaculada Conceição': '''
Paróquia Imaculada Conceição
Rua Capivari-Mirim, 444 – Jardim Dracena – CEP: 05528-290 – São Paulo / SP
Decreto de criação: 07/12/1999

Pároco: Padre Luiz Roberto de Andrade Souza

Expediente Paroquial
Terça-feira a Sexta-feira: das 14h às 19h
Sábado: das 09h às 12h e das 14h às 17h
Tel.: (11) 3751-2884 | WhatsApp: (11) 95875-4370
E-mail:  p.imaculadac@gmail.com
 ''',
                  'Paróquia Nossa Senhora Aparecida | Jardim Padroeira II': '''
Paróquia Nossa Senhora Aparecida | Jardim Padroeira II
Rua José Nabor, 11 – Jardim Padroeira II – CEP: 06162-120 – Osasco / SP
Decreto de criação: 20/01/2010

Pároco: Padre Leonardo Sousa dos Santos

Expediente Paroquial
Terça-feira a Sexta-feira: das 13h às 19h
Sábado: das 09h às 13h
Tel.: (11) 3591-9902
E-mail: pnsa.2010@yahoo.com.br
 ''',
                  'Paróquia Nossa Senhora das Graças': '''
Paróquia Nossa Senhora das Graças
Rua Nossa Senhora das Graças, 272 – Jardim Novo Osasco – CEP: 06045-060 – Osasco / SP
Decreto de criação: 10/03/1977

Pároco: Padre Flávio Silva dos Anjos

Expediente Paroquial
Terça-feira a Sexta-feira: das 08h às 20h
Sábado: das 09h às 19h
Tel.: (11) 3609-9435 | Whatsapp:(11) 3609-9435
E-mail: dasgracas27@gmail.com
 ''',
                  'Paróquia Nossa Senhora de Nazaré': '''
Paróquia Nossa Senhora de Nazaré
 Av. General Asdrúbal da Cunha, 266 – Jardim Arpoador – CEP: 05565-000 – São Paulo / SP
Decreto de criação: 23/09/1966

Pároco: Padre Jorge Augusto Moreira Alexandre

Vigário paroquial: Padre Leonardo Loriato de Souza

Expediente Paroquial
Terça-feira a Sexta-feira: das 09h às 12h e das 13h às 19h
Sábado: das 08h às 12h e das 13h às 17h
Tel.: (11) 3782-1952 | Whatsapp: (11) 3782-1952
E-mail:  secretaria@paroquianazare.org.br
Site: paroquianazare.org.br
 ''',
                  'Paróquia Santa Maria Mãe de Deus': '''
Paróquia Santa Maria Mãe de Deus
Rua Eugênio Pacelli, 1013 – Jardim Santa Maria – CEP: 06149-214 – Osasco / SP
Decreto de criação: 23/02/2012
Instalação: 26/02/2012

Pároco: Padre Diego Medeiros

Expediente Paroquial
Terça-feira a Sábado: das 09h às 12h e das 14h às 18h
Tel.: (11) 4376-0669 | Whatsapp: (11) 99308-8095
E-mail: stamariamaededeus@gmail.com
 ''',
                  'Paróquia São João Batista | Jardim Conceição': '''
Paróquia São João Batista | Jardim Conceição
Rua Piauiense, 116 – Jardim Conceição – CEP: 06140-010 – Osasco / SP
Decreto de criação: 27/02/2012
Instalação: 10/03/2012

Pároco: Padre Osmar Alves Souza

Expediente Paroquial
Terça-feira a Sábado: das 09h às 12h e das 13h às 18h
Tel.: (11) 3605-6405
E-mail: secretariapsjb@yahoo.com.br / secretariapsjb@gmail.com
 ''',
                  'Paróquia São José Operário | Jardim D’Abril': '''
Paróquia São José Operário | Jardim D’Abril
Av. Prestes Maia, 901 – Jardim D’Abril – CEP: 06040-008 – Osasco / SP
Decreto de criação: 18/09/1967

Pároco: Padre Romildo Isidro Lopes Filho

Vigário Paroquial: Padre José Aparecido Pereira

Expediente Paroquial
Terça-feira a Sexta-feira: das 13h30 às 19h
Sábado: das 09h às 18h
Tel.: (11) 3609-7049
E-mail:  secretariapsjo@yahoo.com.br
 ''',
                  'Paróquia São Judas Tadeu': '''
Paróquia São Judas Tadeu
Rua José Porfírio de Souza, 101 – Jardim Educandário – CEP: 05563-090 – São Paulo / SP
Decreto de criação: 07/07/2017
Instalação: 08/07/2017

Pároco: Padre Paulo Rogério Silva Couto

Expediente Paroquial
Terça-feira a sábado das 13h às 19h
Tel.: (11) 3782-3627
E-mail:  paroquiasjtadeu@outlook.com
 ''',
                  'Paróquia São Vito': '''
Paróquia São Vito
Rua São Marcos, 1 – Jardim São Vito – CEP: 06144-230 – Osasco / SP
Decreto de criação: 18/03/2010

Pároco: Padre Alan Ramos do Nascimento

Expediente Paroquial
Segunda-feira a Sábado: das 08h às 12h e das 14h às 17h
Tel.: (11) 3591-1294
E-mail:  paroquiasaovito@ymail.com
 ''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Barueri',
                paroquias: {
                  'Paróquia Nossa Senhora da Escada': '''
Paróquia Nossa Senhora da Escada
Rua Nossa Senhora da Escada, 211 – Aldeia de Barueri – CEP: 06440-060 – Barueri / SP
Ano de fundação: 1560
Decreto de criação: 01/09/1984

Pároco: Padre Fábio Rosário dos Santos

Expediente Paroquial
Rua Ministro Raphael de Barros Monteiro, 38
Jardim dos Camargos – CEP: 06410-080 – Barueri / SP
Terça-feira a Sexta-feira: das 09h às 12h e das 13h30 às 18h
Sábado: das 09h às 12h
Tel.: (11) 4191-6249 | Whatsapp: (11) 4191-6249
E-mail: contato@paroquianossasenhoradaescada.com
Site: www.paroquianossasenhoradaescada.com
''',
                  'Paróquia Nossa Senhora das Graças': '''
aróquia Nossa Senhora das Graças
Rua Antônio Fernandes Prado, 55 – Vila Nova – CEP: 06420-010 – Barueri / SP
Decreto de criação: 16/10/1972

Pároco: Padre Benedito Aparecido Cesário

Expediente Paroquial
Terça-feira a Sexta-feira: das 14h às 18h
Sábado: das 08h às 11h
Tel.: (11) 4198-3072
E-mail: secretaria@nsdasgracas.com.br
Site: www.nsdasgracas.com.br
''',
                  'Paróquia Nossa Senhora de Lourdes': '''
Paróquia Nossa Senhora de Lourdes
Av. Piraíba, 432 – Centro Comercial Jubran – CEP: 06460-121 – Barueri / SP
Decreto de criação: 07/02/2000

Pároco: Padre Ubirajara Vieira Melo

Expediente Paroquial
Terça-feira a Sexta-feira: das 08h às 17h
Sábado: das 09h às 15h
Tel.: (11) 4193-6911 | Whatsapp: (11) 94333-7020
E-mail: secretarialourdesgruta@gmail.com
Site: www.lourdesalpha.com.br
''',
                  'Paróquia Nossa Senhora Mãe da Igreja': '''
Paróquia Nossa Senhora Mãe da Igreja
Av. Brigadeiro Manoel Rodrigues Jordão, 761 – Jardim Silveira – CEP: 06433-010 – Barueri / SP
Decreto de criação: 17/12/1973
Instalação: 30/12/1973

Pároco: Padre Atílio de Souza

Expediente Paroquial
Segunda-feira a Sábado: das 13h às 17h
Tel.: (11) 4194-0458
E-mail: secretaria.maedaigreja@hotmail.com
Site: www.pmaedaigreja.com.br
''',
                  'Paróquia Rainha Santa Isabel': '''
Paróquia Rainha Santa Isabel
Rua Figueira, 73 – Parque Viana – CEP: 06449-030 – Barueri / SP
Decreto de criação: 19/11/1999

Pároco: Padre Rogério Lemos

Expediente Paroquial
Segunda-feira: das 08h às 12h e das 13h às 18h
Terça a Sexta-feira: das 08h às 18h
Sábado: das 08h às 12h e das 13h às 17h
Tel.: (11) 4194-6151 | WhatsApp: (11) 96925-4533
E-mail: secretaria@paroquiarainhasantaisabel.com.br
Site: www.paroquiarainhasantaisabel.com.br
''',
                  'Paróquia Santa Cruz': '''
Paróquia Santa Cruz
Av. Lourenço Zacaro, 15 – Jardim São Silvestre – CEP: 06408-000 – Barueri / SP
Decreto de criação: 22/11/1999

Pároco: Padre Márcio José Pereira

Vigário Paroquial: Padre Vinícius Rocha de Oliveira

Expediente Paroquial
Terça-feira a Sexta-feira: das 08h às 13h e das 14h às 17h
Sábado: das 09h às 12h
Tel.: (11) 4706-4460
E-mail: santacruzbarueri@gmail.com
Site: www.santacruzbaruerisp.com.br
''',
                  'Paróquia São João Batista | Barueri': '''
Paróquia São João Batista | Barueri
Av. Henriqueta Mendes Guerra, 212 – Vl. São João (Centro) – CEP: 06401-160 – Barueri / SP
Decreto de criação: 07/09/1952
Instalação: 01/01/1953

Pároco: Padre Márcio Messias Cardozo

Expediente Paroquial
Segunda-feira: das 08h às 12h e das 13h às 17h
Terça-feira a Sexta-feira: das 8h às 12h e das 13h às 18h14
Sábado: das 08h às 12h
Tel.: (11) 4198-2760
E-mail: paroquiasjbb@uol.com.br  | secretaria@saojoaobatistabarueri.com.br
Site: www.saojoaobatistabarueri.com.br
''',
                  'Paróquia São José de Anchieta': '''
Paróquia São José de Anchieta
Rua Dora, 14 – Parque dos Camargos – CEP: 06436-210 – Barueri/SP
Decreto de criação:
Instalação: 16/12/2022

Pároco: Padre Adinael Carlos Miguel

Expediente Paroquial
Segunda à sexta: das 13h às 18h
Sábado: das 09h às 12h
Tel.: (11) 4552 – 9880 | WhatsApp: (11) 4552 – 9880
E-mail: comunidadeanchietabarueri@outlook.com
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região São Roque',
                paroquias: {
                  'Paróquia Nossa Senhora Aparecida | São Roque': '''
Paróquia Nossa Senhora Aparecida | São Roque
Rua Anna Reviglio Aldegheri, 300 – Bairro Marmeleiro – CEP: 18131-602 – São Roque / SP
Decreto de criação: 31/05/2004

Pároco: Padre Antonio Carlos Ribeiro

Vigário Paroquial: Padre Francisco Pereira da Silva

Expediente Paroquial
Terça-feira a Sexta-feira: das 8h às 12h e das 13h às 17h
Sábado: das 8h às 12h e das 13h às 16h
Tel.: (11) 4708-3825
E-mail:  par.nsaparecida.mk@gmail.com
''',
                  'Paróquia Nossa Senhora da Penha': '''
Paróquia Nossa Senhora da Penha
Praça da Matriz, s/n° – Centro – CEP: 18147-000 – Caixa Postal: 012 – Araçariguama / SP
Decreto de criação: 1653

Pároco: Padre Daniel Vitor Cardoso Rodrigues

Expediente Paroquial
Segunda-feira a Sexta-feira: das 7h30 às 14h
Sábado: das 8h às 12h e das 13h às 17h
Tel.: (11) 4136-1284 / (11) 94495-1025
E-mail:  paroquiadearacariguama@uol.com.br
''',
                  'Paróquia Santa Catarina de Alexandria': '''
Paróquia Santa Catarina de Alexandria
Rua da Servidão, s/nº – Bairro Dona Catarina – CEP: 18120-000 – Caixa Postal 187 –Mairinque / SP
Decreto de criação: 10/03/2017
Instalação: 11/03/2017

Pároco: Padre Paulo Ferreira Pimentel

Expediente Paroquial
Terça-feira a Sábado: das 9h às 12h e das 13h às 17h
Tel.: (11) 4708-8181
E-mail: matrizsantacatarina@hotmail.com
''',
                  'Paróquia São Francisco de Paula e Virgem Santa Luzia': '''
Paróquia São Francisco de Paula e Virgem Santa Luzia
Av. Senador José Ermírio de Moraes, 747 – Centro – CEP: 18125-000 – Alumínio / SP – Caixa Postal: 59
Decreto de criação: 27/04/1979
Instalação: 23/06/1979

Pároco: Padre Eduardo Aparecido dos Santos

Expediente Paroquial
Segunda-feira a Sexta-feira: das 9h às 17h30
Sábado: das 8h às 12h
Tel.: (11) 4715-2172
E-mail: paroquia.aluminio@outlook.com
Site: www.paroquiasfp.com.br
''',
                  'Paróquia São João Batista | São João Novo': '''
Paróquia São João Batista | São João Novo
Rua Henrique Pinheiro, 35 – Centro – São João Novo – CEP: 18140-004 – São Roque / SP
Decreto de criação: 19/08/2000

Pároco: Padre Tiago dos Santos Teixeira

Expediente Paroquial
Terça-feira e Sexta-feira: das 15h às 19h30
Sábado: das 8h às 12h
Tel.: (11) 4716-3157
E-mail: sjbatista2406@gmail.com
''',
                  'Paróquia São José | Mairinque': '''
Paróquia São José | Mairinque
Praça Dom José Gaspar da Fonseca e Silva, 69 – Centro – CEP: 18120-000 – Mairinque / SP
Decreto de criação: 13/11/1939

Pároco: Padre Alexandre Augusto Siles

Expediente Paroquial
Terça-feira a Sábado: das 9h às 12h e das 14h às 17h
Tel.: (11) 94384-8602
E-mail: saojosemk@gmail.com
''',
                  'Paróquia São Luís Gonzaga': '''
Paróquia São Luís Gonzaga
Av. São Luiz, 755 – Jardim Villaça – CEP: 18135-150 – São Roque / SP
Decreto de criação: 21/09/2005

Pároco: Padre Denis Aparecido Mendes Pereira

Expediente Paroquial
Terça-feira a Sexta-feira: das 10h às 13h e das 14h às 17h
Sábado: das 14h às 18h
Tel.: (11) 2428-1807
E-mail:  secretariasaoluis@outlook.com.br
''',
                  'Paróquia São Roque': '''
Paróquia São Roque
Praça da Matriz, s/n° – Centro – CEP: 18130-330 – São Roque / SP
Decreto de criação: 27/08/1773

Pároco: Padre Adilson Dias Rampaso

Vigário: Padre Daniel Balzan

Expediente Paroquial
Segunda-feira a Quinta-feira: das 9h às 12h e das 13h às 18h
Sexta-feira: das 9h às 12h e das 13h às 17h
Sábado: não há expediente
Tel.: (11) 4712-2377
E-mail: secretariapsr@hotmail.com  | paroquiadesaoroque@hotmail.com
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Itapevi',
                paroquias: {
                  'Paróquia Cristo Rei': '''
Paróquia Cristo Rei
Rua Geraldo Vasques, 01 – Vila Nova Itapevi – CEP: 06694-150 – Itapevi / SP
Decreto de criação: 10/03/1977

Pároco: Padre Edmundo Felix De Los Santos Garcia, MSpS

Expediente Paroquial
Terça-feira a Sexta-feira: das 13h às 17h
Sábado: das 8h às 11h
Tel.: (11) 4141-4125
Email: paroquiacristorei@gmail.com
''',
                  'Paróquia Nossa Senhora Aparecida | Amador Bueno': '''
Paróquia Nossa Senhora Aparecida | Amador Bueno
Rua Mário Antônio de Oliveira, 50 – Amador Bueno – CEP: 06680-520 – Itapevi / SP
Decreto de criação: 12/01/2006
Instalação: 19/02/2006

Pároco: Padre José Cosme de Lima

Vigário Paroquial: Padre Hiago Willian dos Santos Bento

Expediente Paroquial
Terça-feira a Sábado: das 9h30 às 12h e das 13h às 16h30
Tel.: (11) 4144-4572 | WhatsApp: (11) 93041-0779
E-mail: nsaparecidamatriz@gmail.com
''',
                  'Paróquia Nossa Senhora Aparecida | Jandira': '''
Paróquia Nossa Senhora Aparecida | Jandira
Av. Nossa Senhora Aparecida, 68 – Centro – CEP: 06600-100 – Jandira / SP
Decreto de criação: 16/02/1970

Pároco: Padre Franco Mazzoleni, CSF

Vigário Paroquial: Padre Giuseppe Vitari, CSF

Expediente Paroquial
Terça-feira, Quinta-feira e Sexta-feira: das 13h às 19h
Quarta-feira: das 13h às 18h
Sábado: das 13h às 17h
Tel.: (11) 4707-2585
E-mail: nsaparecidajandira@yahoo.com.br
''',
                  'Paróquia Nossa Senhora de Fátima': '''
Paróquia Nossa Senhora de Fátima
Rua Itaguaí, 157 – Jardim Nossa Senhora de Fátima – CEP: 06624-130 – Jandira / SP
Decreto de criação: 03/04/2006

Pároco: Padre Douglas Pinheiro Lima

Vigário Paroquial: Padre Kennedy Robert Ramos dos Santos

A serviço da paróquia:  Padre Daniel Bispo da Cruz

Expediente Paroquial
Segunda-feira a Sexta-feira: das 13h às 17h45
Sábado: das 12h às 18h
Tel.: (11) 4618-0478
E-mail: nsf-65@diocesedeosasco.com.br | pnsdefatima@hotmail.com
''',
                  'Paróquia Nossa Senhora Medianeira de Todas as Graças': '''
Paróquia Nossa Senhora Medianeira de Todas as Graças
Rua André Cavanha, 180 – Engenheiro Cardoso –  CEP: 06654-340 – Itapevi / SP
Decreto de criação: 10/03/1977

Pároco: Padre Arnaldo Balbino dos Santos

Diácono Transitório: Diácono Fábio Luiz Ferreira

Expediente Paroquial
Terça-feira a Sábado: das 9h30 às 12h e das 14h às 18h30
Tel.: (11) 4141-2176
E-mail:  medianeira.paroquia@gmail.com
''',
                  'Paróquia São Francisco de Assis': '''
Paróquia São Francisco de Assis
Rua Marquês de Itanhaém, 133 – Jardim Gabriela III – CEP: 06626-150 – Jandira / SP
Decreto de criação: 02/04/1987

Pároco: Padre Hélio Pedro de Souza

Expediente Paroquial
Rua Francisco José Silveira, 103 – Jardim Rosa Emília
CEP: 06608-300 – Jandira/SP
Terça-feira a Sábado: das 9h às 12h e das 14h às 17h
Tel.: (11) 4789-7247
E-mail: sfa-45@diocesedeosasco.com.br
''',
                  'Paróquia São José': '''
Paróquia São José
Rua Lázaro Toledo de Queiroz, 13A – COHAB I – CEP: 06663-095 – Itapevi / SP
Decreto de criação: 29/04/2016
Instalação: 01/05/2016

Paróco: Padre Pedro Iván Becerra Alba, MSpS

Expediente Paroquial
Terça-feira a Sábado: das 14h às 19h
Tel.: (11) 4205-2015
E-mail: paroquiasaojoseitapevi@gmail.com
Site: www.paroquiasaojoseitapevi.org.br

 
''',
                  'Paróquia São Judas Tadeu | Itapevi': '''
Paróquia São Judas Tadeu | Itapevi
Praça Padre Romeu Mecca, 01 – Centro – CEP: 06653-015 – Itapevi / SP
Decreto de criação: 07/09/1952

Pároco: Padre Ely Rosa

Diácono Transitório: Diácono Vitor Benincasa Borejo

Expediente Paroquial
Terça-feira a Sábado: das 8h às 12h e das 13h às 18h
Tel.: (11) 4141-2051
E-mail:  saojudastadeuitapevi@gmail.com
''',
                },
              ),
              Divider(),
              ParoquiaSetorTile(
                setor: 'Região Ibiúna',
                paroquias: {
                  'Paróquia Bom Jesus e Santa Cruz': '''
Paróquia Bom Jesus e Santa Cruz
Rua Benedito de Moraes Goes, s/n° – Bairro Canguera – CEP: 18145-020 – São Roque / SP
Decreto de criação: 07/11/2012

Pároco: Padre Riomar Aristide da Silva 

Expediente Paroquial
Terça-feira a Sábado: das 13h às 18h
Tel.: (11) 4712-6488
E-mail:   paroquiabomjesus.santacruz@gmail.com
''',
                  'Paróquia Nossa Senhora das Dores': '''
Paróquia Nossa Senhora das Dores
Praça Marechal Deodoro, 9 – Centro – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 27/08/1812

Administrador paroquial: Padre Edileis Silva de Araújo

Vigário Paroquial: Padre Jonathan Paes Ferreira

Expediente Paroquial
Terça-feira a Sexta-Feira: das 8h30 às 11h30 e das 13h00 às 16h30 
Tel | WhatsApp.: (015) 3241-1117
E-mail:  paroquia.nsdores@uol.com.br
''',
                  'Paróquia Nossa Senhora de Guadalupe': '''
Paróquia Nossa Senhora de Guadalupe
Rua França, 17/18 – Residencial Europa – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 10/04/2014

Pároco: Padre Eder Bruno Rodrigues

Vigário Paroquial: Padre Rogério Batista Ramos

Diácono Transitório: Diácono Fábio Luiz Ferreira

Expediente Paroquial
Terça-feira a Sexta–feira: das 9h às 12h e das 13h às 17h
Sábado: das 9h às 15h30
Tel.: (15) 3349-4556 | WhatsApp: (15) 99800-2202
E-mail:   nossasenhoradeguadalupeibiuna@gmail.com
''',
                  'Paróquia Santa Cruz': '''
Paróquia Santa Cruz
Estrada Vicinal Tancredo Neves, Km 11 – Bairro Piaí – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 03/04/2006 
Instalação: 30/04/2006

Pároco: Padre Rafael Santos

Expediente Paroquial
Estrada Vicinal Tancredo Neves, Km 11 – Bairro Piaí
CEP: 18150-000 – Ibiúna / SP
Terça-feira a Sábado: das 13h às 18h
Tel.: (15) 3294-7223 / (15) 99754-1780
E-mail:  santacruz.ibiuna@gmail.com
''',
                  'Paróquia Santa Teresinha e São Roque': '''
Paróquia Santa Teresinha e São Roque
Rua José Carlos Marcicano, 86 – Bairro da Ressaca – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 11/06/2006

Pároco: Padre Edileis Silva de Araújo 

Expediente Paroquial
Terça-feira a Sexta-Feira: das 9h às 12h e das 13h30 às 17h
Sábado: das 9h às 12h e das 13h30 às 16h
Tel.: (15) 3349-1318 / (15) 99829-8734
E-mail:  santateresi@hotmail.com

 
''',
                  'Paróquia São Judas Tadeu': '''
Paróquia São Judas Tadeu
Estrada Vereador Enestino Pires de Oliveira – Km 5 – 110 – CEP: 18150-000 – Ibiúna / SP
Decreto de criação: 20/01/2010

Pároco: Padre Luiz Omar Batista dos Reis 

Expediente Paroquial
Terça a Sexta: das 8h às 12h e das 13h às 17h 
E-mail:  apsaojudastadeu@gmail.com
''',
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParoquiaSetorTile extends StatefulWidget {
  final String setor;
  final Map<String, String> paroquias;

  const ParoquiaSetorTile({Key? key, 
    required this.setor,
    required this.paroquias,
  }) : super(key: key);

  @override
  _ParoquiaSetorTileState createState() => _ParoquiaSetorTileState();
}

class _ParoquiaSetorTileState extends State<ParoquiaSetorTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.setor,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (_expanded)
          Column(
            children: widget.paroquias.entries.map((entry) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(entry.key),
                  onTap: () {
                    _showParoquiaInfo(context, entry.value);
                  },
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _showParoquiaInfo(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informação da Paróquia'),
          content: Text(text),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
