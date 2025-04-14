import 'package:flutter/material.dart';
import 'email_service_perguntas.dart';

class PublicPerguntaForm extends StatefulWidget {
  const PublicPerguntaForm({Key? key}) : super(key: key);

  @override
  _PublicPerguntaFormState createState() => _PublicPerguntaFormState();
}

class _PublicPerguntaFormState extends State<PublicPerguntaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  // Campo de e-mail removido para perguntas públicas
  final TextEditingController _perguntaController = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _perguntaController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      fillColor: Colors.white,
      filled: true,
    );
  }

  Future<void> _enviar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _enviando = true;
      });
      final emailService = EmailService();
      // Passa e-mail como vazio para perguntas públicas
      bool enviado = await emailService.sendEmail(
        'Perguntas para o padre',
        _nomeController.text,
        '',
        _perguntaController.text,
      );
      setState(() {
        _enviando = false;
      });
      if (enviado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pergunta enviada com sucesso!')),
        );
        _nomeController.clear();
        _perguntaController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar pergunta.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Envie sua pergunta para o padre',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nomeController,
              decoration:
                  _buildInputDecoration('Nome (apenas o primeiro nome)'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor, insira seu nome'
                  : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _perguntaController,
              decoration: _buildInputDecoration('Pergunta para o padre'),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor, insira sua pergunta'
                  : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviando ? null : _enviar,
              child: _enviando
                  ? CircularProgressIndicator()
                  : Text('Enviar Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfidencialPerguntaForm extends StatefulWidget {
  const ConfidencialPerguntaForm({Key? key}) : super(key: key);

  @override
  _ConfidencialPerguntaFormState createState() =>
      _ConfidencialPerguntaFormState();
}

class _ConfidencialPerguntaFormState extends State<ConfidencialPerguntaForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _perguntaController = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _perguntaController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      fillColor: Colors.white,
      filled: true,
    );
  }

  Future<void> _enviar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _enviando = true;
      });
      final emailService = EmailService();
      bool enviado = await emailService.sendEmail(
        'Perguntas confidenciais para o padre',
        _nomeController.text,
        _emailController.text,
        _perguntaController.text,
      );
      setState(() {
        _enviando = false;
      });
      if (enviado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pergunta confidencial enviada com sucesso!')),
        );
        _nomeController.clear();
        _emailController.clear();
        _perguntaController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar pergunta confidencial.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Envie sua pergunta confidencial para o padre',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            // Aviso adicional para perguntas confidenciais
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Todas as perguntas feitas aqui serão respondidas diretamente no seu e-mail. '
                'E não serão enviadas para o mural de perguntas públicas.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nomeController,
              decoration: _buildInputDecoration('Nome'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor, insira seu nome'
                  : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: _buildInputDecoration('E-mail'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor, insira seu e-mail'
                  : null,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _perguntaController,
              decoration:
                  _buildInputDecoration('Pergunta confidencial para o padre'),
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty
                  ? 'Por favor, insira sua pergunta confidencial'
                  : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _enviando ? null : _enviar,
              child: _enviando
                  ? CircularProgressIndicator()
                  : Text('Enviar Pergunta Confidencial'),
            ),
          ],
        ),
      ),
    );
  }
}
