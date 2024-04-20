import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class PedidoIntencoesPage extends StatefulWidget {
  @override
  _PedidoIntencoesPageState createState() => _PedidoIntencoesPageState();
}

class _PedidoIntencoesPageState extends State<PedidoIntencoesPage> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _pedidoController = TextEditingController();
  bool _enviandoEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos de Intenções'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pedidos de Intenções',
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do Solicitante',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _pedidoController,
              decoration: InputDecoration(
                labelText: 'Pedidos de Intenção',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              maxLines: 3, // Para permitir várias linhas de texto
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviandoEmail ? null : () async {
                setState(() {
                  _enviandoEmail = true;
                });
                bool enviado = await _enviarPedidoPorEmail();
                setState(() {
                  _enviandoEmail = false;
                });
                if (enviado) {
                  _mostrarDialogo(
                      context, 'Email enviado', 'O pedido foi enviado com sucesso.');
                  _limparCampos(); // Reiniciar a página após envio bem-sucedido
                } else {
                  _mostrarDialogo(context, 'Erro', 'Ocorreu um erro ao enviar o pedido.');
                }
              },
              child: _enviandoEmail ? CircularProgressIndicator() : Text('Enviar Pedido'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _enviarPedidoPorEmail() async {
    final smtpServer = SmtpServer(
      'smtp.sendgrid.net',
      username: 'apikey',
      password: '',
      port: 587,
    );

    final message = Message()
      ..from = Address('santoantoniolimao@gmail.com', 'Paroquia santo antonio')
      ..recipients.add('santoantoniolimao@gmail.com')
      ..subject = 'Novo pedido de intenção'
      ..text = '''
        Nome do Pedinte: ${_nomeController.text}
        Pedidos de Intenção: ${_pedidoController.text}
      ''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }

  void _limparCampos() {
    _nomeController.clear();
    _pedidoController.clear();
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
