import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import 'cadastro_tarefa_page.dart';

class ListaTarefasPage extends StatelessWidget {
  final List<Tarefa> tarefas;
  final ValueChanged<int> aoAlternarConclusao;
  final void Function(int index, Tarefa tarefaEditada) aoEditarTarefa;
  final ValueChanged<int> aoRemoverTarefa;

  const ListaTarefasPage({
    super.key,
    required this.tarefas,
    required this.aoAlternarConclusao,
    required this.aoEditarTarefa,
    required this.aoRemoverTarefa,
  });

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: tarefas.isEmpty
                ? const Center(
                    child: Text('Nenhuma tarefa cadastrada até o momento.'),
                  )
                : ListView.separated(
                    itemCount: tarefas.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final tarefa = tarefas[index];

                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: tarefa.concluida,
                            onChanged: (_) => aoAlternarConclusao(index),
                          ),
                          title: Text(
                            tarefa.titulo,
                            style: TextStyle(
                              decoration: tarefa.concluida
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(tarefa.descricao),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 14),
                                  const SizedBox(width: 4),
                                  Text(_formatarData(tarefa.data)),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.access_time, size: 14),
                                  const SizedBox(width: 4),
                                  Text(tarefa.horario),
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                tooltip: 'Editar',
                                onPressed: () async {
                                  final tarefaEditada =
                                      await Navigator.push<Tarefa>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CadastroTarefaPage(
                                                tarefaParaEditar: tarefa,
                                              ),
                                        ),
                                      );

                                  if (tarefaEditada != null) {
                                    aoEditarTarefa(index, tarefaEditada);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                                tooltip: 'Excluir',
                                onPressed: () => aoRemoverTarefa(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
