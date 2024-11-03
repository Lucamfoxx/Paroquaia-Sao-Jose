import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DizimistaPage extends StatefulWidget {
  @override
  _DizimistaPageState createState() => _DizimistaPageState();
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.length > 8) return oldValue;

    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) formattedText += '/';
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class _DizimistaPageState extends State<DizimistaPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dddController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _estadoCivilController = TextEditingController();
  TextEditingController _casadosreligiosoController = TextEditingController();
  TextEditingController _contribuicaoController = TextEditingController();

  List<XFile> fotos = [];
  bool _enviandoEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dizimista'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Inscrição para Dizimista',
                style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField('Nome do Dizimista', _nomeController),
              SizedBox(height: 10),
              _buildTextField(
                'Data de Nascimento DD/MM/AAAA',
                _dataController,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                  _DateFormatter()
                ],
              ),
              SizedBox(height: 10),
              _buildTextField('Endereço atual', _enderecoController),
              SizedBox(height: 10),
              _buildTextField('Bairro', _bairroController),
              SizedBox(height: 10),
              _buildTextField(
                'CEP',
                _cepController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 10),
              _buildTextField('Cidade', _cidadeController),
              SizedBox(height: 10),
              _buildTextField('E-mail', _emailController,
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTextField(
                      'DDD',
                      _dddController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: _buildTextField(
                      'Whatsapp/Telefone',
                      _telefoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _buildTextField('Estado Civil', _estadoCivilController),
              SizedBox(height: 10),
              _buildTextField(
                  'Casado no Religioso?', _casadosreligiosoController),
              SizedBox(height: 10),
              _buildTextField(
                  'Contribuição Pix/Missa/Envelope', _contribuicaoController),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() => _enviandoEmail = true);
                    bool enviado = await _enviarInscricaoPorEmail();
                    setState(() => _enviandoEmail = false);

                    String mensagem = enviado
                        ? 'O email foi enviado com sucesso.'
                        : 'Ocorreu um erro ao enviar o email.';
                    _mostrarDialogo(
                        context, enviado ? 'Email enviado' : 'Erro', mensagem);

                    if (enviado) _limparCampos();
                  }
                },
                child: _enviandoEmail
                    ? CircularProgressIndicator()
                    : Text('Enviar Inscrição'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller,
      validator: (value) => value?.isEmpty ?? true ? 'Insira $label' : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  Future<bool> _enviarInscricaoPorEmail() async {
    final smtpServer =
        gmail(dotenv.env['EMAIL_USERNAME']!, dotenv.env['EMAIL_PASSWORD']!);

    final message = Message()
      ..from = Address(dotenv.env['EMAIL_USERNAME']!, 'Paróquia São José')
      ..recipients.add('saojoseosasco1@gmail.com')
      ..subject = 'Nova inscrição Dizimista'
      ..text = '''
        ====================================
                       Dizimista
        ====================================
        Nome: ${_nomeController.text}      
        Data Nascimento: ${_dataController.text}
        Bairro: ${_bairroController.text}
        Endereço: ${_enderecoController.text}
        CEP: ${_cepController.text}
        Cidade: ${_cidadeController.text}
        E-mail: ${_emailController.text}
        Telefone: (${_dddController.text}) ${_telefoneController.text}
        Estado civil: ${_estadoCivilController.text}
        Casados no Religioso: ${_casadosreligiosoController.text}
        Forma de Contribuiçao: ${_contribuicaoController.text}
              ''';

    for (final foto in fotos) {
      message.attachments.add(FileAttachment(File(foto.path)));
    }

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensagem enviada com sucesso! ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Erro ao enviar o Email! $e');
      return false;
    }
  }

  void _limparCampos() {
    _nomeController.clear();
    _dataController.clear();
    _bairroController.clear();
    _enderecoController.clear();
    _emailController.clear();
    _cepController.clear();
    _cidadeController.clear();
    _estadoCivilController.clear();
    _casadosreligiosoController.clear();
    _dddController.clear();
    _telefoneController.clear();
    _contribuicaoController.clear();
    setState(() => fotos.clear());
  }

  void _mostrarDialogo(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
