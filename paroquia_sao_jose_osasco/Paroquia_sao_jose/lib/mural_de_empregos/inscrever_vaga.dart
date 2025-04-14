// inscrever_vaga.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'vaga_model.dart';

class InscreverVagaPage extends StatefulWidget {
  final Vaga vaga;

  const InscreverVagaPage({Key? key, required this.vaga}) : super(key: key);

  @override
  _InscreverVagaPageState createState() => _InscreverVagaPageState();
}

class _InscreverVagaPageState extends State<InscreverVagaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();

  bool _enviandoEmail = false;
  File? _anexo;
  String? _nomeArquivo;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _mensagemController.dispose();
    super.dispose();
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

  Future<bool> _enviarInscricaoPorEmail() async {
    final smtpServer = gmail(
      dotenv.env['EMAIL_USERNAME']!,
      dotenv.env['EMAIL_PASSWORD']!,
    );

    final message = Message()
      ..from = Address(
          dotenv.env['EMAIL_USERNAME']!, 'Paróquia Santo Antônio do Limão')
      ..recipients.add('santoantoniolimao@gmail.com')
      ..subject = 'Inscrição para vaga de ${widget.vaga.titulo}'
      ..text = '''
Dados do candidato:
Nome: ${_nomeController.text}
E-mail: ${_emailController.text}
Telefone: ${_telefoneController.text}
Mensagem: ${_mensagemController.text}

Informações da vaga:
Título: ${widget.vaga.titulo}
Empresa: ${widget.vaga.empresa}
Descrição: ${widget.vaga.descricao}
Local: ${widget.vaga.localizacao}
Tipo de Trabalho: ${widget.vaga.tipoTrabalho}
Salário: ${widget.vaga.salario}
Contato: ${widget.vaga.contato}
''';

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

  Future<void> _enviarInscricao() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _enviandoEmail = true;
      });

      bool enviado = await _enviarInscricaoPorEmail();

      setState(() {
        _enviandoEmail = false;
      });

      if (enviado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscrição enviada com sucesso!')),
        );
        _limparCampos();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar inscrição.')),
        );
      }
    }
  }

  // Método _limparCampos adicionado
  void _limparCampos() {
    _nomeController.clear();
    _emailController.clear();
    _telefoneController.clear();
    _mensagemController.clear();
    setState(() {
      _anexo = null;
      _nomeArquivo = null;
    });
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      fillColor: Colors.white,
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscrição para ${widget.vaga.titulo}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Inscreva-se para a vaga de ${widget.vaga.titulo} na empresa ${widget.vaga.empresa}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nomeController,
                decoration: _buildInputDecoration('Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _buildInputDecoration('E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: _buildInputDecoration('Telefone'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mensagemController,
                decoration: _buildInputDecoration('Mensagem (opcional)'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selecionarArquivo,
                      child: Text('Anexar Currículo'),
                    ),
                  ),
                  SizedBox(width: 10),
                  if (_nomeArquivo != null)
                    Expanded(
                      child: Text(
                        _nomeArquivo!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _enviandoEmail ? null : _enviarInscricao,
                child: _enviandoEmail
                    ? CircularProgressIndicator()
                    : Text('Inscrever-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
