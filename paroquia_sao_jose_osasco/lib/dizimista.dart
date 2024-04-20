import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart';

class DizimistaPage extends StatefulWidget {
  @override
  _DizimistaPageState createState() =>
      _DizimistaPageState();
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove caracteres não numéricos
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita o comprimento do texto
    if (newText.length > 8) {
      // Se tiver mais de 8 caracteres, não faz nenhuma alteração
      return oldValue;
    }

    // Adiciona automaticamente as barras para o formato DD/MM/AAAA
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 2 || i == 4) {
        formattedText += '/';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
class _DizimistaPageState extends State<DizimistaPage> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();




  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dddController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _localnascController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
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
          key: _formKey, // Associando a chave global ao formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título da página
              Text(
                'Inscrição para Dizimista',
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Campo de texto para o nome
              TextFormField(
                controller: _nomeController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o Nome do Dizimista';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nome do Dizimista',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              
              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _localnascController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira Local de Nascimento';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Local de Nascimento',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: _dataController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira data de Nascimento';
                  }
                  return null;
                },
                inputFormatters: [
                  // Adicionando o formatter para o formato de data
                  FilteringTextInputFormatter.singleLineFormatter,
                  _DateFormatter(),
                ],
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento DD/MM/AAAA',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              SizedBox(height: 10),
              // Campo de texto para o nome
              TextFormField(
                controller: _cpfController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'CPF';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'CPF',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),  
                  ),
                ),
                keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
              ),
              
              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _enderecoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu endereço';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Endereço atual',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _bairroController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o Bairro atual';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _cepController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o CEP';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'CEP',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
              ),

              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _cidadeController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira a Cidade';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Cidade',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

             
              SizedBox(height: 10),
              // Campo de texto para o e-mail
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu e-mail';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'E-mail ',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              // Campos de texto para DDD e número de telefone
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _dddController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'DDD';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'DDD',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _telefoneController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Insira seu número de telefone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Whatsapp/Telefone',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),


              SizedBox(height: 10),
              TextFormField(
                controller: _estadoCivilController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Estado Civil';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Estado Civil',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _casadosreligiosoController,
                                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira casado no Religioso?';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Casado no Religioso?',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: _contribuicaoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Contribuição Pix/Missa/Envelope';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Contribuição Pix/Missa/Envelope',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
                            SizedBox(height: 40),
              SizedBox(height: 20),
              // Botão para enviar a inscrição
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      _enviandoEmail = true;
                    });
                    bool enviado = await _enviarInscricaoPorEmail();
                    setState(() {
                      _enviandoEmail = false;
                    });
                    if (enviado) {
                      _mostrarDialogo(context, 'Email enviado',
                          'O email foi enviado com sucesso.');
                      _limparCampos(); // Reiniciar a página de cadastro
                    } else {
                      _mostrarDialogo(context, 'Erro',
                          'Ocorreu um erro ao enviar o email.');
                    }
                  }
                },
                child: _enviandoEmail
                    ? CircularProgressIndicator() // Mostra o indicador de carregamento se estiver enviando
                    : Text(
                        'Enviar Inscrição',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para selecionar uma imagem da galeria ou da câmera
  Future<void> _selecionarImagem(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        fotos.add(pickedFile);
      });
    }
  }

  // Função para remover uma imagem da lista
  void _removerImagem(int index) {
    setState(() {
      fotos.removeAt(index);
    });
  }

  // Função para enviar a inscrição por e-mail
  Future<bool> _enviarInscricaoPorEmail() async {
    final smtpServer = SmtpServer(
      'smtp.sendgrid.net',
      username: 'apikey',
      password: '',
      port: 587,
    );

    final message = Message()
      ..from = Address('santoantoniolimao@gmail.com', 'Paroquia santo antonio')
      ..recipients.add('santoantoniolimao@gmail.com')
      ..subject = 'Nova inscrição Dizimista'
      ..text = '''
        ====================================
                       Dizimista
        ====================================
        Nome: ${_nomeController.text}      
        Local Nascimento: ${_localnascController.text}
        Data Nascimento: ${_dataController.text}
        Bairro: ${_bairroController.text}
        Endereço: ${_enderecoController.text}
        CEP: ${_cepController.text}
        CPF: ${_cpfController.text}
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
      print('Menssagem enviada com sucesso! ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Error ao enviar o Email! $e');
      return false;
    }
  }

  // Função para limpar os controladores de texto e a lista de fotos
  void _limparCampos() {
    _nomeController.clear();
    _dataController.clear();
    _localnascController.clear();    
    _bairroController.clear();    
    _enderecoController.clear();
    _emailController.clear();
    _cepController.clear();
    _cidadeController.clear();
    _cpfController.clear();
    _estadoCivilController.clear();
    _casadosreligiosoController.clear();
    _dddController.clear();
    _telefoneController.clear();
    _contribuicaoController.clear();
    
    setState(() {
      fotos.clear();
    });
  }

  // Função para mostrar um diálogo na tela
  void _mostrarDialogo(BuildContext context, String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensagem),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
