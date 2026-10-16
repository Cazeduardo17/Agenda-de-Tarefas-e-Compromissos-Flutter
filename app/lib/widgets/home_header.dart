import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String data;

  const HomeHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Olá!', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Organize suas tarefas e compromissos.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(data, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
