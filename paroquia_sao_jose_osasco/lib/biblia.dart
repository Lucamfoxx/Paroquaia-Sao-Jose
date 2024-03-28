import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(
    home: BibliaPage(),
  ));
}

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

  @override
  void initState() {
    super.initState();
    _velhoTestamentoExpanded = false;
    _novoTestamentoExpanded = false;
    _loadData();
  }

  Future<void> _loadData() async {
    final limitesGradeJsonString = await rootBundle.loadString('assets/mapas/limites_grade.json');
    final menuTitlesJsonString = await rootBundle.loadString('assets/mapas/menu_titles.json');
    final limitesGradeNovoJsonString = await rootBundle.loadString('assets/mapas/limites_grade_novo.json');
    final menuNovoJsonString = await rootBundle.loadString('assets/mapas/menu_novo.json');

    setState(() {
      limitesGrade = Map<String, int>.from(json.decode(limitesGradeJsonString));
      menuTitles = Map<String, String>.from(json.decode(menuTitlesJsonString));
      limitesGradeNovo = Map<String, int>.from(json.decode(limitesGradeNovoJsonString));
      menuNovo = Map<String, String>.from(json.decode(menuNovoJsonString));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bíblia'),
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
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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

  Widget _buildBookItem(String livro, Map<String, int> limites, Map<String, String> menu) {
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

  void _openBook(String livro, Map<String, int> limites, Map<String, String> menu) {
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
                    _openChapter(livro, grade);
                  },
                  child: Container(
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
    String livroCapitulo = "${menuTitles[livro] ?? livro.replaceAll('_', ' ').capitalize()} $grade";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChapterPage(fileName: livroCapitulo, content: content, livro: livro, grade: grade),
      ),
    );
  }
}

class ChapterPage extends StatefulWidget {
  final String fileName;
  final String content;
  final String livro;
  final int grade;

  const ChapterPage({
    Key? key,
    required this.fileName,
    required this.content,
    required this.livro,
    required this.grade,
  }) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  double _fontSize = 16.0;
  List<dynamic> comments = [];
  late String _fileName;
  late String _content;
  late String _livro;
  late int _grade;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fileName = widget.fileName;
    _content = widget.content;
    _livro = widget.livro;
    _grade = widget.grade;
    _loadComments();
  }

  Future<void> _loadComments() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/comments.json');

    if (await file.exists()) {
      List<dynamic> allComments = json.decode(await file.readAsString());
      setState(() {
        comments = allComments.where((comment) => comment['livro'] == _livro && comment['grade'] == _grade).toList();
      });
    }
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 1.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 8.0) {
        _fontSize -= 1.0;
      }
    });
  }

  void _saveComment(String comentario) async {
    if (comentario.isNotEmpty) {
      final Map<String, dynamic> commentMap = {
        "fileName": _fileName,
        "content": _content,
        "livro": _livro,
        "grade": _grade,
        "comentario": comentario,
      };

      _writeCommentToJson(commentMap);
    }
  }

  void _writeCommentToJson(Map<String, dynamic> commentMap) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/comments.json');

    List<dynamic> allComments = [];

    if (await file.exists()) {
      allComments = json.decode(await file.readAsString());
    }

    allComments.add(commentMap);
    await file.writeAsString(json.encode(allComments));

    _loadComments();
  }

  void _deleteComment(int index) async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/comments.json');

    List<dynamic> allComments = [];

    if (await file.exists()) {
      allComments = json.decode(await file.readAsString());
    }

    allComments.removeAt(index);
    await file.writeAsString(json.encode(allComments));

    _loadComments();
  }

  void _loadChapterText(int chapter) async {
    String nextFileName = 'assets/biblia/Testamentos/${_livro}_$chapter.txt';
    String nextContent = await rootBundle.loadString(nextFileName);
    String nextChapterName = "${_livro.capitalize()} $chapter";

    setState(() {
      _fileName = nextChapterName;
      _content = nextContent;
      _grade = chapter;
    });

    _loadComments();

    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_fileName),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _grade > 1 ? () {
              _loadChapterText(_grade - 1);
              _scrollToTop();
            } : null,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _loadChapterText(_grade + 1);
              _scrollToTop();
            },
          ),
          IconButton(
            icon: Icon(Icons.comment),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String comentario = '';

                  return AlertDialog(
                    title: Text('Adicionar Comentário'),
                    content: TextField(
                      onChanged: (value) {
                        comentario = value;
                      },
                      decoration: InputDecoration(hintText: 'Digite seu comentário'),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Salvar'),
                        onPressed: () {
                          _saveComment(comentario);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Text(
                _content,
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Comentários:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (comments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments.asMap().entries.map<Widget>((entry) {
                  int index = entry.key;
                  dynamic comment = entry.value;
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(comment['comentario']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteComment(index);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            if (comments.isEmpty)
              Text(
                'Nenhum comentário disponível.',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}

