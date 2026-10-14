import 'package:flutter/material.dart';

class TarefasHojeCard extends StatelessWidget {
  const TarefasHojeCard({super.key});

  @override
  Widget build(BuildContext context) {
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
}
