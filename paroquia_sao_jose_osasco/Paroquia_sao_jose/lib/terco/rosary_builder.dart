import 'package:flutter/material.dart';

// Widget que representa uma conta do terço
class Bead extends StatefulWidget {
  final double size;
  final Color color;

  const Bead({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  _BeadState createState() => _BeadState();
}

class _BeadState extends State<Bead> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor =
              _currentColor == Colors.blue ? Colors.green : Colors.blue;
        });
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentColor,
        ),
      ),
    );
  }
}

// Página do rosário com a funcionalidade de seleção de santinho
class RosaryPage extends StatefulWidget {
  @override
  _RosaryPageState createState() => _RosaryPageState();
}

class _RosaryPageState extends State<RosaryPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedSantinho =
      'assets/santinho.png'; // Caminho do santinho padrão

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  // Método para construir o rosário com contas e o santinho selecionado
  List<Widget> buildRosary() {
    return [
      // Contas do terço
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 50, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 50, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 50, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 50, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      SizedBox(height: 20),
      // Imagem do santinho que abre o popup
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Escolha uma devoção"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSantinhoItem('assets/maria.png', 'Maria'),
                    _buildSantinhoItem('assets/santinho.png', 'São José'),
                  ],
                ),
              );
            },
          );
        },
        child: Image.asset(_selectedSantinho,
            height: 100), // Usando a imagem do santinho selecionado
      ),

      SizedBox(height: 20),

      Bead(size: 50, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 30, color: Colors.blue),
      Bead(size: 50, color: Colors.blue),

      SizedBox(height: 20),

      Image.asset('assets/cruz.png', height: 100),
    ];
  }

  // Função auxiliar para criar um item do popup com santinhos
  Widget _buildSantinhoItem(String imagePath, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSantinho =
              imagePath; // Atualiza a imagem do santinho selecionado
        });
        Navigator.pop(context); // Fecha o popup ao selecionar um santinho
      },
      child: Row(
        children: [
          Image.asset(imagePath, height: 50),
          SizedBox(width: 10),
          Text(name, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Terço",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: buildRosary(), // Chamada para exibir o terço
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 20,
          child: Opacity(
            opacity: 0.3,
            child: Column(
              children: [
                Icon(
                  Icons.arrow_upward,
                  size: 40,
                  color: Colors.grey,
                ),
                Text(
                  "Role para cima",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
