import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; 

class Evento {
  final String titulo;
  final List<String> descricao;
  final DateTime dataInicio;
  final DateTime dataFim;

  Evento({required this.titulo, required this.descricao, required this.dataInicio, required this.dataFim});

  factory Evento.fromSnapshot(DataSnapshot snapshot) {
    return Evento(
      titulo: snapshot.child('titulo').value as String,
      descricao: (snapshot.child('descricao').value as String).split('\n'),
      dataInicio: DateTime.parse(snapshot.child('data_inicio').value as String),
      dataFim: DateTime.parse(snapshot.child('data_fim').value as String),
    );
  }

  bool get isAtivo {
    final agora = DateTime.now();
    return agora.isAfter(dataInicio) && agora.isBefore(dataFim);
  }
}

class NoticiasPage extends StatefulWidget {
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  final DatabaseReference _eventosRef = FirebaseDatabase.instance.ref();
  double _fontSize = 18.0;

  void _aumentarFonte() {
    setState(() {
      _fontSize += 2.0;
    });
  }

  void _diminuirFonte() {
    setState(() {
      if (_fontSize > 2.0) {
        _fontSize -= 2.0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _eventosRef.keepSynced(true); // Manter os dados sincronizados mesmo quando a página não estiver ativa
  }

  @override
  void dispose() {
    _eventosRef.keepSynced(false); // Desativar a sincronização dos dados ao sair da página
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        actions: [
          IconButton(
            onPressed: _aumentarFonte,
            icon: Icon(Icons.zoom_in),
          ),
          IconButton(
            onPressed: _diminuirFonte,
            icon: Icon(Icons.zoom_out),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _eventosRef.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          if (snapshot.hasData && !snapshot.hasError) {
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.value != null) {
              Map<dynamic, dynamic> eventosMap = dataSnapshot.value as Map<dynamic, dynamic>;
              List<Evento> eventos = [];
              eventosMap.forEach((key, value) {
                DataSnapshot eventSnapshot = dataSnapshot.child(key);
                Evento evento = Evento.fromSnapshot(eventSnapshot);
                eventos.add(evento);
              });
              
              eventos.sort((a, b) => a.dataInicio.compareTo(b.dataInicio));
              
              return ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  Evento evento = eventos[index];
                  return NoticiaTile(evento: evento, fontSize: _fontSize);
                },
              );
            } else {
              return Center(child: Text('Nenhum evento encontrado.'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class NoticiaTile extends StatefulWidget {
  final Evento evento;
  final double fontSize;

  const NoticiaTile({Key? key, required this.evento, required this.fontSize}) : super(key: key);

  @override
  _NoticiaTileState createState() => _NoticiaTileState();
}
class _NoticiaTileState extends State<NoticiaTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              widget.evento.titulo,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (_expanded) ...[
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Início: ${DateFormat('dd/MM/yyyy').format(widget.evento.dataInicio)}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Fim: ${DateFormat('dd/MM/yyyy').format(widget.evento.dataFim)}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.evento.descricao.map((descricao) {
                    return Text(
                      descricao,
                      style: TextStyle(fontSize: widget.fontSize),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}