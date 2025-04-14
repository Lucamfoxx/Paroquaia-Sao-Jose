import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'extensions.dart';
import 'chapter_page.dart';

class BibliaPage extends StatefulWidget {
  @override
  _BibliaPageState createState() => _BibliaPageState();
}

class _BibliaPageState extends State<BibliaPage> {
  late bool _velhoTestamentoExpanded;
  late bool _novoTestamentoExpanded;
  late Map<String, int> limitesGrade;
  late Map<String, String> menuTitles;
  late Map<String, int> limitesGradeNovo;
  late Map<String, String> menuNovo;

  // Variáveis para favoritos e capítulos lidos
  List<dynamic> _favorites = [];
  List<dynamic> _readChapters = [];

  @override
  void initState() {
    super.initState();
    _velhoTestamentoExpanded = false;
    _novoTestamentoExpanded = false;
    _loadData();
    _loadFavorites();
    _loadReadChapters();
  }

  Future<void> _loadData() async {
    final limitesGradeJsonString =
        await rootBundle.loadString('assets/mapas/limites_grade.json');
    final menuTitlesJsonString =
        await rootBundle.loadString('assets/mapas/menu_titles.json');
    final limitesGradeNovoJsonString =
        await rootBundle.loadString('assets/mapas/limites_grade_novo.json');
    final menuNovoJsonString =
        await rootBundle.loadString('assets/mapas/menu_novo.json');

    setState(() {
      limitesGrade = Map<String, int>.from(json.decode(limitesGradeJsonString));
      menuTitles = Map<String, String>.from(json.decode(menuTitlesJsonString));
      limitesGradeNovo =
          Map<String, int>.from(json.decode(limitesGradeNovoJsonString));
      menuNovo = Map<String, String>.from(json.decode(menuNovoJsonString));
    });
  }

  Future<void> _loadFavorites() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/favorites.json');
    if (await file.exists()) {
      String content = await file.readAsString();
      setState(() {
        _favorites = json.decode(content);
      });
    } else {
      setState(() {
        _favorites = [];
      });
    }
  }

  Future<void> _loadReadChapters() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/read_chapters.json');
    if (await file.exists()) {
      String content = await file.readAsString();
      setState(() {
        _readChapters = json.decode(content);
      });
    } else {
      setState(() {
        _readChapters = [];
      });
    }
  }

  bool _isChapterRead(String livro, int grade) {
    return _readChapters
        .any((item) => item['livro'] == livro && item['grade'] == grade);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bíblia'),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            onPressed: _showFavoritesDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 148, 203, 252),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _velhoTestamentoExpanded = !_velhoTestamentoExpanded;
                    _novoTestamentoExpanded = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Velho Testamento',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            if (_velhoTestamentoExpanded)
              Column(
                children: limitesGrade.keys.map((livro) {
                  return _buildBookItem(livro, limitesGrade, menuTitles);
                }).toList(),
              ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 148, 203, 252),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _novoTestamentoExpanded = !_novoTestamentoExpanded;
                    _velhoTestamentoExpanded = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Novo Testamento',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            if (_novoTestamentoExpanded)
              Column(
                children: limitesGradeNovo.keys.map((livro) {
                  return _buildBookItem(livro, limitesGradeNovo, menuNovo);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookItem(
      String livro, Map<String, int> limites, Map<String, String> menu) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 202, 227, 249),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(menu[livro] ?? livro.replaceAll('_', ' ').capitalize()),
        onTap: () {
          _openBook(livro, limites, menu);
        },
      ),
    );
  }

  void _openBook(
      String livro, Map<String, int> limites, Map<String, String> menu) {
    int limiteGrade = limites[livro] ?? 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1,
              ),
              itemCount: limiteGrade,
              itemBuilder: (BuildContext context, int index) {
                int grade = index + 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _openChapter(livro, grade);
                  },
                  child: Stack(
                    children: [
                      Container(
                        color: Color.fromARGB(255, 148, 203, 252),
                        child: Center(
                          child: Text(
                            grade.toString(),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (_isChapterRead(livro, grade))
                        Positioned(
                          top: 4,
                          right: 4,
                          child:
                              Icon(Icons.check, size: 16, color: Colors.green),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _openChapter(String livro, int grade) async {
    String fileName = 'assets/biblia/Testamentos/${livro}_${grade}.txt';
    String content = await rootBundle.loadString(fileName);
    String livroCapitulo =
        "${menuTitles[livro] ?? livro.replaceAll('_', ' ').capitalize()} $grade";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChapterPage(
            fileName: livroCapitulo,
            content: content,
            livro: livro,
            grade: grade),
      ),
    ).then((value) {
      _loadReadChapters();
      _loadFavorites();
    });
  }

  void _showFavoritesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Favoritos'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final fav = _favorites[index];
                String displayName = fav['livro'];
                if (menuTitles.containsKey(fav['livro'])) {
                  displayName = menuTitles[fav['livro']]!;
                } else if (menuNovo.containsKey(fav['livro'])) {
                  displayName = menuNovo[fav['livro']]!;
                } else {
                  displayName = fav['livro'].replaceAll('_', ' ').capitalize();
                }
                return ListTile(
                  title: Text('$displayName ${fav['grade']}'),
                  onTap: () {
                    Navigator.pop(context);
                    _openChapter(fav['livro'], fav['grade']);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
