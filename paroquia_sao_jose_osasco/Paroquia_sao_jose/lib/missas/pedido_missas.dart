import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class PedidoMissasPage extends StatefulWidget {
  @override
  _PedidoMissasPageState createState() => _PedidoMissasPageState();
}

class _PedidoMissasPageState extends State<PedidoMissasPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pedidoController = TextEditingController();
  bool _enviandoEmail = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _nomeController.dispose();
    _pedidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos de Missas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pedidos de Missas',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
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
                labelText: 'Pedidos de Missas',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            _buildInfoContainer(),
            SizedBox(height: 10),
            _buildCalendarContainer(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviandoEmail
                  ? null
                  : () async {
                      if (_nomeController.text.isEmpty ||
                          _pedidoController.text.isEmpty ||
                          _selectedDate == null) {
                        _mostrarDialogo(context, 'Erro',
                            'Todos os campos devem ser preenchidos.');
                        return;
                      }

                      setState(() {
                        _enviandoEmail = true;
                      });

                      bool enviado = await _enviarPedidoPorEmail();
                      setState(() {
                        _enviandoEmail = false;
                      });

                      if (enviado) {
                        _mostrarDialogo(context, 'Email enviado',
                            'O pedido foi enviado com sucesso.');
                        _limparCampos();
                      } else {
                        _mostrarDialogo(context, 'Erro',
                            'Ocorreu um erro ao enviar o pedido.');
                      }
                    },
              child: _enviandoEmail
                  ? CircularProgressIndicator()
                  : Text('Enviar Pedido'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Escolha a data para a missa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            'Selecione um dia disponível para a missa. As datas permitidas são de terça a sexta-feira.',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Fundo branco
        borderRadius: BorderRadius.circular(15.0), // Bordas arredondadas
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // Sombra para dar destaque
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: _buildCalendar(),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      locale: 'pt_BR', // Define o idioma para português do Brasil
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      focusedDay: _selectedDate ?? DateTime.now(),
      selectedDayPredicate: (day) => _selectedDate == day,
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue[200],
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.grey),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (_isAvailableDay(selectedDay)) {
          setState(() {
            _selectedDate = selectedDay;
          });
        }
      },
      enabledDayPredicate: _isAvailableDay,
    );
  }

  bool _isAvailableDay(DateTime day) {
    return day.weekday >= DateTime.tuesday && day.weekday <= DateTime.friday;
  }

  Future<bool> _enviarPedidoPorEmail() async {
    final smtpServer = gmail(
      dotenv.env['EMAIL_USERNAME']!,
      dotenv.env['EMAIL_PASSWORD']!,
    );

    final message = Message()
      ..from = Address(dotenv.env['EMAIL_USERNAME']!, 'Paróquia São José')
      ..recipients.add('saojoseosasco1@gmail.com')
      ..subject = 'Novo pedido de missas'
      ..text = '''
        Nome do Solicitante: ${_nomeController.text}
        Data da Missa: ${DateFormat('EEEE, d MMMM yyyy', 'pt_BR').format(_selectedDate!)}
        Pedidos de Missas: ${_pedidoController.text}
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
    setState(() {
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
