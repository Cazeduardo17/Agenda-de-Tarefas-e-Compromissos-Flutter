class Tarefa {
  String titulo;
  String descricao;
  DateTime data;
  String horario;
  bool concluida;

  Tarefa({
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.horario,
    this.concluida = false,
  });
  void alternarConclusao() {
    concluida = !concluida;
  }
}
