import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file/cross_file.dart'; // Para usar XFile
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailServiceAdulto {
  final String username = dotenv.env['EMAIL_USERNAME']!;
  final String password = dotenv.env['EMAIL_PASSWORD']!;
  final String fromEmail = dotenv.env['EMAIL_USERNAME']!;
  final String toEmail = 'saojoseosasco1@gmail.com';

  Future<bool> enviarInscricaoPorEmail(
      Map<String, String> formData, List<XFile> documentos) async {
    // Configurando o servidor SMTP do Gmail
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(fromEmail, 'Paróquia São José')
      ..recipients.add(toEmail) // Destinatário do e-mail
      ..subject = 'Nova inscrição de Catequese Adulto'
      ..text = _buildEmailBody(formData);

    // Adiciona os documentos como anexos
    for (final documento in documentos) {
      message.attachments.add(FileAttachment(File(documento.path)));
    }

    try {
      final sendReport = await send(message, smtpServer);
      print('Mensagem enviada com sucesso! ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Erro ao enviar o e-mail! $e');
      return false;
    }
  }

  String _buildEmailBody(Map<String, String> formData) {
    return '''
    ====================================
                   Catequizando
    ====================================
    Nome: ${formData['nome']}
    Local Nascimento: ${formData['localnasc']}
    Data Nascimento: ${formData['data']}
    Idade atual: ${formData['idade']}
    Bairro: ${formData['bairro']}
    Endereço: ${formData['endereco']}
    CEP: ${formData['cep']}
    Cidade: ${formData['cidade']}

    ========================================
               Informações do Adulto
    ========================================
    O adulto Estuda? ${formData['estuda']}
    Periodo Escolar: ${formData['periodo']}
    Batizado? ${formData['batismoAdulto']}
    1° Eucaristia? ${formData['adultoEucaristia']}

    ====================================
                      Contato
    ====================================
    E-mail: ${formData['email']}
    Telefone: (${formData['ddd']}) ${formData['telefone']}
    Estado civil: ${formData['estadoCivil']}
    Casado no Religioso: ${formData['casadosReligioso']}
    Frequenta a Missa de Domingo: ${formData['missadominical']}
    Horário que frequenta a Missa: ${formData['horariomissa']}
    ''';
  }
}
