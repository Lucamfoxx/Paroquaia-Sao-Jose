import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'extensions.dart';

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

  // Variáveis para status de lido e favorito
  bool _isRead = false;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fileName = widget.fileName;
    _content = widget.content;
    _livro = widget.livro;
    _grade = widget.grade;
    _loadComments();
    _loadStatus();
  }

  Future<void> _loadComments() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File file = File('${directory.path}/comments.json');

    if (await file.exists()) {
      List<dynamic> allComments = json.decode(await file.readAsString());
      setState(() {
        comments = allComments
            .where((comment) =>
                comment['livro'] == _livro && comment['grade'] == _grade)
            .toList();
      });
    }
  }

  Future<void> _loadStatus() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File readFile = File('${directory.path}/read_chapters.json');
    File favFile = File('${directory.path}/favorites.json');
    List<dynamic> readChapters = [];
    List<dynamic> favorites = [];
    if (await readFile.exists()) {
      readChapters = json.decode(await readFile.readAsString());
    }
    if (await favFile.exists()) {
      favorites = json.decode(await favFile.readAsString());
    }
    setState(() {
      _isRead = readChapters
          .any((item) => item['livro'] == _livro && item['grade'] == _grade);
      _isFavorite = favorites
          .any((item) => item['livro'] == _livro && item['grade'] == _grade);
    });
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

  Future<void> _toggleReadStatus() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File readFile = File('${directory.path}/read_chapters.json');
    List<dynamic> readChapters = [];
    if (await readFile.exists()) {
      readChapters = json.decode(await readFile.readAsString());
    }
    if (_isRead) {
      readChapters.removeWhere(
          (item) => item['livro'] == _livro && item['grade'] == _grade);
    } else {
      readChapters.add({'livro': _livro, 'grade': _grade});
    }
    await readFile.writeAsString(json.encode(readChapters));
    setState(() {
      _isRead = !_isRead;
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File favFile = File('${directory.path}/favorites.json');
    List<dynamic> favorites = [];
    if (await favFile.exists()) {
      favorites = json.decode(await favFile.readAsString());
    }
    if (_isFavorite) {
      favorites.removeWhere(
          (item) => item['livro'] == _livro && item['grade'] == _grade);
    } else {
      favorites.add({'livro': _livro, 'grade': _grade});
    }
    await favFile.writeAsString(json.encode(favorites));
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_fileName),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _grade > 1
                ? () {
                    _loadChapterText(_grade - 1);
                    _scrollToTop();
                  }
                : null,
          ),
          IconButton(
            icon: _isRead
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank),
            onPressed: _toggleReadStatus,
          ),
          IconButton(
            icon: _isFavorite ? Icon(Icons.star) : Icon(Icons.star_border),
            onPressed: _toggleFavoriteStatus,
          ),
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
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
                      decoration:
                          InputDecoration(hintText: 'Digite seu comentário'),
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
