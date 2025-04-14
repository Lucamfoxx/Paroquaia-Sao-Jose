import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class CheckinIgrejaPage extends StatefulWidget {
  const CheckinIgrejaPage({Key? key}) : super(key: key);

  @override
  _CheckinIgrejaPageState createState() => _CheckinIgrejaPageState();
}

class _CheckinIgrejaPageState extends State<CheckinIgrejaPage> {
  // Conjunto de datas em que o usuário realizou check-in.
  Set<DateTime> _checkinDates = {};
  late Future<void> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadCheckins();
  }

  // Obtém o arquivo de dados dos check-ins dentro da pasta "check-in".
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final dirPath = '${directory.path}/check-in';
    final dir = Directory(dirPath);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return File('$dirPath/checkins.json');
  }

  // Carrega os check-ins armazenados no arquivo JSON.
  Future<void> _loadCheckins() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        String contents = await file.readAsString();
        final data = json.decode(contents);
        List<dynamic> dates = data['checkins'];
        setState(() {
          _checkinDates = dates.map((d) => DateTime.parse(d)).toSet();
        });
      }
    } catch (e) {
      print('Erro ao carregar checkins: $e');
    }
  }

  // Salva os check-ins atuais no arquivo JSON na pasta "check-in".
  Future<void> _saveCheckins() async {
    final file = await _getLocalFile();
    List<String> dates =
        _checkinDates.map((d) => d.toIso8601String().split('T')[0]).toList();
    final data = {'checkins': dates};
    await file.writeAsString(json.encode(data));
  }

  // Registra o check-in do dia atual, se ainda não foi feito.
  void _markCheckin() {
    final today = DateTime.now();
    final checkinDate = DateTime(today.year, today.month, today.day);
    if (!_checkinDates.contains(checkinDate)) {
      setState(() {
        _checkinDates.add(checkinDate);
      });
      _saveCheckins();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Check-in realizado com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você já fez check-in hoje!')),
      );
    }
  }

  // Retorna a contagem de check-ins no mês atual.
  int _getMonthlyCheckinCount() {
    final today = DateTime.now();
    return _checkinDates
        .where((d) => d.year == today.year && d.month == today.month)
        .length;
  }

  // Calcula a proporção de dias marcados em relação ao total de dias do mês atual.
  double _getMonthlyProgress() {
    final today = DateTime.now();
    final totalDays = DateTime(today.year, today.month + 1, 0).day;
    final count = _getMonthlyCheckinCount();
    return count / totalDays;
  }

  // Exibe o histórico de check-ins com um ícone de exclusão para cada linha.
  Widget _buildHistoryList() {
    final sortedDates = _checkinDates.toList()..sort((a, b) => b.compareTo(a));
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            DateFormat('d MMMM yyyy', 'pt_BR').format(date),
            style: TextStyle(fontSize: 14),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () async {
              setState(() {
                _checkinDates.remove(date);
              });
              await _saveCheckins();
              setState(() {});
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dayNumber = DateFormat('d').format(today);
    final fullDate = DateFormat('d \'de\' MMMM', 'pt_BR').format(today);

    return FutureBuilder(
      future: _loadingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: const Text('Check-in na Igreja')),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Check-in na Igreja'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Card central exibindo a data e botão de check-in
                  Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Exibe o ano em fonte pequena
                            Text(
                              '${DateTime.now().year}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            // Exibe o dia (grande)
                            Text(
                              DateFormat('d').format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            // Exibe o mês em formato textual
                            Text(
                              DateFormat('MMMM', 'pt_BR')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 16),
                            // Botão "Marcar Presença"
                            ElevatedButton(
                              onPressed: _markCheckin,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                backgroundColor: Colors.blue,
                              ),
                              child: Text(
                                'Marcar Presença',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Seção de progresso mensal com LinearProgressIndicator
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Você marcou presença ${_getMonthlyCheckinCount()} vezes neste mês.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: _getMonthlyProgress(),
                          backgroundColor: Colors.grey[300],
                          color: Color.fromARGB(255, 108, 255, 34),
                          minHeight: 8,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // Histórico dos check-ins com opção de deletar cada um
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Histórico de Check-ins:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 8),
                        _buildHistoryList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
