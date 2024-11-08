import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:path_provider/path_provider.dart';

class MissaDiariaPage extends StatefulWidget {
  const MissaDiariaPage({Key? key}) : super(key: key);

  @override
  _MissaDiariaPageState createState() => _MissaDiariaPageState();
}

class _MissaDiariaPageState extends State<MissaDiariaPage> {
  List<Map<String, String>> _missaDiariaParts = [
    {'title': '', 'content': 'Carregando...'}
  ];
  double _fontSize = 16.0;
  late DateTime _selectedDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadCachedContent(_selectedDate);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadCachedContent(DateTime date) async {
    try {
      final content = await _readContentFromFile(date);
      if (content != null) {
        setState(() {
          _missaDiariaParts = _processContent(content);
        });
      } else {
        await _fetchAndSaveMissaDiariaContent(date);
      }
    } catch (e) {
      print('Erro ao carregar conteúdo do cache: $e');
    }
  }

  Future<void> _fetchAndSaveMissaDiariaContent(DateTime date) async {
    final url =
        'https://www.vaticannews.va/pt/palavra-do-dia/${date.year}/${_formatTwoDigits(date.month)}/${_formatTwoDigits(date.day)}.html';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final content = _extractTextBetweenSequences(
            document.body, 'Leitura do Dia', 'Palavras do Santo Padre');
        if (content != null) {
          setState(() {
            _missaDiariaParts = _processContent(content);
          });
          await _saveContentToFile(content, date);
        } else {
          setState(() {
            _missaDiariaParts = [
              {'title': '', 'content': 'Conteúdo não encontrado.'}
            ];
          });
        }
      } else {
        setState(() {
          _missaDiariaParts = [
            {'title': '', 'content': 'Falha ao carregar o conteúdo.'}
          ];
        });
      }
    } catch (e) {
      setState(() {
        _missaDiariaParts = [
          {'title': '', 'content': 'Erro: $e'}
        ];
      });
    }
  }

  Future<void> _saveContentToFile(String content, DateTime date) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dirPath = '${directory.path}/assets';
      final dir = Directory(dirPath);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      final file = File('$dirPath/${_formatDate(date)}.txt');
      await file.writeAsString(content);
    } catch (e) {
      print('Erro ao salvar o arquivo: $e');
    }
  }

  Future<String?> _readContentFromFile(DateTime date) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/assets/${_formatDate(date)}.txt');
      if (file.existsSync()) {
        return await file.readAsString();
      }
    } catch (e) {
      print('Erro ao ler o arquivo: $e');
    }
    return null;
  }

  String? _extractTextBetweenSequences(
      dom.Element? body, String startSequence, String endSequence) {
    if (body == null) return null;
    final text = body.text;
    final startIndex = text.indexOf(startSequence);
    final endIndex = text.indexOf(endSequence, startIndex);
    if (startIndex != -1 && endIndex != -1) {
      return text.substring(startIndex + startSequence.length, endIndex);
    } else {
      return null;
    }
  }

  List<Map<String, String>> _processContent(String content) {
    List<Map<String, String>> parts = [];

    // Encontrar as posições das palavras-chave
    int leituraIndex = content.indexOf('Primeira leitura');
    if (leituraIndex == -1) {
      // Se 'Primeira leitura' não for encontrado, procurar por 'Leitura'
      leituraIndex = content.indexOf('Leitura');
    }

    final salmoIndex = content.indexOf('Salmo Responsorial');
    final segundaLeituraIndex = content.indexOf('Segunda leitura');
    final evangelhoIndex = content.indexOf('Evangelho do Dia');
    final palavrasSantoPadreIndex = content.indexOf('Palavras do Santo Padre');

    // Processar Primeira Leitura
    if (leituraIndex != -1) {
      int endLeitura = content.length;

      if (salmoIndex != -1 && salmoIndex > leituraIndex) {
        endLeitura = salmoIndex;
      } else if (segundaLeituraIndex != -1 &&
          segundaLeituraIndex > leituraIndex) {
        endLeitura = segundaLeituraIndex;
      } else if (evangelhoIndex != -1 && evangelhoIndex > leituraIndex) {
        endLeitura = evangelhoIndex;
      }

      parts.add({
        'title': 'Primeira Leitura',
        'content': content.substring(leituraIndex, endLeitura).trim()
      });
    }

    // Processar Salmo Responsorial
    if (salmoIndex != -1) {
      int endSalmo = content.length;

      if (segundaLeituraIndex != -1 && segundaLeituraIndex > salmoIndex) {
        endSalmo = segundaLeituraIndex;
      } else if (evangelhoIndex != -1 && evangelhoIndex > salmoIndex) {
        endSalmo = evangelhoIndex;
      }

      parts.add({
        'title': 'Salmo Responsorial',
        'content': content.substring(salmoIndex, endSalmo).trim()
      });
    }

    // Processar Segunda Leitura, se existir
    if (segundaLeituraIndex != -1) {
      int endSegundaLeitura = content.length;

      if (evangelhoIndex != -1 && evangelhoIndex > segundaLeituraIndex) {
        endSegundaLeitura = evangelhoIndex;
      }

      parts.add({
        'title': 'Segunda Leitura',
        'content':
            content.substring(segundaLeituraIndex, endSegundaLeitura).trim()
      });
    }

    // Processar Evangelho do Dia
    if (evangelhoIndex != -1) {
      int endEvangelho = content.length;

      if (palavrasSantoPadreIndex != -1 &&
          palavrasSantoPadreIndex > evangelhoIndex) {
        endEvangelho = palavrasSantoPadreIndex;
      }

      parts.add({
        'title': 'Evangelho',
        'content': content.substring(evangelhoIndex, endEvangelho).trim()
      });
    }

    return parts;
  }

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
        title: const Text('Liturgia Diaria'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final selectedDate = await _selectDate(context);
              if (selectedDate != null) {
                setState(() {
                  _selectedDate = selectedDate;
                });
                await _loadCachedContent(_selectedDate);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _missaDiariaParts.length,
                    itemBuilder: (BuildContext context, int index) {
                      String buttonText = _missaDiariaParts[index]['title'] ??
                          'Parte ${index + 1}';

                      return ExpansionTile(
                        title: Text(buttonText),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _missaDiariaParts[index]['content'] ?? '',
                              style: TextStyle(
                                fontSize: _fontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  String _formatDate(DateTime date) {
    return '${date.year}_${_formatTwoDigits(date.month)}_${_formatTwoDigits(date.day)}';
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final currentDate = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 1, 1, 1),
      lastDate: DateTime(currentDate.year + 1, 12, 31),
    );
  }
}
