import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefasHojeCard extends StatelessWidget {
  final List<Tarefa> tarefasHoje;
  final ValueChanged<Tarefa>? aoAlternarConclusao;

  const TarefasHojeCard({
    super.key,
    required this.tarefasHoje,
    this.aoAlternarConclusao,
  });

  @override
  Widget build(BuildContext context) {
    if (tarefasHoje.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Suas tarefas aparecerão aqui.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: tarefasHoje.map((tarefa) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Checkbox(
              value: tarefa.concluida,
              onChanged: aoAlternarConclusao != null
                  ? (_) => aoAlternarConclusao!(tarefa)
                  : null,
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
            subtitle: Text('${tarefa.descricao} • ${tarefa.horario}'),
          ),
        );
      }).toList(),
    );
  }
}
