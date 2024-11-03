import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'emailservice/email_service_jovem.dart'; // Atualize com o nome correto do seu projeto
import 'dateform/date_formatter_jovem.dart'; // Atualize com o nome correto do seu projeto
import 'customtxt/custom_text_form_field_jovem.dart'; // Atualize com o nome correto do seu projeto

class CatequeseJovemPage extends StatefulWidget {
  @override
  _CatequeseJovemPageState createState() => _CatequeseJovemPageState();
}

class _CatequeseJovemPageState extends State<CatequeseJovemPage> {
  final _formKey = GlobalKey<FormState>();
  final EmailServiceJovem _emailService = EmailServiceJovem();
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
    'batismoJovem': TextEditingController(),
    'jovemEucaristia': TextEditingController(),
    'crisma': TextEditingController(),
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
      appBar: AppBar(title: Text('Catequese Jovem')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Catequese Jovem'),
              CustomTextFormFieldJovem(
                  label: 'Nome do Jovem',
                  controller: _controllers['nome']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Local de Nascimento',
                  controller: _controllers['localnasc']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                label: 'Data de Nascimento DD/MM/AAAA',
                controller: _controllers['data']!,
                isRequired: true,
                inputFormatters: [DateFormatterJovem()],
              ),
              CustomTextFormFieldJovem(
                  label: 'Idade atual',
                  controller: _controllers['idade']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Endereço atual',
                  controller: _controllers['endereco']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Bairro',
                  controller: _controllers['bairro']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                label: 'CEP',
                controller: _controllers['cep']!,
                isRequired: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              CustomTextFormFieldJovem(
                  label: 'Cidade',
                  controller: _controllers['cidade']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Jovem Estuda?',
                  controller: _controllers['estuda']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                label: 'Periodo Escolar (manhã/tarde/noite)',
                controller: _controllers['periodo']!,
                isRequired: true,
              ),
              _buildSectionTitle('Batismo, 1° Eucaristia e Crisma'),
              CustomTextFormFieldJovem(
                  label: 'Jovem é Batizado?',
                  controller: _controllers['batismoJovem']!,
                  isRequired: true),
              Text(
                'Caso o jovem não seja batizado, ele será preparado e receberá o Batismo antes da 1° Eucaristia',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              CustomTextFormFieldJovem(
                label: 'Jovem fez 1° Eucaristia?',
                controller: _controllers['jovemEucaristia']!,
                isRequired: true,
              ),
              Text(
                'Caso o jovem não tenha feito a 1° Eucaristia ele será preparado e receberá a 1° Eucaristia antes da Crisma',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              CustomTextFormFieldJovem(
                label: 'Jovem fez Crisma?',
                controller: _controllers['crisma']!,
                isRequired: true,
              ),
              _buildSectionTitle('Pais'),
              CustomTextFormFieldJovem(
                  label: 'Nome do Pai',
                  controller: _controllers['nomePai']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Nome da Mãe',
                  controller: _controllers['nomeMae']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                label: 'E-mail do Responsável',
                controller: _controllers['email']!,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextFormFieldJovem(
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
                    child: CustomTextFormFieldJovem(
                      label: 'Whatsapp/Telefone',
                      controller: _controllers['telefone']!,
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              CustomTextFormFieldJovem(
                  label: 'Estado Civil dos Pais',
                  controller: _controllers['estadoCivil']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Casados no Religioso?',
                  controller: _controllers['casadosReligioso']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
                  label: 'Participa da Santa Missa Dominical?',
                  controller: _controllers['missadominical']!,
                  isRequired: true),
              CustomTextFormFieldJovem(
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
          Text('- Uma foto de rosto do Jovem (3x4)',
              style: TextStyle(fontSize: 16)),
          Text('- Certidão de Casamento dos Pais\n  (se forem casados)',
              style: TextStyle(fontSize: 16)),
          Text('- RG dos Pais', style: TextStyle(fontSize: 16)),
          Text('- Comprovante de Crisma \n  (se tiver feito)',
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
      Widget preview;
      if (documento.path.endsWith('.jpg') ||
          documento.path.endsWith('.jpeg') ||
          documento.path.endsWith('.png')) {
        preview = Image.file(
          File(documento.path),
          width: 100,
          height: 200,
          fit: BoxFit.cover,
        );
      } else {
        preview = Icon(Icons.insert_drive_file, size: 50);
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  // Adicione a funcionalidade para visualizar a imagem
                },
                child: preview,
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

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _enviarInscricao,
      child: _enviandoEmail
          ? CircularProgressIndicator()
          : Text('Enviar Inscrição'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
    );
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
