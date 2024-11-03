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
    final titulo = snapshot.child('titulo').value as String? ?? '';
    final descricaoStr = snapshot.child('descricao').value as String? ?? '';
    final descricao = descricaoStr.split('\n');
    final dataInicioStr = snapshot.child('data_inicio').value as String? ?? '';
    final dataFimStr = snapshot.child('data_fim').value as String? ?? '';

    return Evento(
      titulo: titulo,
      descricao: descricao,
      dataInicio: DateTime.tryParse(dataInicioStr) ?? DateTime.now(),
      dataFim: DateTime.tryParse(dataFimStr) ?? DateTime.now(),
    );
  }

  bool get isAtivo {
    final agora = DateTime.now();
    return agora.isAfter(dataInicio) && agora.isBefore(dataFim);
  }
}

class NoticiasPage extends StatefulWidget {
  const NoticiasPage({Key? key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  final DatabaseReference _eventosRef = FirebaseDatabase.instance.ref();
  double _fontSize = 18.0;

  @override
  void initState() {
    super.initState();
    _eventosRef.keepSynced(true);
  }

  @override
  void dispose() {
    _eventosRef.keepSynced(false);
    super.dispose();
  }

  void _alterarFonte(double delta) {
    setState(() {
      _fontSize = (_fontSize + delta).clamp(12.0, 30.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avisos Paroquiais'),
        actions: [
          IconButton(
            onPressed: () => _alterarFonte(2.0),
            icon: const Icon(Icons.zoom_in),
          ),
          IconButton(
            onPressed: () => _alterarFonte(-2.0),
            icon: const Icon(Icons.zoom_out),
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: _eventosRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os eventos.'));
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('Nenhum evento encontrado.'));
          }

          final dataSnapshot = snapshot.data!.snapshot;
          final eventosMap = Map<String, dynamic>.from(
            dataSnapshot.value as Map<dynamic, dynamic>,
          );

          final eventos = eventosMap.entries
              .map((entry) {
                final eventSnapshot = dataSnapshot.child(entry.key);
                return Evento.fromSnapshot(eventSnapshot);
              })
              .where((evento) => DateTime.now().isBefore(evento.dataFim))
              .toList();

          eventos.sort((a, b) => a.dataInicio.compareTo(b.dataInicio));

          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return EventoTile(evento: evento, fontSize: _fontSize);
            },
          );
        },
      ),
    );
  }
}

class EventoTile extends StatefulWidget {
  final Evento evento;
  final double fontSize;

  const EventoTile({
    Key? key,
    required this.evento,
    required this.fontSize,
  }) : super(key: key);

  @override
  _EventoTileState createState() => _EventoTileState();
}

class _EventoTileState extends State<EventoTile>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDataInicio =
        DateFormat('dd/MM/yyyy').format(widget.evento.dataInicio);
    final formattedDataFim =
        DateFormat('dd/MM/yyyy').format(widget.evento.dataFim);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: _toggleExpanded,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _expanded ? Colors.blue[50] : Colors.grey[100],
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.evento.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RotationTransition(
                      turns: _arrowAnimation,
                      child: const Icon(Icons.expand_more, size: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Início: $formattedDataInicio',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fim: $formattedDataFim',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                if (_expanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.evento.descricao.map((descricao) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            descricao,
                            style: TextStyle(fontSize: widget.fontSize),
                          ),
                        );
                      }).toList(),
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
