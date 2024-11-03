import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'emailservice/email_service_batismo.dart';
import 'dateform/date_formatter_batismo.dart';
import 'customtxt/custom_text_form_field_batismo.dart';

class InscricoesBatismoPage extends StatefulWidget {
  @override
  _InscricoesBatismoPageState createState() => _InscricoesBatismoPageState();
}

class _InscricoesBatismoPageState extends State<InscricoesBatismoPage> {
  final _formKey = GlobalKey<FormState>();
  final EmailService _emailService = EmailService();
  final Map<String, TextEditingController> _controllers = {
    'nome': TextEditingController(),
    'data': TextEditingController(),
    'localnasc': TextEditingController(),
    'endereco': TextEditingController(),
    'bairro': TextEditingController(),
    'cep': TextEditingController(),
    'cidade': TextEditingController(),
    'email': TextEditingController(),
    'ddd': TextEditingController(),
    'telefone': TextEditingController(),
    'nomePai': TextEditingController(),
    'batismoPai': TextEditingController(),
    'nomeMae': TextEditingController(),
    'batismoMae': TextEditingController(),
    'casadosReligioso': TextEditingController(),
    'paroquiaCasamento': TextEditingController(),
    'dioceseCasamento': TextEditingController(),
    'cidadeParoquia': TextEditingController(),
    'bairroParoquia': TextEditingController(),
    'nomePadrinho': TextEditingController(),
    'telefonePadrinho': TextEditingController(),
    'batismoPadrinho': TextEditingController(),
    'crismaPadrinho': TextEditingController(),
    'estadoCivilPadrinho': TextEditingController(),
    'casadoPadrinho': TextEditingController(),
    'nomeMadrinha': TextEditingController(),
    'telefoneMadrinha': TextEditingController(),
    'batismoMadrinha': TextEditingController(),
    'crismaMadrinha': TextEditingController(),
    'estadoCivilMadrinha': TextEditingController(),
    'casadoMadrinha': TextEditingController(),
  };

  List<File> documentos = [];
  bool _enviandoEmail = false;
  String? _selectedDate;

