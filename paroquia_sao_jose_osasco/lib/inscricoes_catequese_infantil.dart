import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/services.dart';

class CatequeseInfantilPage extends StatefulWidget {
  @override
  _CatequeseInfantilPageState createState() =>
      _CatequeseInfantilPageState();
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
class _CatequeseInfantilPageState extends State<CatequeseInfantilPage> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _idadeController = TextEditingController();



  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dddController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _localnascController = TextEditingController();
  TextEditingController _bairroController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _estudaController = TextEditingController();
  TextEditingController _periodoController = TextEditingController();  
  TextEditingController _batismoCriancaController = TextEditingController();
  TextEditingController _criancaEucaristiaController = TextEditingController();  
  TextEditingController _nomePaiController = TextEditingController();
  TextEditingController _nomeMaeController = TextEditingController();
  TextEditingController _estadoCivilController = TextEditingController();
  TextEditingController _casadosreligiosoController = TextEditingController();
  TextEditingController _missadominicalController = TextEditingController();
  TextEditingController _horariomissaController = TextEditingController();







  List<XFile> fotos = [];
  bool _enviandoEmail = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catequese Infantil '),
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
                'Catequese Infantil',
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
                    return 'Insira o Nome do Catequizando';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nome do Catequizando',
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
              TextFormField(
                controller: _idadeController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira Idade atual';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Idade atual',
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
              // Campo de texto para o endereço
              TextFormField(
                controller: _estudaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Criança Estuda?';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Criança Estuda?',
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
                controller: _periodoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Periodo Escolar';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Periodo Escolar manha/tarde/noite',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
Text('\nBatismo e 1° Eucaristia\n',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              

              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _batismoCriancaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Criança é Batizada';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Criança é Batizada',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Text(
                  'Caso a criança não seja batizada, ela será preparada e receberá o Batismo antes da 1° Eucaristia',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),

              SizedBox(height: 10),
              // Campo de texto para o endereço
              TextFormField(
                controller: _criancaEucaristiaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Criança fez 1° Eucaristia';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Criança fez 1° Eucaristia',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

Text(
                  'Caso a crinça não tenha feito a 1° Eucaristia ela será preparada e receberá a 1° Eucaristia antes da Crisma',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),

////////////////////////////////////////////////////////////////////////////
                Text('\nPais',
                  style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 30),
              TextFormField(
                controller: _nomePaiController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o nome do pai';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nome do Pai',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
                            

              
              SizedBox(height: 10),
              TextFormField(
                controller: _nomeMaeController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, insira o nome da mãe';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nome da Mãe',
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
                  labelText: 'E-mail do Responsável',
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
                    return 'Estado Civil do Pais';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Estado Civil do Pais',
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
                    return 'Casados no Religioso? ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Casados no Religioso?',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),



              SizedBox(height: 10),
              TextFormField(
                controller: _missadominicalController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Participa da Santa Missa Dominical? ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Participa da Santa Missa Dominical?',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),

              
              SizedBox(height: 10),
              TextFormField(
                controller: _horariomissaController,
                decoration: InputDecoration(
                  labelText: 'Horário da Missa que você Participa.',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
////////////////////////////////////////////////////////////////

              
              SizedBox(height: 20),
              // Container com dicas para tirar uma boa foto
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''Documentos Necessários
(Tire foto de todos os documentos)''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- RG',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- Comprovante de Residência',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- Certidão de Nascimento',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                                        Text(
                      '- Comprovante de 1° Eucaristia \n  (se tiver feito)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                                        Text(
                      '- Comprovante de Batismo \n  (se tiver feito)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                     Text(
                      '- Uma foto de rosto da Criança (3x4)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                                         Text(
                      '- Certidão de Casamento dos Pais\n  (se forem casados)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                                                             Text(
                      '- RG dos Pais',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
                                          Text(
                  'Nenhuma inscrição será aceita pela Secretaria se a documentação e a ficha não estiverem completas!',
                  style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              // Container com dicas para tirar uma boa foto
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dicas para tirar uma ótima foto do documento:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '- Tire a foto em um ambiente bem iluminado;',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- Evite sombras que possam obscurecer o documento;',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- Mantenha o documento reto e bem enquadrado na foto;',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- Certifique-se de que o texto do documento está nítido e legível.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    await _selecionarImagem(ImageSource.camera);
                  }
                },
                child: Text(
                  'Adicionar Foto',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              // Exibição das fotos selecionadas
              for (int i = 0; i < fotos.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Adicione a funcionalidade para visualizar a imagem
                          },
                          child: Image.file(
                            File(fotos[i].path),
                            width: 100,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removerImagem(i);
                        },
                      ),
                    ],
                  ),
                ),
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
      ..subject = 'Nova inscrição de Catequese Infantil'
      ..text = '''
        ====================================
                       Catequizando
        ====================================
        Nome: ${_nomeController.text}      
        Local Nascimento: ${_localnascController.text}
        Data Nascimento: ${_dataController.text}
        Idade atual: ${_idadeController.text}
        Bairro: ${_bairroController.text}
        Endereço: ${_enderecoController.text}
        CEP: ${_cepController.text}
        Cidade: ${_cidadeController.text}

        ========================================
                   Informações da Criança
        ========================================
        Criança Estuda? ${_estudaController.text}
        Periodo Escolar: ${_periodoController.text}
        Batizado? ${_batismoCriancaController.text}
        1° Eucaristia? ${_criancaEucaristiaController.text}


        ====================================
                        PAIS
        ====================================

        Nome Pai: ${_nomePaiController.text}
        Nome Mãe: ${_nomeMaeController.text}
        E-mail: ${_emailController.text}
        Telefone: (${_dddController.text}) ${_telefoneController.text}
        Estado civil dos Pais: ${_estadoCivilController.text}
        Pais Casados no Religioso: ${_casadosreligiosoController.text}
        Frequenta a Missa de Domingo: ${_missadominicalController.text}
        Horario que frequenta a Missa: ${_horariomissaController.text}


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
    _idadeController.clear();
    _localnascController.clear();    
    _bairroController.clear();    
    _enderecoController.clear();
    _emailController.clear();
    _cepController.clear();
    _cidadeController.clear();
    _estudaController.clear();
    _periodoController.clear();
    _batismoCriancaController.clear();
    _criancaEucaristiaController.clear();
    _nomePaiController.clear();
    _nomeMaeController.clear();
    _estadoCivilController.clear();
    _casadosreligiosoController.clear();
    _dddController.clear();
    _telefoneController.clear();
    _missadominicalController.clear();
    _horariomissaController.clear();

    
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
