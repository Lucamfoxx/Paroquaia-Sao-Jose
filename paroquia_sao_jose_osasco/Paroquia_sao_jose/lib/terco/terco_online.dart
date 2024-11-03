import 'package:flutter/material.dart';
import 'rosary_builder.dart'; // Função para construir o rosário
import 'como_rezar.dart'; // Tela "Como Rezar"
import 'misterios.dart'; // Tela "Mistérios"

class TercoOlinePage extends StatefulWidget {
  @override
  _TercoOlinePageState createState() => _TercoOlinePageState();
}

class _TercoOlinePageState extends State<TercoOlinePage> {
  int _currentIndex = 0;
  int _pageKey = 0; // Key para forçar a recriação da página

  final List<Widget> _pages = [
    RosaryPage(),
    ComoRezarPage(),
    MisteriosPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _resetPage() {
    setState(() {
      _currentIndex = 0; // Retorna ao primeiro índice
      _pageKey++; // Incrementa a key para recriar a página
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terço"),
        backgroundColor: Color.fromARGB(255, 148, 203, 252),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetPage,
            tooltip: 'Reiniciar Página',
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 198, 221, 242),
      body: IndexedStack(
        key: ValueKey(_pageKey), // Recria o IndexedStack ao alterar a key
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Color.fromARGB(255, 198, 221, 242),
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 76, 76, 76),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Terço",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Como Rezar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Mistérios",
          ),
        ],
      ),
    );
  }
}
