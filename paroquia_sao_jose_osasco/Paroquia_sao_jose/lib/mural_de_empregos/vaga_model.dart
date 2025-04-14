// vaga_model.dart
class Vaga {
  final String titulo;
  final String empresa;
  final String descricao;
  final String localizacao;
  final String tipoTrabalho;
  final String? salario;
  final String contato;

  Vaga({
    required this.titulo,
    required this.empresa,
    required this.descricao,
    required this.localizacao,
    required this.tipoTrabalho,
    this.salario,
    required this.contato,
  });
}
