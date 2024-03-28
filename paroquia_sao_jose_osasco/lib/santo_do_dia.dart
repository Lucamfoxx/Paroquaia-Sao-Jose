import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SantoDoDia {
  final String text;
  final Image? image;

  SantoDoDia({required this.text, this.image});
}

class SantoDoDiaPage extends StatefulWidget {
  const SantoDoDiaPage({Key? key}) : super(key: key);

  @override
  _SantoDoDiaPageState createState() => _SantoDoDiaPageState();
}

class _SantoDoDiaPageState extends State<SantoDoDiaPage> {
  late SantoDoDia _santoDoDia;
  double _fontSize = 16.0;
  late DateTime _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadSantoDoDiaContent(_selectedDate);
  }

  Future<void> _loadSantoDoDiaContent(DateTime selectedDate) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String formattedDate =
          "${selectedDate.day.toString().padLeft(2, '0')}_${selectedDate.month.toString().padLeft(2, '0')}";

      String santoDoDiaText =
          await rootBundle.loadString('assets/santo_dia/txt/$formattedDate.txt');

      Image? santoDoDiaImage;
      bool imageExists = await rootBundle
          .load('assets/santo_dia/jpg/$formattedDate.jpg')
          .then((value) {
        santoDoDiaImage = Image.asset('assets/santo_dia/jpg/$formattedDate.jpg');
        return true;
      }).catchError((error) => false);

      setState(() {
        _santoDoDia = SantoDoDia(text: santoDoDiaText, image: imageExists ? santoDoDiaImage : null);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _santoDoDia = SantoDoDia(text: 'Erro ao carregar o conteúdo.');
        _isLoading = false;
      });
    }
  }

  void _navigateToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
    });
    _loadSantoDoDiaContent(_selectedDate);
  }

  void _navigateToNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
    });
    _loadSantoDoDiaContent(_selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _loadSantoDoDiaContent(picked);
    }
  }

  void _increaseFontSize() {
    setState(() {
      _fontSize += 1.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 1.0) {
        _fontSize -= 1.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Santo do Dia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _increaseFontSize,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _decreaseFontSize,
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Color.fromARGB(255, 255, 255, 255),
                            onPressed: _navigateToPreviousDay,
                          ),
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: Color.fromARGB(255, 255, 255, 255),
                            onPressed: _navigateToNextDay,
                          ),
                        ],
                      ),
                      if (_santoDoDia.image != null)
                        Container(
                          width: 500,
                          height: 500,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _santoDoDia.image!,
                          ),
                        ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _santoDoDia.text,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: _fontSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
