import 'package:flutter/material.dart';

class PreparacaoPage extends StatefulWidget {
  @override
  _PreparacaoPageState createState() => _PreparacaoPageState();
}

class _PreparacaoPageState extends State<PreparacaoPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToLeft() {
    try {
      _scrollController.animateTo(
        _scrollController.offset - MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } catch (e) {
      // Tratamento de erro
      print('Erro ao rolar para a esquerda: $e');
    }
  }

  void _scrollToRight() {
    try {
      _scrollController.animateTo(
        _scrollController.offset + MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } catch (e) {
      // Tratamento de erro
      print('Erro ao rolar para a direita: $e');
    }
  }

  Widget buildDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: DataTable(
        columnSpacing: 10,
        headingRowHeight: 60,
        dataRowHeight: 60,
        columns: _buildColumns(),
        rows: _buildRows(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preparações e Batizados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calendário das preparações e Batizados 2024',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: buildDataTable(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _scrollToLeft,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _scrollToRight,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    return [
      DataColumn(
        label: Text(
          'Sábado',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Abril',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Maio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Junho',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Julho',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Agosto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Setembro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Outubro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Novembro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      DataColumn(
        label: Text(
          'Dezembro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return [
      DataRow(cells: [
        DataCell(Text('Preparação-9h30  ')),
        DataCell(Text('20')),
        DataCell(Text('11')),
        DataCell(Text('15')),
        DataCell(Text('13')),
        DataCell(Text('10')),
        DataCell(Text('14')),
        DataCell(Text('19')),
        DataCell(Text('9')),
        DataCell(Text('14')),
      ]),
      DataRow(cells: [
        DataCell(Text('Batismo      -10h  ')),
        DataCell(Text('27')),
        DataCell(Text('25')),
        DataCell(Text('29')),
        DataCell(Text('27')),
        DataCell(Text('31')),
        DataCell(Text('28')),
        DataCell(Text('26')),
        DataCell(Text('30')),
        DataCell(Text('28')),
      ]),
    ];
  }
}
