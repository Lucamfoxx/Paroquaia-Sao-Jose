import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'emailservice/email_service_adulto.dart'; // Atualize com o nome correto do seu projeto
import 'dateform/date_formatter_adulto.dart'; // Atualize com o nome correto do seu projeto
import 'customtxt/custom_text_form_field_adulto.dart'; // Atualize com o nome correto do seu projeto

class InscricoesCatequeseAdultoPage extends StatefulWidget {
  @override
  _InscricoesCatequeseAdultoPageState createState() =>
      _InscricoesCatequeseAdultoPageState();
}

class _InscricoesCatequeseAdultoPageState
    extends State<InscricoesCatequeseAdultoPage> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  final EmailServiceAdulto _emailService = EmailServiceAdulto();
  final Map<String, TextEditingController> _controllers = {
    'nome': TextEditingController(),
    'localnasc': TextEditingController(),
    'data': TextEditingController(),
    'idade': TextEditingController(),
    'endereco': TextEditingController(),
    'bairro': TextEditingController(),
    'cep': TextEditingController(),
    'cidade': TextEditingController(),
    'estuda': TextEditingController(),
    'periodo': TextEditingController(),
    'batismoAdulto': TextEditingController(),
    'adultoEucaristia': TextEditingController(),
    'estadoCivil': TextEditingController(),
    'casadosReligioso': TextEditingController(),
    'missadominical': TextEditingController(),
    'horariomissa': TextEditingController(),
    'email': TextEditingController(),
    'ddd': TextEditingController(),
    'telefone': TextEditingController(),
  };

  List<XFile> documentos = [];
  bool _enviandoEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catequese de Adultos'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associando a chave global ao formulário
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Catequese de Adultos'),
              CustomTextFormFieldAdulto(
                label: 'Nome do Catequizando',
                controller: _controllers['nome']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o Nome do Catequizando';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Local de Nascimento',
                controller: _controllers['localnasc']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira Local de Nascimento';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Data de Nascimento DD/MM/AAAA',
                controller: _controllers['data']!,
                isRequired: true,
                inputFormatters: [DateFormatterAdulto()],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira data de Nascimento';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Idade atual',
                controller: _controllers['idade']!,
                isRequired: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira Idade atual';
                  }
                  int? idade = int.tryParse(value!);
                  if (idade == null || idade < 18) {
                    return 'Você deve ter pelo menos 18 anos';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Endereço atual',
                controller: _controllers['endereco']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu endereço';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Bairro',
                controller: _controllers['bairro']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o Bairro atual';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'CEP',
                controller: _controllers['cep']!,
                isRequired: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira o CEP';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Cidade',
                controller: _controllers['cidade']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira a Cidade';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'O adulto estuda e/ou trabalha?',
                controller: _controllers['estuda']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O adulto estuda e/ou trabalha?';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Qual horário de estudo ou trabalho?',
                controller: _controllers['periodo']!,
              ),
              _buildSectionTitle('Batismo e 1° Eucaristia'),
              CustomTextFormFieldAdulto(
                label: 'O adulto é Batizado?',
                controller: _controllers['batismoAdulto']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O adulto é Batizado?';
                  }
                  return null;
                },
              ),
              Text(
                'Caso a pessoa não seja batizada, ela será preparada e receberá o Batismo antes da 1° Eucaristia',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              CustomTextFormFieldAdulto(
                label: 'O adulto fez 1° Eucaristia?',
                controller: _controllers['adultoEucaristia']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'O adulto fez 1° Eucaristia?';
                  }
                  return null;
                },
              ),
              Text(
                'Caso a pessoa não tenha feito a 1° Eucaristia ela será preparada e receberá a 1° Eucaristia antes da Crisma',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              CustomTextFormFieldAdulto(
                label: 'Estado Civil',
                controller: _controllers['estadoCivil']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Estado Civil';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Casado no Religioso?',
                controller: _controllers['casadosReligioso']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Casado no Religioso?';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Participa da Santa Missa Dominical?',
                controller: _controllers['missadominical']!,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Participa da Santa Missa Dominical?';
                  }
                  return null;
                },
              ),
              CustomTextFormFieldAdulto(
                label: 'Horário da Missa que você Participa',
                controller: _controllers['horariomissa']!,
              ),
              CustomTextFormFieldAdulto(
                label: 'E-mail do Responsável',
                controller: _controllers['email']!,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Insira seu e-mail';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextFormFieldAdulto(
                      label: 'DDD',
                      controller: _controllers['ddd']!,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'DDD';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomTextFormFieldAdulto(
                      label: 'Whatsapp/Telefone',
                      controller: _controllers['telefone']!,
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Insira seu número de telefone';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              _buildDocumentSection(),
              _buildPhotoTipsSection(),
              ElevatedButton(
                onPressed: () => _showImageSourceActionSheet(context),
                child: Text('Adicionar Documento',
                    style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
              ),
              SizedBox(height: 20),
              ..._buildDocumentPreviews(),
              ElevatedButton(
                onPressed: _enviarInscricao,
                child: _enviandoEmail
                    ? CircularProgressIndicator()
                    : Text('Enviar Inscrição',
                        style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDocumentSection() {
    return Container(
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
            offset: Offset(0, 3),
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('- RG', style: TextStyle(fontSize: 16)),
          Text('- Comprovante de Residência', style: TextStyle(fontSize: 16)),
          Text('- Certidão de Nascimento', style: TextStyle(fontSize: 16)),
          Text('- Comprovante de 1° Eucaristia \n  (se tiver feito)',
              style: TextStyle(fontSize: 16)),
          Text('- Comprovante de Batismo \n  (se tiver feito)',
              style: TextStyle(fontSize: 16)),
          Text('- Uma foto de rosto', style: TextStyle(fontSize: 16)),
          Text('- Certidão de Casamento (se for casado)',
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPhotoTipsSection() {
    return Container(
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
            offset: Offset(0, 3),
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
    );
  }

  List<Widget> _buildDocumentPreviews() {
    return documentos.map((documento) {
      int index = documentos.indexOf(documento);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  // Adicione a funcionalidade para visualizar o documento
                },
                child: documento.path.endsWith('.pdf') ||
                        documento.path.endsWith('.doc') ||
                        documento.path.endsWith('.docx')
                    ? Icon(Icons.insert_drive_file, size: 100)
                    : Image.file(
                        File(documento.path),
                        width: 100,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removerDocumento(index);
              },
            ),
          ],
        ),
      );
    }).toList();
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Câmera'),
                onTap: () {
                  Navigator.pop(context);
                  _selecionarImagem(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  _selecionarImagem(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file),
                title: Text('Documento'),
                onTap: () {
                  Navigator.pop(context);
                  _selecionarDocumento();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selecionarImagem(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        documentos.add(pickedFile);
      });
    }
  }

  Future<void> _selecionarDocumento() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        documentos.add(XFile(result.files.single.path!));
      });
    }
  }

  void _removerDocumento(int index) {
    setState(() {
      documentos.removeAt(index);
    });
  }

  Future<void> _enviarInscricao() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _enviandoEmail = true;
      });

      Map<String, String> formData = {};
      _controllers.forEach((key, controller) {
        formData[key] = controller.text;
      });

      bool enviado =
          await _emailService.enviarInscricaoPorEmail(formData, documentos);

      setState(() {
        _enviandoEmail = false;
      });

      if (enviado) {
        _mostrarDialogo(
            context, 'Email enviado', 'O email foi enviado com sucesso.');
        _limparCampos();
      } else {
        _mostrarDialogo(context, 'Erro', 'Ocorreu um erro ao enviar o email.');
      }
    }
  }

  void _limparCampos() {
    _controllers.forEach((key, controller) {
      controller.clear();
    });

    setState(() {
      documentos.clear();
    });
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
