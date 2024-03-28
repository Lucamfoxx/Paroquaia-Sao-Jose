import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Evento {
  final String titulo;
  final List<String> descricao;
  final DateTime dataInicio;
  final DateTime dataFim;

  Evento({
    required this.titulo,
    required this.descricao,
    required this.dataInicio,
    required this.dataFim,
  });

  factory Evento.fromSnapshot(DataSnapshot snapshot) {
    return Evento(
      titulo: snapshot.child('titulo').value != null ? snapshot.child('titulo').value as String : '',
      descricao: snapshot.child('descricao').value != null ? (snapshot.child('descricao').value as String).split('\n') : [],
      dataInicio: snapshot.child('data_inicio').value != null ? DateTime.parse(snapshot.child('data_inicio').value as String) : DateTime.now(),
      dataFim: snapshot.child('data_fim').value != null ? DateTime.parse(snapshot.child('data_fim').value as String) : DateTime.now(),
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
                  return EventoTile(evento: evento, fontSize: _fontSize);
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

class EventoTile extends StatefulWidget {
  final Evento evento;
  final double fontSize;

  const EventoTile({Key? key, required this.evento, required this.fontSize}) : super(key: key);

  @override
  _EventoTileState createState() => _EventoTileState();
}

class _EventoTileState extends State<EventoTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _expanded ? Colors.blue[100] : Colors.grey[200],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded( // Adicionado Expanded
                        child: Text(
                          widget.evento.titulo,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ],
                  ),
         
                SizedBox(height: 10),
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
                if (_expanded) ...[
                  SizedBox(height: 10),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
