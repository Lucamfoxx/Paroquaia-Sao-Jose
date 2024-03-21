import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'missa_diaria.dart';
import 'salmos.dart';
import 'biblia.dart';
import 'santo_do_dia.dart';
import 'oracoes.dart';
import 'paroquias.dart';
import 'proverbios.dart';
import 'noticias.dart';
import 'salmo_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'horarios.dart'; // Importação da página horarios.dart
import 'historiaparoquia.dart';
import 'package:url_launcher/url_launcher.dart'; // Importação do url_launcher para abrir links
 // Importação da página historiaparoquia.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paróquia São José',
      theme: ThemeData(
        scaffoldBackgroundColor:Color.fromARGB(255, 0, 63, 117)
,
      
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder(
          future: precacheImage(AssetImage('assets/logo.png'), context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MissaDiariaApp();
            } else {
              return Container();
            }
          },
        ),
        '/missa_diaria': (context) => MissaDiariaPage(),
        '/salmos': (context) => SalmosPage(),
        '/biblia': (context) => BibliaPage(),
        '/santo_do_dia': (context) => SantoDoDiaPage(),
        '/oracoes': (context) => OracoesPage(),
        '/paroquias': (context) => ParoquiasPage(),
        '/proverbios': (context) => ProverbiosPage(proverbioNumber: 1),
        '/salmo_layout': (context) => SalmoPage(salmoNumber: 1),
        for (int i = 1; i <= 150; i++)
          '/salmo_$i': (context) => SalmoPage(salmoNumber: i),
        '/noticias': (context) => NoticiasPage(),
        '/horarios': (context) => HorariosPage(), // Rota para a página horarios.dart
        '/historiaparoquia': (context) => HistoriaParoquiaPage(), // Rota para a página historiaparoquia.dart
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
                MenuButton('Liturgia Diária', '/missa_diaria'),
                MenuButton('Salmos', '/salmos'),
                MenuButton('Bíblia', '/biblia'),
                MenuButton('Santo do Dia', '/santo_do_dia'),
                MenuButton('Orações', '/oracoes'),
                MenuButton('Dioceses', '/paroquias'),
                MenuButton('Provérbios', '/proverbios'),
                MenuButton('Notícias', '/noticias'),
                MenuButton('Horários', '/horarios'), // Botão para Horários
                MenuButton('História da Paróquia', '/historiaparoquia'), // Botão para História da Paróquia
                SizedBox(height: 20), // Adiciona um espaço entre o menu e o texto com o endereço e telefone
                ContactInfo(), // Adiciona o widget com as informações de contato
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
        color: Color.fromARGB(255, 148, 203, 252)

,
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
        InkWell(
          onTap: () {
            launch("tel://1132912400"); // Abre o aplicativo de telefone com o número específico
          },
          child: Text(
            "Telefone: (11) 3686-8961",
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            launch("https://maps.app.goo.gl/m9qhWyEBwzbJWFqf6"); // Abre o endereço no Google Maps
          },
          child: Text('''
Paróquia São José
Rua Francisco Haro Alaminos, 80 – Vila São José – CEP: 06290-050 – Osasco / SP
''',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}