  final List<String> _availableDates = [
    '30 de Novembro de 2024',
    '28 de Dezembro de 2024',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscrição de Batismo até 6 anos')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionTitle('Inscrição de Batismo infantil'),
              CustomTextFormField(
                  label: 'Nome do Batizando',
                  controller: _controllers['nome']!,
                  isRequired: true),
              CustomTextFormField(
                label: 'Data de Nascimento DD/MM/AAAA',
                controller: _controllers['data']!,
                isRequired: true,
                inputFormatters: [DateFormatter()],
              ),
              CustomTextFormField(
                  label: 'Local de Nascimento',
                  controller: _controllers['localnasc']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Endereço',
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
                label: 'E-mail',
                controller: _controllers['email']!,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
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
                      label: 'Whatsapp Telefone',
                      controller: _controllers['telefone']!,
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              _buildSectionTitle('Pais'),
              CustomTextFormField(
                  label: 'Nome do Pai',
                  controller: _controllers['nomePai']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Pai é Batizado?',
                  controller: _controllers['batismoPai']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Nome da Mãe',
                  controller: _controllers['nomeMae']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Mãe é Batizada?',
                  controller: _controllers['batismoMae']!,
                  isRequired: true),
              CustomTextFormField(
                  label: 'Casados no Religioso (sim ou não)',
                  controller: _controllers['casadosReligioso']!,
                  isRequired: true),
              _buildSectionTitle('Casamento Religioso'),
              CustomTextFormField(
                  label: 'Paroquia do Casamento',
                  controller: _controllers['paroquiaCasamento']!),
              CustomTextFormField(
                  label: 'Diocese da Paroquia',
                  controller: _controllers['dioceseCasamento']!),
              CustomTextFormField(
                  label: 'Cidade da Paroquia',
                  controller: _controllers['cidadeParoquia']!),
              CustomTextFormField(
                  label: 'Bairro da Paroquia',
                  controller: _controllers['bairroParoquia']!),
              _buildSectionTitle('Selecione a data para o batismo'),
              _buildDateDropdown(),
              _buildInfoContainerComBotao(
                  'TAXA do 10% Salario Mínimo no Ato da Inscrição (R\$140.00) \n',
                  '00020126360014BR.GOV.BCB.PIX0114630898250169035204000053039865802BR5922PAROQUIA SANTO ANTONIO6009SAO PAULO62070503***6304F155'),
              _buildInfoContainer(
                  'Documentos Necessários \n(Tire foto de todos os documentos)',
                  [
                    'Comprovante do Pagamento da Taxa ',
                    'RG Batizando',
                    'RG Padrinho',
                    'RG Madrinha',
                    'Comprovante de Residência',
                    'Certidão de Nascimento',
                    'Certidão de Batismo Católico Padrinho',
                    'Certidão de Batismo Católico Madrinha',
                  ]),
              _buildAddDocumentButton(),
              ..._buildDocumentPreviews(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedDate,
        items: _availableDates
            .map((date) => DropdownMenuItem<String>(
                  value: date,
                  child: Text(date),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedDate = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Data do Batismo',
          filled: true, // Adiciona fundo branco ao campo
          fillColor: Colors.white, // Define a cor do fundo como branco
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        dropdownColor: Colors.white, // Define o fundo da lista como branco
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

  Widget _buildInfoContainerComBotao(String title, String pixCode) {
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
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2),
          Text(
            '- Clique no botão abaixo '
            '\n- Abra o seu aplicativo de banco ou pagamentos'
            '\n- Procure a opção Pix.'
            '\n- Cole o codigo'
            '\n- Salve o comprovante',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: pixCode));
                _mostrarDialogo(context, 'PIX Copiado',
                    'Código PIX copiado para a área de transferência.');
              },
              child: Text(
                'Copiar Código PIX',
                style: TextStyle(color: Colors.blue),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String title, List<String> items) {
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
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ...items
              .map((item) => Text('- $item', style: TextStyle(fontSize: 16)))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildAddDocumentButton() {
    return ElevatedButton(
      onPressed: () => _showPicker(context),
      child: Text('Adicionar Documentos'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
                child: documento.path.endsWith('.jpg') ||
                        documento.path.endsWith('.jpeg') ||
                        documento.path.endsWith('.png')
                    ? Image.file(
                        documento,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        _getFileIcon(documento.path),
                        size: 50,
                      ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                documento.path.split('/').last,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removerDocumento(index),
            ),
          ],
        ),
      );
    }).toList();
  }

  IconData _getFileIcon(String path) {
    if (path.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (path.endsWith('.doc') || path.endsWith('.docx')) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
    }
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          setState(() {
            _enviandoEmail = true;
          });
          bool enviado = await _emailService.enviarInscricaoPorEmail(
            {
              ..._controllers.map((key, value) => MapEntry(key, value.text)),
              'dataBatismo': _selectedDate ?? 'Não selecionada',
            },
            documentos,
          );
          setState(() {
            _enviandoEmail = false;
          });
          if (enviado) {
            _mostrarDialogo(
                context, 'Email enviado', 'O email foi enviado com sucesso.');
            _limparCampos();
          } else {
            _mostrarDialogo(
                context, 'Erro', 'Ocorreu um erro ao enviar o email.');
          }
        }
      },
      child: _enviandoEmail
          ? CircularProgressIndicator()
          : Text('Enviar Inscrição'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
    );
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

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galeria'),
                onTap: () {
                  _selecionarImagem(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Câmera'),
                onTap: () {
                  _selecionarImagem(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file),
                title: Text('Documento'),
                onTap: () {
                  _selecionarDocumento();
                  Navigator.of(context).pop();
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

  void _limparCampos() {
    _controllers.forEach((key, controller) => controller.clear());
    setState(() {
      documentos.clear();
      _selectedDate = null;
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
