// email_service.dart
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EmailService {
  Future<bool> sendEmail(
      String subject, String nome, String email, String pergunta) async {
    final smtpServer = gmail(
      dotenv.env['EMAIL_USERNAME']!,
      dotenv.env['EMAIL_PASSWORD']!,
    );

    final message = Message()
      ..from = Address(
          dotenv.env['EMAIL_USERNAME']!, 'Paróquia Santo Antônio do Limão')
      ..recipients.add('santoantoniolimao@gmail.com')
      ..subject = subject
      ..text = '''
Nome: $nome
E-mail: $email

Pergunta:
$pergunta
''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Email enviado: ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Erro ao enviar e-mail: $e');
      return false;
    }
  }
}
