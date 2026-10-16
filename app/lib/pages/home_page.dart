import 'package:flutter/material.dart';
import '../widgets/resumo_card.dart';
import '../widgets/home_header.dart';
import '../widgets/tarefas_hoje_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      const ResumoCard(
                        icone: Icons.pending_actions,
                        quantidade: '3',
                        titulo: 'Pendentes',
                      ),
                      const ResumoCard(
                        icone: Icons.task_alt,
                        quantidade: '2',
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

                const TarefasHojeCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResumoCard(
    BuildContext context, {
    required IconData icone,
    required String quantidade,
    required String titulo,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone),
            const SizedBox(height: 12),
            Text(quantidade, style: Theme.of(context).textTheme.headlineMedium),
            Text(titulo),
          ],
        ),
      ),
    );
  }
}
