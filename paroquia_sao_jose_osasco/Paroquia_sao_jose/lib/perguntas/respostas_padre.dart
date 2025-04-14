import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Resposta {
  final String nome;
  final String pergunta;
  final String resposta;

  Resposta({
    required this.nome,
    required this.pergunta,
    required this.resposta,
  });
}

class RespostasPadrePage extends StatefulWidget {
  const RespostasPadrePage({Key? key}) : super(key: key);

  @override
  _RespostasPadrePageState createState() => _RespostasPadrePageState();
}

class _RespostasPadrePageState extends State<RespostasPadrePage> {
  List<Resposta> _respostas = [];
  bool _isLoading = true;
  String? _gistUrl;

  // Link direto do arquivo TXT no Google Drive (substitua pelo seu link)
  final String _txtUrl =
      'https://drive.google.com/uc?id=14VSgrjPjwCia4nEJ4pkz79pXjuZS0Mby&export=download';

  @override
  void initState() {
    super.initState();
    _fetchTxtFileUrl();
  }

  String _getQuestionTitle(String question) {
    int index = question.indexOf('?');
    if (index != -1) {
      return question.substring(0, index + 1);
    }
    return question;
  }

  // Busca o arquivo TXT no Google Drive que contém a URL do gist
  Future<void> _fetchTxtFileUrl() async {
    try {
      final response = await http.get(Uri.parse(_txtUrl));
      if (response.statusCode == 200) {
        setState(() {
          _gistUrl = response.body.trim();
        });
        _fetchRespostasFromGist();
      } else {
        print('Erro ao carregar arquivo TXT: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Erro ao carregar arquivo TXT: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Usa a URL obtida para buscar o JSON com as respostas do gist
  Future<void> _fetchRespostasFromGist() async {
    if (_gistUrl == null) return;
    try {
      final response = await http.get(Uri.parse(_gistUrl!));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Supondo que o JSON possui um dicionário sob a chave "respostas"
        final respostasMap = data['respostas'] as Map<String, dynamic>;
        final sortedKeys = respostasMap.keys.toList()
          ..sort((a, b) {
            final numA = int.tryParse(a.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
            final numB = int.tryParse(b.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
            return numB.compareTo(numA); // ordena do maior para o menor número
          });
        final respostasList =
            sortedKeys.map((key) => respostasMap[key]).toList();
        setState(() {
          _respostas = respostasList
              .map((json) => Resposta(
                    nome: json['nome'] ?? '',
                    pergunta: json['pergunta'] ?? '',
                    resposta: json['resposta'] ?? '',
                  ))
              .toList();
          _isLoading = false;
        });
      } else {
        print('Erro ao carregar JSON do gist: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Erro ao carregar JSON do gist: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildRespostaCard(Resposta resposta) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          _getQuestionTitle(resposta.pergunta),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${resposta.nome}'),
                SizedBox(height: 8),
                Text('Resposta: ${resposta.resposta}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Respostas do padre'),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Carregando novas perguntas e respostas...',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            )
          : _respostas.isEmpty
              ? Center(child: Text('Nenhuma resposta disponível.'))
              : ListView.builder(
                  itemCount: _respostas.length,
                  itemBuilder: (context, index) {
                    final resposta = _respostas[index];
                    return _buildRespostaCard(resposta);
                  },
                ),
    );
  }
}
