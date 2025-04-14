// mural_empregos.dart
import 'package:flutter/material.dart';
import 'vaga_model.dart';
import 'cadastrar_vaga.dart';
import 'mural_vagas.dart';
import 'inscrever_vaga.dart';

class MuralEmpregosPage extends StatefulWidget {
  const MuralEmpregosPage({Key? key}) : super(key: key);

  @override
  _MuralEmpregosPageState createState() => _MuralEmpregosPageState();
}

class _MuralEmpregosPageState extends State<MuralEmpregosPage> {
  List<Vaga> vagas = [];

  // Nova função: navega para a página de inscrição passando a vaga selecionada
  Future<void> _inscreverVaga(Vaga vaga) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InscreverVagaPage(vaga: vaga),
      ),
    );
  }

  void _onVagaCadastrada(Vaga vaga) {
    setState(() {
      vagas.add(vaga);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Duas abas: Cadastrar Vaga e Mural de Vagas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mural de Empregos Católico'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Cadastrar Vaga'),
              Tab(text: 'Mural de Vagas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CadastrarVagaTab(onVagaCadastrada: _onVagaCadastrada),
            // Atualizado para usar o novo parâmetro onCandidatar
            MuralVagasTab(onCandidatar: _inscreverVaga),
          ],
        ),
      ),
    );
  }
}
