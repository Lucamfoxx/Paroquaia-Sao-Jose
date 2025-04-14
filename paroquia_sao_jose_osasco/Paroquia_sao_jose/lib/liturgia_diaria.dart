import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MissaDiariaPage extends StatefulWidget {
  const MissaDiariaPage({Key? key}) : super(key: key);

  @override
  _MissaDiariaPageState createState() => _MissaDiariaPageState();
}

class _MissaDiariaPageState extends State<MissaDiariaPage> {
  // Lista fixa com os títulos esperados para as seções.
  final List<String> sectionTitles = [
    'Primeira Leitura',
    'Salmo Responsorial',
    'Segunda Leitura',
    'Evangelho'
  ];

  // Cada entrada será um mapa com as chaves 'title' e 'content'
  List<Map<String, String>> _missaDiariaParts = [];
  double _fontSize = 16.0;
  late DateTime _selectedDate;
  late ScrollController _scrollController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _scrollController = ScrollController();
    // Se necessário, limpar cache na primeira vez após atualização
    _resetCacheIfNeeded().then((_) => _loadContent(_selectedDate));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _resetCacheIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('liturgiaCacheCleared')) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final dirPath = '${directory.path}/assets';
        final dir = Directory(dirPath);
        if (await dir.exists()) {
          await dir.delete(recursive: true);
          print('Cache limpo.');
        }
      } catch (e) {
        print('Erro ao limpar o cache: $e');
      }
      await prefs.setBool('liturgiaCacheCleared', true);
    }
  }

  Future<void> _loadContent(DateTime date) async {
    // Tenta ler todas as seções da pasta da data
    final parts = await _readSectionsFromFolder(date);
    if (parts != null) {
      setState(() {
        _missaDiariaParts = parts;
        _isLoading = false;
      });
    } else {
      await _fetchAndSaveContent(date);
    }
  }

  Future<void> _fetchAndSaveContent(DateTime date) async {
    final url =
        'https://pocketterco.com.br/liturgia/${date.day}/${_formatTwoDigits(date.month)}/${date.year}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        // Extrai parágrafos e junta com duas quebras de linha
        final paragraphs = document
            .getElementsByTagName('p')
            .map((e) => e.text.trim())
            .where((text) => text.isNotEmpty)
            .toList();
        final fullText = paragraphs.join("\n\n");

        bool hasSegundaLeitura =
            fullText.toLowerCase().contains('segunda leitura');

        Map<String, RegExp?> patterns = {
          'Primeira Leitura': RegExp(
            r"Primeira Leitura.*?(?=Salmo Responsorial)",
            dotAll: true,
            caseSensitive: false,
          ),
          'Salmo Responsorial': hasSegundaLeitura
              ? RegExp(
                  r"Salmo Responsorial.*?(?=Segunda Leitura)",
                  dotAll: true,
                  caseSensitive: false,
                )
              : RegExp(
                  r"Salmo Responsorial.*?(?=Evangelho)",
                  dotAll: true,
                  caseSensitive: false,
                ),
          'Segunda Leitura': hasSegundaLeitura
              ? RegExp(
                  r"Segunda Leitura.*?(?=Evangelho)",
                  dotAll: true,
                  caseSensitive: false,
                )
              : null,
          'Evangelho': RegExp(r"Evangelho.*?— Glória a vós, Senhor\.",
              dotAll: true, caseSensitive: false),
        };

        Map<String, String> extracted = {};
        for (var title in sectionTitles) {
          final regExp = patterns[title];
          String content;
          if (regExp != null) {
            final match = regExp.firstMatch(fullText);
            if (match != null) {
              content = match.group(0)?.trim() ?? '';
            } else {
              content = 'Conteúdo não encontrado para $title.';
            }
          } else {
            content = 'Seção não disponível.';
          }
          // Para o Evangelho, garante que termine com “— Glória a vós, Senhor.”
          if (title == 'Evangelho') {
            final gloria = '— Glória a vós, Senhor.';
            if (!content.endsWith(gloria)) {
              content = content.trim() + '\n\n' + gloria;
            }
          }
          extracted[title] = content;
        }

        // Salva cada seção em um arquivo individual e monta a lista de partes.
        List<Map<String, String>> parts = [];
        for (var title in sectionTitles) {
          final content = extracted[title] ?? '';
          await _saveSectionToFolder(title, content, date);
          parts.add({'title': title, 'content': content});
        }
        setState(() {
          _missaDiariaParts = parts;
          _isLoading = false;
        });
      } else {
        setState(() {
          _missaDiariaParts = [
            {'title': '', 'content': 'Falha ao carregar o conteúdo.'}
          ];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _missaDiariaParts = [
          {'title': '', 'content': 'Erro: $e'}
        ];
        _isLoading = false;
      });
    }
  }

  // Salva uma seção em um arquivo individual dentro de uma pasta com a data.
  Future<void> _saveSectionToFolder(
      String section, String content, DateTime date) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folderPath = '${directory.path}/assets/${_formatDate(date)}';
      final folder = Directory(folderPath);
      if (!folder.existsSync()) {
        folder.createSync(recursive: true);
      }
      final fileName = section.replaceAll(" ", "") + '.txt';
      final file = File('$folderPath/$fileName');
      await file.writeAsString(content);
    } catch (e) {
      print('Erro ao salvar a seção $section: $e');
    }
  }

  // Tenta ler todas as seções salvas na pasta para a data informada.
  Future<List<Map<String, String>>?> _readSectionsFromFolder(
      DateTime date) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final folderPath = '${directory.path}/assets/${_formatDate(date)}';
      final folder = Directory(folderPath);
      if (!folder.existsSync()) return null;
      List<Map<String, String>> parts = [];
      for (var title in sectionTitles) {
        final fileName = title.replaceAll(" ", "") + '.txt';
        final file = File('$folderPath/$fileName');
        if (file.existsSync()) {
          final content = await file.readAsString();
          parts.add({'title': title, 'content': content});
        } else {
          // Se algum arquivo não existir, retorna null para forçar webscraping.
          return null;
        }
      }
      return parts;
    } catch (e) {
      print('Erro ao ler as seções da pasta: $e');
      return null;
    }
  }

  String _formatTwoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  String _formatDate(DateTime date) {
    return '${date.year}_${_formatTwoDigits(date.month)}_${_formatTwoDigits(date.day)}';
  }

  List<InlineSpan> _buildFormattedText(String text, double fontSize) {
    final List<InlineSpan> spans = [];
    final RegExp regExp = RegExp(r'(\d+)|([^\d]+)');
    final matches = regExp.allMatches(text);

    for (final match in matches) {
      final number = match.group(1);
      final nonNumber = match.group(2);
      if (number != null) {
        spans.add(WidgetSpan(
          child: Transform.translate(
            offset: const Offset(1.5, -6),
            child: Text(
              number,
              textScaleFactor: 0.7,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
              ),
            ),
          ),
        ));
      } else if (nonNumber != null) {
        spans.add(TextSpan(text: nonNumber));
      }
    }
    return spans;
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

  Future<DateTime?> _selectDate(BuildContext context) async {
    final currentDate = DateTime.now();
    return await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(currentDate.year - 1, 1, 1),
      lastDate: DateTime(currentDate.year + 1, 12, 31),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as partes para remover a "Segunda Leitura" se ela estiver marcada como "Seção não disponível."
    final filteredParts = _missaDiariaParts.where((part) {
      return !(part['title'] == 'Segunda Leitura' &&
          part['content']!.contains('Seção não disponível.'));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liturgia Diária'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final selectedDate = await _selectDate(context);
              if (selectedDate != null) {
                setState(() {
                  _selectedDate = selectedDate;
                });
                await _loadContent(_selectedDate);
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exibe a data selecionada
                        Text(
                          DateFormat('dd/MM/yyyy').format(_selectedDate),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Exibe cada seção como uma ExpansionTile
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredParts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final title = filteredParts[index]['title'] ??
                                'Parte ${index + 1}';
                            final content =
                                filteredParts[index]['content'] ?? '';
                            return ExpansionTile(
                              title: Text(title),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: _buildFormattedText(
                                          content, _fontSize),
                                      style: TextStyle(
                                        fontSize: _fontSize,
                                        color: Colors.black,
                                      ),
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
}
