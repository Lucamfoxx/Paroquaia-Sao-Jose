import 'package:flutter/material.dart';

class FestasPage extends StatefulWidget {
  @override
  _FestasPageState createState() => _FestasPageState();
}

class _FestasPageState extends State<FestasPage> {
  double _fontSize = 20.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      _fontSize -= 2.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Festas'),
        actions: [
          IconButton(
            icon: Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),SizedBox(height: 10)
        ],
      ),
      
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\nProgramação Religiosa',
                
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              EventSchedule(fontSize: _fontSize), // Pass font size to EventSchedule
            ],
          ),
        ),
      ),
    );
  }
}

class EventSchedule extends StatelessWidget {
  final double fontSize;

  const EventSchedule({
    Key? key,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        EventItem(
          date: 'Dia de São José',
          description:
              'O Dia de São José é comemorado anualmente em 19 de março.',
          fontSize: fontSize, // Pass font size to EventItem
        ),

      ],
    );
  }
}

class EventItem extends StatelessWidget {
  final String date;
  final String description;
  final double fontSize;

  const EventItem({
    Key? key,
    required this.date,
    required this.description,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
