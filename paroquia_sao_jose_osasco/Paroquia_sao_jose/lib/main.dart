import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'missa_diaria.dart';
import 'biblia.dart';
import 'santo_do_dia.dart';
import 'oracoes.dart';
import 'paroquias.dart';
import 'noticias.dart';
import 'inscricoes.dart';
import 'horarios.dart';
import 'historiaparoquia.dart';
import 'inscricoes/inscricoes_batismo.dart';
import 'inscricoes/inscricoes_batismo_adult.dart';
import 'inscricoes/inscricoes_catequese_adulto.dart';
import 'inscricoes/inscricoes_casamento.dart';
import 'missas_intencoes.dart';
import 'missas/pedido_missas.dart';
import 'missas/pedido_intencoes.dart';
import 'santo_padroeiro.dart';
import 'sacramentos.dart';
import 'inscricoes/inscricoes_catequese_jovem.dart';
import 'inscricoes/inscricoes_catequese_infantil.dart';
import 'inscricoes/dizimista.dart';
import 'dizimosdoacoes.dart';
import 'preparacao.dart';
import 'terco/terco_online.dart';
import 'festas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('pt_BR', null); // Adiciona esta linha
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paróquia São José',
      theme:
          ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 0, 63, 117)),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/missa_diaria': (context) => MissaDiariaPage(),
        '/biblia': (context) => BibliaPage(),
        '/santo_do_dia': (context) => SantoDoDiaPage(),
        '/oracoes': (context) => OracoesPage(),
        '/paroquias': (context) => ParoquiasPage(),
        '/noticias': (context) => NoticiasPage(),
        '/horarios': (context) => HorariosPage(),
        '/historiaparoquia': (context) => HistoriaParoquiaPage(),
        '/inscricoes': (context) => InscricoesPage(),
        '/inscricoes_catequese': (context) => InscricoesCatequeseAdultoPage(),
        '/inscricoes_catequese_infantil': (context) => CatequeseInfantilPage(),
        '/inscricoes_catequese_jovem': (context) => CatequeseJovemPage(),
        '/inscricoes_batismo': (context) => InscricoesBatismoPage(),
        '/inscricoes_batismo_adult': (context) => InscricoesBatismoAdultPage(),
        '/inscricoes_casamento': (context) => InscricoesCasamentoPage(),
        '/missas_intencoes': (context) => MissasIntencoesPage(),
        '/pedido_missas': (context) => PedidoMissasPage(),
        '/pedido_intencoes': (context) => PedidoIntencoesPage(),
        '/santo_padroeiro': (context) => SaoJosePage(),
        '/sacramentos': (context) => SacramentosPage(),
        '/dizimista': (context) => DizimistaPage(),
        '/dizimosdoacoes': (context) => DoacoesPage(),
        '/terco_online': (context) => TercoOlinePage(),
        '/preparacaobatismo': (context) => PreparacaoPage(),
        '/festas': (context) => FestasPage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: precacheImage(AssetImage('assets/logo.png'), context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MissaDiariaApp();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MissaDiariaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paróquia São José'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                SizedBox(height: 20),
                MenuButton('Inscrições', '/inscricoes'),
                MenuButton('Missas e Intenções', '/missas_intencoes'),
                MenuButton('Dízimo e Doações', '/dizimosdoacoes'),
                MenuButton('Terço', '/terco_online'),
                MenuButton('Eventos', '/festas'),
                MenuButton('Santo Padroeiro', '/santo_padroeiro'),
                MenuButton('Sacramentos', '/sacramentos'),
                MenuButton('Liturgia Diária', '/missa_diaria'),
                MenuButton('Bíblia', '/biblia'),
                MenuButton('Santo do Dia', '/santo_do_dia'),
                MenuButton('Orações', '/oracoes'),
                MenuButton('Dioceses', '/paroquias'),
                MenuButton('Avisos Paroquiais', '/noticias'),
                MenuButton('Horários', '/horarios'),
                MenuButton('História da Paróquia', '/historiaparoquia'),
                SizedBox(height: 20),
                ContactInfo(),
              ],
            ),
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

class ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/sao_jose_logo.jpg', // Caminho para a imagem logo2.png
          fit: BoxFit.fill, // Preenche toda a área disponível
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            launch("https://www.instagram.com/paroquiasaojoseosasco/");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/insta.png', // Caminho para o ícone do WhatsApp personalizado
                width: 25, // Largura do ícone
                height: 25, // Altura do ícone
                color: Color.fromARGB(255, 255, 255, 255), // Cor do ícone
              ),
              SizedBox(width: 5),
              Text(
                "@paroquiasaojoseosasco",
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            launch(
                "tel://+551136868961"); // Abre o aplicativo de telefone com o número específico
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone,
                  color: const Color.fromARGB(255, 248, 252, 255)),
              SizedBox(width: 5),
              Text(
                "Telefone: (11) 3686-8961",
                style: TextStyle(
                  color: const Color.fromARGB(255, 248, 252, 255),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            launch("https://wa.me/5511989369413");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/whatsapp1.png', // Caminho para o ícone do WhatsApp personalizado
                width: 36, // Largura do ícone
                height: 36, // Altura do ícone
                color: Colors.green, // Cor do ícone
              ),
              SizedBox(width: 5),
              Text(
                "(11) 98936-9413",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        InkWell(
          onTap: () {
            launch(
                "https://maps.app.goo.gl/m9qhWyEBwzbJWFqf6"); // Abre o endereço no Google Maps
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on,
                  color: const Color.fromARGB(255, 246, 251, 255)),
              SizedBox(width: 5),
              Text(
                '''
Paróquia São José 
Rua Francisco Haro Alaminos, 80 
Vila São José Osasco / SP
''',
                style: TextStyle(
                  color: const Color.fromARGB(255, 246, 251, 255),
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SocialLink extends StatelessWidget {
  final String url;
  final String? iconPath;
  final Icon? icon;
  final String label;
  final Color? iconColor;

  SocialLink({
    required this.url,
    required this.label,
    this.iconPath,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launch(url),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconPath != null)
            Image.asset(
              iconPath!,
              width: 25,
              height: 25,
              color: iconColor ?? Colors.black,
            )
          else if (icon != null)
            icon!,
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
