import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'emailservice/email_service_infantil.dart'; // Atualize com o nome correto do seu projeto
import 'dateform/date_formatter_infantil.dart'; // Atualize com o nome correto do seu projeto
import 'customtxt/custom_text_form_field_infantil.dart'; // Atualize com o nome correto do seu projeto

class CatequeseInfantilPage extends StatefulWidget {
  @override
  _CatequeseInfantilPageState createState() => _CatequeseInfantilPageState();
}

class _CatequeseInfantilPageState extends State<CatequeseInfantilPage> {
  final _formKey = GlobalKey<FormState>();
  final EmailService _emailService = EmailService();
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
    'batismoCrianca': TextEditingController(),
    'criancaEucaristia': TextEditingController(),
    'nomePai': TextEditingController(),
    'nomeMae': TextEditingController(),
    'email': TextEditingController(),
    'ddd': TextEditingController(),
    'telefone': TextEditingController(),
    'estadoCivil': TextEditingController(),
    'casadosReligioso': TextEditingController(),
    'missadominical': TextEditingController(),
    'horariomissa': TextEditingController(),
  };

  List<File> documentos = [];
  bool _enviandoEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Catequese Infantil')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Catequese Infantil'),
              CustomTextFormField(
                  label: 'Nome do Catequizando',
                  controller: _controllers['nome']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Local de Nascimento',
                  controller: _controllers['localnasc']!,
                  isRequired: true),
              CustomTextFormField(
                label: 'Data de Nascimento DD/MM/AAAA',
                controller: _controllers['data']!,
                isRequired: true,
                inputFormatters: [DateFormatter()],
              ),
              CustomTextFormField(
                  label: 'Idade atual',
                  controller: _controllers['idade']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Endereço atual',
                  controller: _controllers['endereco']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Bairro',
                  controller: _controllers['bairro']!,
                  isRequired: true),
              CustomTextFormField(
                label: 'CEP',
                controller: _controllers['cep']!,
                isRequired: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              CustomTextFormField(
                  label: 'Cidade',
                  controller: _controllers['cidade']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Criança Estuda?',
                  controller: _controllers['estuda']!,
                  isRequired: true),
              CustomTextFormField(
                label: 'Periodo Escolar (manhã/tarde/noite)',
                controller: _controllers['periodo']!,
                isRequired: true,
              ),
              _buildSectionTitle('Batismo e 1° Eucaristia'),
              CustomTextFormField(
                  label: 'Criança é Batizada?',
                  controller: _controllers['batismoCrianca']!,
                  isRequired: true),
              Text(
                'Caso a criança não seja batizada, ela será preparada e receberá o Batismo antes da 1° Eucaristia',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              CustomTextFormField(
                label: 'Criança fez 1° Eucaristia',
                controller: _controllers['criancaEucaristia']!,
                isRequired: true,
              ),
              Text(
                'Caso a criança não tenha feito a 1° Eucaristia ela será preparada e receberá a 1° Eucaristia antes da Crisma',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              _buildSectionTitle('Pais'),
              CustomTextFormField(
                  label: 'Nome do Pai',
                  controller: _controllers['nomePai']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Nome da Mãe',
                  controller: _controllers['nomeMae']!,
                  isRequired: true),
              CustomTextFormField(
                label: 'E-mail do Responsável',
                controller: _controllers['email']!,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextFormField(
                      label: 'DDD',
                      controller: _controllers['ddd']!,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomTextFormField(
                      label: 'Whatsapp/Telefone',
                      controller: _controllers['telefone']!,
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                  label: 'Estado Civil dos Pais',
                  controller: _controllers['estadoCivil']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Casados no Religioso?',
                  controller: _controllers['casadosReligioso']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Participa da Santa Missa Dominical?',
                  controller: _controllers['missadominical']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Horário da Missa que você Participa',
                  controller: _controllers['horariomissa']!),
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
          Text('- Uma foto de rosto da Criança (3x4)',
              style: TextStyle(fontSize: 16)),
          Text('- Certidão de Casamento dos Pais\n  (se forem casados)',
              style: TextStyle(fontSize: 16)),
          Text('- RG dos Pais', style: TextStyle(fontSize: 16)),
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
                        documento,
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
        documentos.add(File(pickedFile.path));
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
        documentos.add(File(result.files.single.path!));
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
