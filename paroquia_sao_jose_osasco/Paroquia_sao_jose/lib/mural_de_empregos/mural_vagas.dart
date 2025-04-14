import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'vaga_model.dart';
import 'inscrever_vaga.dart';

class MuralVagasTab extends StatefulWidget {
  final Function(Vaga) onCandidatar;

  const MuralVagasTab({Key? key, required this.onCandidatar}) : super(key: key);

  @override
  _MuralVagasTabState createState() => _MuralVagasTabState();
}

class _MuralVagasTabState extends State<MuralVagasTab> {
  List<Vaga> _vagas = [];
  bool _isLoading = true;
  String _filterQuery = '';

  // Variável que armazenará a URL do Gist obtida a partir do arquivo TXT
  String? _gistUrl;

  // Link direto do arquivo TXT no Google Drive (substitua pelo seu link)
  final String _txtUrl =
      'https://drive.google.com/uc?id=1gCxvA3BS3Oorzj-btGGiUtsMlgGebGTG&export=download';

  @override
  void initState() {
    super.initState();
    _fetchTxtFileUrl();
  }

  // Busca o arquivo TXT no Google Drive que contém a URL do Gist
  Future<void> _fetchTxtFileUrl() async {
    try {
      final response = await http.get(Uri.parse(_txtUrl));
      if (response.statusCode == 200) {
        setState(() {
          _gistUrl = response.body.trim();
        });
        _fetchVagasFromGist();
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

  // Utiliza a URL obtida para buscar o JSON com as vagas no Gist
  Future<void> _fetchVagasFromGist() async {
    if (_gistUrl == null) return;
    try {
      final response = await http.get(Uri.parse(_gistUrl!));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Converte o mapa de vagas para uma lista
        final vagasMap = data['vagas'] as Map<String, dynamic>;
        final vagasJson = vagasMap.values.toList();
        setState(() {
          _vagas = vagasJson
              .map((json) => Vaga(
                    titulo: json['titulo'] ?? '',
                    empresa: json['empresa'] ?? '',
                    descricao: json['descricao'] ?? '',
                    localizacao: json['localizacao'] ?? '',
                    tipoTrabalho: json['tipoTrabalho'] ?? '',
                    salario: json['salario'] ?? '',
                    contato: json['contato'] ?? '',
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

  @override
  Widget build(BuildContext context) {
    List<Vaga> vagasFiltradas = _vagas.where((vaga) {
      final query = _filterQuery.toLowerCase();
      return vaga.titulo.toLowerCase().contains(query) ||
          vaga.empresa.toLowerCase().contains(query) ||
          vaga.localizacao.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        Expanded(
          child: _isLoading
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        '    Carregando vagas disponíveis...',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                )
              : vagasFiltradas.isEmpty
                  ? const Center(child: Text('Nenhuma vaga encontrada.'))
                  : ListView.builder(
                      itemCount: vagasFiltradas.length,
                      itemBuilder: (context, index) {
                        final vaga = vagasFiltradas[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vaga.titulo,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('Empresa: ${vaga.empresa}'),
                                Text('Descrição: ${vaga.descricao}'),
                                Text('Local: ${vaga.localizacao}'),
                                Text('Tipo de Trabalho: ${vaga.tipoTrabalho}'),
                                if (vaga.salario?.isNotEmpty ?? false)
                                  Text('Salário: ${vaga.salario}'),
                                Text('Contato: ${vaga.contato}'),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          widget.onCandidatar(vaga),
                                      child: const Text('Inscreva-se'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
