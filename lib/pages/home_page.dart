import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import '../widgets/resumo_card.dart';
import '../widgets/home_header.dart';
import '../widgets/tarefas_hoje_card.dart';

class HomePage extends StatelessWidget {
  final List<Tarefa> tarefas;
  final ValueChanged<Tarefa>? aoAlternarConclusao;

  const HomePage({super.key, required this.tarefas, this.aoAlternarConclusao});

  @override
  Widget build(BuildContext context) {
    final agora = DateTime.now();

    final meses = [
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];

    final dataFormatada =
        '${agora.day} de ${meses[agora.month - 1]} de ${agora.year}';

    final pendentes = tarefas.where((t) => !t.concluida).length;
    final concluidas = tarefas.where((t) => t.concluida).length;

    final tarefasDeHoje = tarefas.where((t) {
      return t.data.year == agora.year &&
          t.data.month == agora.month &&
          t.data.day == agora.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Agenda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView(
              children: [
                HomeHeader(data: dataFormatada),
                const SizedBox(height: 24),

                Text(
                  'Resumo do dia',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                LayoutBuilder(
                  builder: (context, constraints) {
                    final cards = [
                      ResumoCard(
                        icone: Icons.pending_actions,
                        quantidade: '$pendentes',
                        titulo: 'Pendentes',
                      ),
                      ResumoCard(
                        icone: Icons.task_alt,
                        quantidade: '$concluidas',
                        titulo: 'Concluídas',
                      ),
                    ];

                    if (constraints.maxWidth >= 450) {
                      return Row(
                        children: [
                          Expanded(child: cards[0]),
                          const SizedBox(width: 12),
                          Expanded(child: cards[1]),
                        ],
                      );
                    }

                    return Column(
                      children: [
                        cards[0],
                        const SizedBox(height: 12),
                        cards[1],
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),

                Text(
                  'Tarefas de hoje',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),

                TarefasHojeCard(
                  tarefasHoje: tarefasDeHoje,
                  aoAlternarConclusao: aoAlternarConclusao,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
