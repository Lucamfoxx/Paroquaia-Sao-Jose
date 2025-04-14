import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:file_picker/file_picker.dart';
import 'vaga_model.dart';

class CadastrarVagaTab extends StatefulWidget {
  // Caso queira utilizar o retorno para atualizar uma lista interna, mantenha onVagaCadastrada.
  // Agora, a função principal é enviar o e-mail com os dados da vaga.
  final Function(Vaga)? onVagaCadastrada;

  const CadastrarVagaTab({Key? key, this.onVagaCadastrada}) : super(key: key);

  @override
  _CadastrarVagaTabState createState() => _CadastrarVagaTabState();
}

class _CadastrarVagaTabState extends State<CadastrarVagaTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();

  String _selectedTipoTrabalho = 'CLT';
  final List<String> _tipoTrabalhoOptions = [
    'CLT',
    'Freelancer',
    'Estágio',
    'Voluntário',
  ];

  bool _enviandoEmail = false;
  File? _anexo;
  String? _nomeArquivo;

  @override
  void dispose() {
    _tituloController.dispose();
    _empresaController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    _salarioController.dispose();
    _contatoController.dispose();
    super.dispose();
  }

  Future<bool> _enviarVagaPorEmail() async {
    final smtpServer = gmail(
      dotenv.env['EMAIL_USERNAME']!,
      dotenv.env['EMAIL_PASSWORD']!,
    );

    final message = Message()
      ..from = Address(
          dotenv.env['EMAIL_USERNAME']!, 'Paróquia Santo Antônio do Limão')
      ..recipients.add('santoantoniolimao@gmail.com')
      ..subject = 'Novo Cadastro de Vaga'
      ..text = '''
Título da Vaga: ${_tituloController.text}
Empresa: ${_empresaController.text}
Descrição: ${_descricaoController.text}
Localização: ${_localizacaoController.text}
Tipo de Trabalho: $_selectedTipoTrabalho
Salário: ${_salarioController.text}
Contato: ${_contatoController.text}
''';

    // Se um arquivo foi selecionado, adiciona como anexo
    if (_anexo != null) {
      message.attachments.add(FileAttachment(_anexo!));
    }

    try {
      final sendReport = await send(message, smtpServer);
      print('Email enviado: ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Erro ao enviar e-mail: $e');
      return false;
    }
  }

  Future<void> _cadastrarVaga() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _enviandoEmail = true;
      });

      bool enviado = await _enviarVagaPorEmail();

      setState(() {
        _enviandoEmail = false;
      });

      if (enviado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vaga enviada por e-mail com sucesso!')),
        );
        // Se desejar também atualizar uma lista interna, descomente a linha abaixo:
        // widget.onVagaCadastrada?.call(Vaga(
        //   titulo: _tituloController.text,
        //   empresa: _empresaController.text,
        //   descricao: _descricaoController.text,
        //   localizacao: _localizacaoController.text,
        //   tipoTrabalho: _selectedTipoTrabalho,
        //   salario: _salarioController.text,
        //   contato: _contatoController.text,
        // ));
        _limparCampos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocorreu um erro ao enviar o e-mail.')),
        );
      }
    }
  }

  Future<void> _selecionarArquivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        _anexo = File(result.files.single.path!);
        _nomeArquivo = result.files.single.name;
      });
    }
  }

  void _limparCampos() {
    _tituloController.clear();
    _empresaController.clear();
    _descricaoController.clear();
    _localizacaoController.clear();
    _salarioController.clear();
    _contatoController.clear();
    setState(() {
      _selectedTipoTrabalho = _tipoTrabalhoOptions[0];
      _anexo = null;
      _nomeArquivo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Função para criar InputDecoration com fundo branco
    InputDecoration _buildInputDecoration(String label) {
      return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Cadastrar Vaga',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _tituloController,
              decoration: _buildInputDecoration('Título da Vaga'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o título da vaga';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _empresaController,
              decoration:
                  _buildInputDecoration('Nome da Empresa/Estabelecimento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o nome da empresa';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descricaoController,
              decoration: _buildInputDecoration('Descrição da Vaga'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma descrição da vaga';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _localizacaoController,
              decoration: _buildInputDecoration('Localização'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a localização';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTipoTrabalho,
              decoration: _buildInputDecoration('Tipo de Trabalho'),
              items: _tipoTrabalhoOptions
                  .map((tipo) => DropdownMenuItem<String>(
                        value: tipo,
                        child: Text(tipo),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTipoTrabalho = value!;
                });
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _salarioController,
              decoration: _buildInputDecoration('Salário (opcional)'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _contatoController,
              decoration: _buildInputDecoration('Contato (E-mail ou WhatsApp)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um contato';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            // Botão para selecionar um arquivo
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selecionarArquivo,
                    child: Text('Anexar Arquivo'),
                  ),
                ),
                SizedBox(width: 10),
                if (_nomeArquivo != null)
                  Expanded(
                    child: Text(
                      _nomeArquivo!,
                      style: TextStyle(fontStyle: FontStyle.italic),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviandoEmail ? null : _cadastrarVaga,
              child: _enviandoEmail
                  ? CircularProgressIndicator()
                  : Text('Cadastrar Vaga'),
            ),
          ],
        ),
      ),
    );
  }
}
