
import 'package:flutter/material.dart';

class ResumoCard extends StatelessWidget {
  final IconData icone;
  final String quantidade;
  final String titulo;

  const ResumoCard({
    super.key,
    required this.icone,
    required this.quantidade,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone),
            const SizedBox(height: 12),
            Text(
              quantidade,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(titulo),
          ],
        ),
      ),
    );
  }
}
