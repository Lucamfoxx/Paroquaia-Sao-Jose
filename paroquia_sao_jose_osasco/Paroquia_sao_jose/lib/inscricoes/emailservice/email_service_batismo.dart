// services/email_service.dart
import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  final String username = dotenv.env['EMAIL_USERNAME']!;
  final String password = dotenv.env['EMAIL_PASSWORD']!;
  final String fromEmail = dotenv.env['EMAIL_USERNAME']!;
  final String toEmail = 'saojoseosasco1@gmail.com';

  Future<bool> enviarInscricaoPorEmail(
      Map<String, String> formData, List<File> arquivos) async {
    // Configuração do servidor SMTP do Gmail
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(fromEmail, 'Paróquia São José')
      ..recipients.add(toEmail)
      ..subject = 'Nova inscrição de Batismo'
      ..text = _buildEmailBody(formData);

    // Anexando os arquivos enviados
    for (final arquivo in arquivos) {
      message.attachments.add(FileAttachment(arquivo));
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
                  BATIZANDO 
    ====================================
    Nome: ${formData['nome']}
    Data Nascimento: ${formData['data']}
    Local Nascimento: ${formData['localnasc']}
    Bairro: ${formData['bairro']}
    Cidade: ${formData['cidade']}
    Endereço: ${formData['endereco']}
    E-mail: ${formData['email']}
    Telefone: (${formData['ddd']}) ${formData['telefone']}
    CEP: ${formData['cep']}
    Data do Batismo: ${formData['dataBatismo'] ?? 'Não especificada'}

    ====================================
                  PAIS
    ====================================
    Nome Pai: ${formData['nomePai']}
    Pai é Batizado: ${formData['batismoPai']}
    Nome Mãe: ${formData['nomeMae']}
    Mãe é Batizada: ${formData['batismoMae']}
    Pais Casados no Religioso: ${formData['casadosReligioso']}

    ====================================
          CASAMENTO RELIGIOSO PAIS
    ====================================
    Paroquia do Casamento: ${formData['paroquiaCasamento']}
    Diocese da Paroquia do Casamento: ${formData['dioceseCasamento']}
    Bairro da Paroquia: ${formData['bairroParoquia']}
    Cidade da Paroquia: ${formData['cidadeParoquia']}

    ====================================
                PADRINHO
    ====================================
    Nome do Padrinho: ${formData['nomePadrinho']}
    Telefone Padrinho: ${formData['telefonePadrinho']}
    Padrinho é Batizado: ${formData['batismoPadrinho']}
    Padrinho é Crismado: ${formData['crismaPadrinho']}
    Estado civil Padrinho: ${formData['estadoCivilPadrinho']}
    Casado no religioso: ${formData['casadoPadrinho']}

    ====================================
                MADRINHA
    ====================================
    Nome da Madrinha: ${formData['nomeMadrinha']}
    Telefone Madrinha: ${formData['telefoneMadrinha']}
    Madrinha é Batizada: ${formData['batismoMadrinha']}
    Madrinha é Crismada: ${formData['crismaMadrinha']}
    Estado civil Madrinha: ${formData['estadoCivilMadrinha']}
    Casada no religioso: ${formData['casadoMadrinha']}
    ''';
  }
}
